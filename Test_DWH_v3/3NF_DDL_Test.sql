SET ROLE postgres;

CREATE SCHEMA IF NOT EXISTS bl_3nf;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM pg_type t
        JOIN pg_namespace n ON t.typnamespace = n.oid
        WHERE n.nspname = 'bl_3nf' AND 
        	t.typname = 'type_order'
    ) THEN
        CREATE TYPE bl_3nf.type_order AS ENUM ('ONLINE', 'OFFLINE', 'N.A.');
    END IF;
   
    IF NOT EXISTS (
        SELECT 1 
        FROM pg_type t
        JOIN pg_namespace n ON t.typnamespace = n.oid
        WHERE n.nspname = 'bl_3nf' AND 
        	t.typname = 'type_offline_order'
    ) THEN
        CREATE TYPE bl_3nf.type_offline_order AS ENUM ('IN', 'OUT', 'N.A.');
    END IF;
END $$;

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_couriers_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_deliveries_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_customers_scd_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_districts_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_addresses_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_employees_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_pizzas_types_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_pizzas_sizes_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_pizzas_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_orders_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;


CREATE TABLE IF NOT EXISTS bl_3nf.ce_couriers(
	courier_id bigint PRIMARY KEY,
	courier_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	courier_full_name varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT couriers_unique UNIQUE (courier_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_deliveries(
	delivery_id bigint PRIMARY KEY,
	delivery_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	delivery_name varchar(255) NOT NULL,
	courier_id int NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT delivery_courier_fk FOREIGN KEY (courier_id) REFERENCES bl_3nf.ce_couriers(courier_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT deliveries_unique UNIQUE (delivery_src_id, courier_id)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_customers_scd(
	customer_id bigint,
	customer_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	customer_full_name varchar(255) NOT NULL,
	is_active varchar(1) NOT NULL,
	start_dt timestamp NOT NULL,
	end_dt timestamp NOT NULL,
	insert_dt timestamp NOT NULL,
	CONSTRAINT customers_scd_pk PRIMARY KEY (customer_id, start_dt)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_districts(
	district_id bigint PRIMARY KEY,
	district_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	district_name varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT districts_unique UNIQUE (district_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_addresses(
	address_id bigint PRIMARY KEY,
	address_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	address_name varchar(255) NOT NULL,
	district_id int NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT address_district_fk FOREIGN KEY (district_id) REFERENCES bl_3nf.ce_districts(district_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT addresses_unique UNIQUE (address_src_id, district_id)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_employees(
	employee_id bigint PRIMARY KEY,
	employee_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	employee_full_name varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT employees_unique UNIQUE (employee_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_pizzas_types(
	pizza_type_id bigint PRIMARY KEY,
	pizza_type_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_type_name varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT pizza_type_unique UNIQUE (pizza_type_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_pizzas_sizes(
	pizza_size_id bigint PRIMARY KEY,
	pizza_size_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_size_name varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT pizza_sizes_unique UNIQUE (pizza_size_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_pizzas(
	pizza_id bigint PRIMARY KEY,
	pizza_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_name varchar(255) NOT NULL,
	pizza_type_id int NOT NULL,
	pizza_size_id int NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT pizza_unique UNIQUE (pizza_src_id, source_system, source_entity),
	CONSTRAINT pizza_pizza_type_fk FOREIGN KEY (pizza_type_id) REFERENCES bl_3nf.ce_pizzas_types(pizza_type_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT pizza_pizza_size_fk FOREIGN KEY (pizza_size_id) REFERENCES bl_3nf.ce_pizzas_sizes(pizza_size_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_orders(
	order_id bigint PRIMARY KEY,
	order_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	order_timestamp timestamp NOT NULL,
	order_type bl_3nf.type_order NOT NULL,
	offline_order_type bl_3nf.type_offline_order NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT order_unique UNIQUE (order_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_sales(
	order_id int NOT NULL,
	employee_id int NOT NULL,
	delivery_id int NOT NULL,
	customer_id int NOT NULL,
	address_id int NOT NULL,
	pizza_id int NOT NULL,
	quantity int NOT NULL,
	price decimal(6,2) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT sales_pk PRIMARY KEY (order_id, employee_id, delivery_id, customer_id, address_id, pizza_id),
	CONSTRAINT sale_order_fk FOREIGN KEY (order_id) REFERENCES bl_3nf.ce_orders(order_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT sale_pizza_fk FOREIGN KEY (pizza_id) REFERENCES bl_3nf.ce_pizzas(pizza_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT sale_employee_fk FOREIGN KEY (employee_id) REFERENCES bl_3nf.ce_employees(employee_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT sale_delivery_fk FOREIGN KEY (delivery_id) REFERENCES bl_3nf.ce_deliveries(delivery_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT sale_address_fk FOREIGN KEY (address_id) REFERENCES bl_3nf.ce_addresses(address_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

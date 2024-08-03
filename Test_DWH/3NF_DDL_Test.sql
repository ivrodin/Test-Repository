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

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_customers_id_seq
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

CREATE SEQUENCE IF NOT EXISTS bl_3nf.ce_pizzas_scd_id_seq
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
	courier_full_name varchar(30) NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT couriers_unique UNIQUE (courier_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_deliveries(
	delivery_id bigint PRIMARY KEY,
	delivery_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	delivery_name varchar(20) NOT NULL,
	courier_id int NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT delivery_courier_fk FOREIGN KEY (courier_id) REFERENCES bl_3nf.ce_couriers(courier_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT deliveries_unique UNIQUE (delivery_src_id, courier_id)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_customers(
	customer_id bigint PRIMARY KEY,
	customer_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	customer_full_name varchar(20) NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT customers_unique UNIQUE (customer_id, customer_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_districts(
	district_id bigint PRIMARY KEY,
	district_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	district_name varchar(20) NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT districts_unique UNIQUE (district_id, district_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_addresses(
	address_id bigint PRIMARY KEY,
	address_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	address_name varchar(20) NOT NULL,
	district_id int NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT address_district_fk FOREIGN KEY (district_id) REFERENCES bl_3nf.ce_districts(district_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT addresses_unique UNIQUE (address_id, address_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_employees(
	employee_id bigint PRIMARY KEY,
	employee_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	employee_full_name varchar(20) NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT employees_unique UNIQUE (employee_id, employee_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_pizzas_types(
	pizza_type_id bigint PRIMARY KEY,
	pizza_type_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_type_name varchar(20) NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT pizza_type_unique UNIQUE (pizza_type_id, pizza_type_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_pizzas_sizes(
	pizza_size_id bigint PRIMARY KEY,
	pizza_size_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_size_name varchar(20) NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT pizza_sizes_unique UNIQUE (pizza_size_id, pizza_size_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_3nf.ce_pizzas_scd(
	pizza_id bigint,
	pizza_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_name varchar(20) NOT NULL,
	pizza_type_id int NOT NULL,
	pizza_size_id int NOT NULL,
	pizza_price decimal(6,2) NOT NULL,
	is_active varchar(10),
	start_dt timestamp NOT NULL,
	end_dt timestamp NOT NULL,
	insert_dt timestamp NOT NULL,
	CONSTRAINT pizzas_scd_pk PRIMARY KEY (pizza_id, start_dt),
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
	employee_id int NOT NULL,
	offline_order_type bl_3nf.type_offline_order NOT NULL,
	delivery_id int NOT NULL,
	customer_id int NOT NULL,
	address_id int NOT NULL,
	pizza_id int NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT order_employee_fk FOREIGN KEY (employee_id) REFERENCES bl_3nf.ce_employees(employee_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT order_delivery_fk FOREIGN KEY (delivery_id) REFERENCES bl_3nf.ce_deliveries(delivery_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT order_customer_fk FOREIGN KEY (customer_id) REFERENCES bl_3nf.ce_customers(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT order_address_fk FOREIGN KEY (address_id) REFERENCES bl_3nf.ce_addresses(address_id) ON UPDATE CASCADE ON DELETE RESTRICT
);
SET ROLE postgres;

CREATE SCHEMA IF NOT EXISTS bl_dm;

CREATE SEQUENCE IF NOT EXISTS bl_dm.dim_orders_surr_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS bl_dm.dim_addresses_surr_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS bl_dm.dim_customers_scd_surr_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;
	
CREATE SEQUENCE IF NOT EXISTS bl_dm.dim_pizzas_surr_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;
	

CREATE TABLE IF NOT EXISTS bl_dm.dim_dates (
	date_id date PRIMARY KEY,
	date_year int,
	date_month int,
	date_monthname varchar(20),
	date_monthday int,
	date_yearday int,
	date_weekdayname varchar(20),
	date_calendarweek int,
	date_formatteddate varchar(20),
	date_quarter varchar(4),
	date_yearquarter varchar(20),
	date_yearmonth varchar (20),
	date_yearcalendarweek varchar(20),
	date_weekend varchar(20),
	date_georgianholiday varchar(20),
	date_period varchar(50),
	date_cwstart date,
	date_cwend date,
	date_monthstart date,
	date_monthend timestamp
);

CREATE TABLE IF NOT EXISTS bl_dm.dim_times(
	time_id varchar(10) PRIMARY KEY,
	time_hourofday int,
	time_quarterhour varchar(20),
	time_minuteofday int,
	time_daytimename varchar(20),
	time_daynightname varchar(20)
);

CREATE TABLE IF NOT EXISTS bl_dm.dim_orders (
	order_surr_id bigint PRIMARY KEY,
	order_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	order_name varchar(255) NOT NULL,
	employee_src_id varchar(255) NOT NULL,
	employee_full_name varchar(255) NOT NULL,
	order_type varchar(255) NOT NULL,
	offline_order_type varchar(255) NOT NULL,
	delivery_src_id varchar(255) NOT NULL,
	delivery_name varchar(255) NOT NULL,
	courier_src_id varchar(255) NOT NULL,
	courier_full_name varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT dim_orders_unique UNIQUE (order_src_id, source_system, source_entity)
);

-- Creating comosite type for cursor instead of RECORD
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_type t
        JOIN pg_namespace n ON n.oid = t.typnamespace
        WHERE t.typname = 'order_record_type'
        AND n.nspname = 'bl_dm'
    ) THEN
        CREATE TYPE bl_dm.order_record_type AS (
            order_src_id text,
            source_system text,
            source_entity text,
            order_name text,
            employee_src_id int,
            employee_full_name text,
            order_type text,
            offline_order_type text,
            delivery_src_id int,
            delivery_name text,
            courier_src_id int,
            courier_full_name text,
            insert_dt timestamp,
            update_dt timestamp
        );
    END IF;
END $$;

CREATE INDEX dim_orders_ind ON bl_dm.dim_orders (upper(order_src_id), upper(source_system), upper(source_entity));

CREATE TABLE IF NOT EXISTS bl_dm.dim_addresses (
	address_surr_id bigint PRIMARY KEY,
	address_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	address_name varchar(255) NOT NULL,
	district_src_id varchar(255) NOT NULL,
	district_name varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS bl_dm.dim_customers_scd (
	customer_surr_id bigint PRIMARY KEY,
	customer_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	original_source varchar(255) NOT NULL,	
	customer_full_name varchar(255) NOT NULL,
	is_active varchar(1) NOT NULL,
	start_dt timestamp NOT NULL,
	end_dt timestamp NOT NULL,
	insert_dt timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS bl_dm.dim_pizzas (
	pizza_surr_id bigint PRIMARY KEY,
	pizza_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_name varchar(255) NOT NULL,
	pizza_type_src_id int NOT NULL,
	pizza_type_name varchar(255) NOT NULL,
	pizza_size_src_id int NOT NULL,
	pizza_size_name varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL
);



CREATE TABLE IF NOT EXISTS bl_dm.fct_sales (
	customer_surr_id bigint NOT NULL,
	order_surr_id bigint NOT NULL,
	pizza_surr_id bigint NOT NULL,
	event_time varchar(10) NOT NULL,
	address_surr_id bigint NOT NULL,
	event_dt date NOT NULL,
	quantity int NOT NULL,
	price decimal (6,2),
	fct_cost_order decimal (10,2),
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT fct_sales_pk PRIMARY KEY (customer_surr_id, order_surr_id, pizza_surr_id, event_time, event_dt),
	CONSTRAINT sale_customer_fk FOREIGN KEY (customer_surr_id) REFERENCES bl_dm.dim_customers_scd(customer_surr_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT sale_order_fk FOREIGN KEY (order_surr_id) REFERENCES bl_dm.dim_orders(order_surr_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT event_date_fk FOREIGN KEY (event_dt) REFERENCES bl_dm.dim_dates(date_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT event_time_fk FOREIGN KEY (event_time) REFERENCES bl_dm.dim_times(time_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT sale_address_fk FOREIGN KEY (address_surr_id) REFERENCES bl_dm.dim_addresses(address_surr_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT sale_pizza_fk FOREIGN KEY (pizza_surr_id) REFERENCES bl_dm.dim_pizzas(pizza_surr_id) ON UPDATE CASCADE ON DELETE RESTRICT
) PARTITION BY RANGE (event_dt);

CREATE TABLE IF NOT EXISTS bl_dm.fct_sales_default PARTITION OF bl_dm.fct_sales FOR VALUES FROM ('1899-12-31'::date) TO ('1900-01-02'::date);

CREATE TABLE IF NOT EXISTS bl_dm.fct_sales_archived PARTITION OF bl_dm.fct_sales FOR VALUES FROM ('1900-01-02'::date) TO ('2022-01-01'::date);

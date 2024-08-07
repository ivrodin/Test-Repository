SET ROLE postgres;

--RESET ROLE ;

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
	update_dt timestamp NOT NULL
);

INSERT INTO bl_dm.dim_orders (
	order_surr_id,
	order_src_id,
	source_system,
	source_entity,
	order_name,
	employee_src_id,
	employee_full_name,
	order_type,
	offline_order_type,
	delivery_src_id,
	delivery_name,
	courier_src_id,
	courier_full_name,
	insert_dt,
	update_dt	
)
SELECT 
	-1 AS order_surr_id, 
	'N.A.' AS order_src_id, 
	'MANUAL' AS source_system, 
	'MANUAL' AS source_entity, 
	'N.A.' AS order_name,
	'N.A.' AS employee_src_id, 
	'N.A.' AS employee_full_name, 
	'N.A.' AS order_type, 	
	'N.A.' AS offline_order_type, 
	'N.A.' AS delivery_src_id, 
	'N.A.' AS delivery_name,
	'N.A.' AS courier_src_id,
	'N.A.' AS courier_full_name,
	'1900-01-01'::timestamp AS insert_dt,
	'1900-01-01'::timestamp AS update_dt
WHERE NOT EXISTS (
	SELECT 1 FROM bl_dm.dim_orders 
	WHERE order_surr_id = -1 AND 
		upper(order_src_id) = 'N.A.' AND 
		upper(source_system) = 'MANUAL' AND 
		upper(source_entity) = 'MANUAL'
);
	
COMMIT;

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

INSERT INTO bl_dm.dim_addresses (
	address_surr_id,
	address_src_id,
	source_system,
	source_entity,
	address_name,
	district_src_id,
	district_name,
	insert_dt,
	update_dt	
)
SELECT 
	-1 AS address_surr_id, 
	'N.A.' AS address_src_id, 
	'MANUAL' AS source_system, 
	'MANUAL' AS source_entity, 
	'N.A.' AS address_name, 
	'N.A.' AS district_src_id, 
	'N.A.' AS district_name,
	'1900-01-01'::timestamp AS insert_dt,
	'1900-01-01'::timestamp AS update_dt
WHERE NOT EXISTS (
	SELECT 1 FROM bl_dm.dim_addresses 
	WHERE address_surr_id = -1 AND 
		upper(address_src_id) = 'N.A.' AND 
		upper(source_system) = 'MANUAL' AND 
		upper(source_entity) = 'MANUAL'
);

COMMIT;

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

INSERT INTO bl_dm.dim_customers_scd (
	customer_surr_id,
	customer_src_id,
	source_system,
	source_entity,
	original_source,
	customer_full_name,
	is_active,
	start_dt,
	end_dt,
	insert_dt
)
SELECT 
	-1 AS customer_surr_id, 
	'N.A.' AS customer_src_id, 
	'MANUAL' AS source_system, 
	'MANUAL' AS source_entity, 
	'N.A.' AS original_source,
	'N.A.' AS customer_full_name,
	'Y' AS is_active,
	'1900-01-01'::timestamp AS start_dt,
	'1900-01-01'::timestamp AS end_dt,
	'1900-01-01'::timestamp AS insert_dt
WHERE NOT EXISTS (
	SELECT 1 FROM bl_dm.dim_customers_scd
	WHERE customer_surr_id = -1 AND 
		upper(customer_src_id) = 'N.A.' AND 
		upper(source_system) = 'MANUAL' AND 
		upper(source_entity) = 'MANUAL'
);

COMMIT;

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

INSERT INTO bl_dm.dim_pizzas (
	pizza_surr_id,
	pizza_src_id,
	source_system,
	source_entity,
	pizza_name,
	pizza_type_src_id,
	pizza_type_name,
	pizza_size_src_id,
	pizza_size_name,
	insert_dt,
	update_dt
)
SELECT 
	-1 AS pizza_surr_id, 
	'N.A.' AS pizza_src_id, 
	'MANUAL' AS source_system, 
	'MANUAL' AS source_entity, 
	'N.A.' AS pizza_name,
	-1 AS pizza_type_src_id,
	'N.A.' AS pizza_type ,
	-1 AS pizza_size_src_id,
	'N.A.' AS pizza_size,
	'1900-01-01'::timestamp AS insert_dt,
	'1900-01-01'::timestamp AS update_dt
WHERE NOT EXISTS (
	SELECT 1 FROM bl_dm.dim_pizzas
	WHERE pizza_surr_id = -1 AND 
		upper(pizza_src_id) = 'N.A.' AND 
		upper(source_system) = 'MANUAL' AND 
		upper(source_entity) = 'MANUAL'
);

COMMIT;

CREATE TABLE IF NOT EXISTS bl_dm.dim_times(
	time_id varchar(10) PRIMARY KEY,
	time_hourofday int NOT NULL,
	time_quarterhour varchar(20) NOT NULL,
	time_minuteofday int NOT NULL,
	time_daytimename varchar(20) NOT NULL,
	time_daynightname varchar(20) NOT NULL
);

INSERT INTO bl_dm.dim_times (
	time_id,
	time_hourofday,
	time_quarterhour,
	time_minuteofday,
	time_daytimename,
	time_daynightname
)
SELECT 
	'N.A.' AS time_id, 
	-1 AS time_hourofday, 
	'N.A.' AS time_quarterhour, 
	-1 AS time_minuteofday, 
	'N.A.' AS time_daytimename,
	'N.A.' AS time_daynightname
WHERE NOT EXISTS (
	SELECT 1 FROM bl_dm.dim_times 
	WHERE upper(time_id) = 'N.A.' AND 
		time_hourofday = -1 AND 
		time_minuteofday = -1
);

COMMIT;

CREATE TABLE IF NOT EXISTS bl_dm.dim_dates (
	date_id date PRIMARY KEY,
	date_year int NOT NULL,
	date_month int NOT NULL,
	date_monthname varchar(20) NOT NULL,
	date_monthday int NOT NULL,
	date_yearday int NOT NULL,
	date_weekdayname varchar(20) NOT NULL,
	date_calendarweek int NOT NULL,
	date_formatteddate varchar(20) NOT NULL,
	date_quarter varchar(4) NOT NULL,
	date_yearquarter varchar(20) NOT NULL,
	date_yearmonth varchar (20) NOT NULL,
	date_yearcalendarweek varchar(20) NOT NULL,
	date_weekend varchar(20) NOT NULL,
	date_georgianholiday varchar(20) NOT NULL,
	date_period varchar(50) NOT NULL,
	date_cwstart date NOT NULL,
	date_cwend date NOT NULL,
	date_monthstart date NOT NULL,
	date_monthend timestamp NOT NULL
);

INSERT INTO bl_dm.dim_dates (
	date_id,
	date_year,
	date_month,
	date_monthname,
	date_monthday,
	date_yearday,
	date_weekdayname,
	date_calendarweek,
	date_formatteddate,
	date_quarter,
	date_yearquarter,
	date_yearmonth,
	date_yearcalendarweek,
	date_weekend,
	date_georgianholiday,
	date_period,
	date_cwstart,
	date_cwend,
	date_monthstart,
	date_monthend
)
SELECT 
	'1900-01-01'::date AS date_id, 
	-1 AS date_year,
	-1 AS date_month,
	'N.A.' AS date_monthname,
	-1 AS date_monthday,
	-1 AS date_yearday,
	'N.A.' AS date_weekdayname,
	-1 AS date_calendarweek,
	'N.A.' AS date_formatteddate,
	'N.A.' AS date_quarter,
	'N.A.' AS date_yearquarter,
	'N.A.' AS date_yearmonth,
	'N.A.' AS date_yearcalendarweek,
	'N.A.' AS date_weekend,
	'N.A.' AS date_georgianholiday,
	'N.A.' AS date_period,
	'1900-01-01'::date AS date_cwstart,
	'1900-01-01'::date AS date_cwend,
	'1900-01-01'::date AS date_monthstart,
	'1900-01-01 00:00:00'::timestamp AS date_monthend
WHERE NOT EXISTS (
	SELECT 1 FROM bl_dm.dim_dates 
	WHERE date_id = '1900-01-01'::date AND 
		date_year = -1 AND 
		date_month = -1
);

COMMIT;

CREATE TABLE IF NOT EXISTS bl_dm.fct_sales (
	customer_surr_id bigint NOT NULL,
	order_surr_id bigint NOT NULL,
	pizza_surr_id bigint NOT NULL,
	event_time varchar(10) NOT NULL,
	address_surr_id bigint NOT NULL,
	event_dt date NOT NULL,
	quantity int,
	price decimal (6,2),
	fct_cost_order decimal (10,2),
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
--	CONSTRAINT fct_sales_pk PRIMARY KEY (customer_surr_id, order_surr_id, pizza_surr_id, event_time, address_surr_id, event_dt),
	CONSTRAINT sale_customer_fk FOREIGN KEY (customer_surr_id) REFERENCES bl_dm.dim_customers_scd(customer_surr_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT sale_order_fk FOREIGN KEY (order_surr_id) REFERENCES bl_dm.dim_orders(order_surr_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT event_date_fk FOREIGN KEY (event_dt) REFERENCES bl_dm.dim_dates(date_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT event_time_fk FOREIGN KEY (event_time) REFERENCES bl_dm.dim_times(time_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT sale_address_fk FOREIGN KEY (address_surr_id) REFERENCES bl_dm.dim_addresses(address_surr_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT sale_pizza_fk FOREIGN KEY (pizza_surr_id) REFERENCES bl_dm.dim_pizzas(pizza_surr_id) ON UPDATE CASCADE ON DELETE RESTRICT
) PARTITION BY RANGE (event_dt);

--Generating partitions from 2022 till 2025 by 3 month interval
DO $$
DECLARE
    start_date DATE := DATE '2022-01-01';
    end_date DATE;
    partition_name TEXT;
BEGIN
    WHILE start_date < DATE '2026-01-01' LOOP
        end_date := start_date + INTERVAL '3 month';
        partition_name := 'bl_dm.fct_sales_from_' || TO_CHAR(start_date, 'YYYY_MM') || '_till_' || TO_CHAR(end_date, 'YYYY_MM');

        EXECUTE format(
            'CREATE TABLE IF NOT EXISTS %I PARTITION OF bl_dm.fct_sales FOR VALUES FROM (%L) TO (%L)',
            partition_name,
            start_date,
            end_date
        );

        start_date := end_date;
    END LOOP;
END $$;

--CREATE INDEX ce_orders_ind ON bl_3nf.ce_orders (order_src_id, order_type, source_system, source_entity);
--CREATE INDEX dim_orders_ind ON bl_dm.dim_orders (order_src_id, source_system, source_entity);
--CREATE INDEX dim_addresses_ind ON bl_dm.dim_addresses (address_src_id, source_system, source_entity);
--CREATE INDEX dim_customers_ind ON bl_dm.dim_customers_scd (customer_src_id, original_source, source_system, source_entity);
--CREATE INDEX dim_pizzas_ind ON bl_dm.dim_pizzas (pizza_src_id, source_system, source_entity);

--CREATE INDEX ce_orders_ind ON bl_3nf.ce_orders (order_src_id);
--CREATE INDEX dim_orders_ind ON bl_dm.dim_orders (order_src_id);
--CREATE INDEX dim_addresses_ind ON bl_dm.dim_addresses (address_src_id);
--CREATE INDEX dim_customers_ind ON bl_dm.dim_customers_scd (customer_src_id);
--CREATE INDEX dim_pizzas_ind ON bl_dm.dim_pizzas (pizza_src_id);
--
--DROP INDEX bl_3nf.ce_orders_ind;
--DROP INDEX bl_dm.dim_orders_ind;
--DROP INDEX bl_dm.dim_addresses_ind;
--DROP INDEX bl_dm.dim_customers_ind;
--DROP INDEX bl_dm. dim_pizzas_ind;





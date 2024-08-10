SET ROLE developer_role;

CREATE OR REPLACE PROCEDURE bl_cl.src_online_sales_procedure (
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 
	
    username := current_user;
    table_name := 'sa_online_sales.src_online_sales';
    procedure_name := 'bl_cl.src_online_sales_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';
	rows_updated := 0;

	SELECT count(*) INTO count_before FROM sa_online_sales.src_online_sales;

	INSERT INTO sa_online_sales.src_online_sales (
		customer_id, 
		customer_full_name, 
		order_id, 
		"timestamp", 
		pizza_type, 
		pizza_name, 
		"size", 
		price, 
		delivery_id,
		delivery_name,
		courier_id, 
		courier_full_name, 
		district,
		address,
		quantity,
		load_timestamp
	)
	SELECT 
		e.customer_id, 
		e.customer_full_name, 
		e.order_id, 
		e."timestamp", 
		e.pizza_type, 
		e.pizza_name, 
		e."size", 
		e.price, 
		delivery_id,
		delivery_name,
		courier_id, 
		courier_full_name, 
		district,
		address,
		quantity,
		current_timestamp 
	FROM 
		sa_online_sales.ext_online_sales_1 e
	WHERE NOT EXISTS (
		SELECT 
			1 
		FROM 
			sa_online_sales.src_online_sales s 
		WHERE 
			COALESCE (s.customer_id, 'N.A.') = COALESCE (e.customer_id, 'N.A.') AND
			COALESCE (s.customer_full_name, 'N.A.') = COALESCE (e.customer_full_name, 'N.A.') AND
			COALESCE (s.order_id, 'N.A.') = COALESCE (e.order_id, 'N.A.') AND
			COALESCE (s."timestamp", 'N.A.') = COALESCE (e."timestamp", 'N.A.') AND
			COALESCE (s.pizza_type, 'N.A.') = COALESCE (e.pizza_type, 'N.A.') AND
			COALESCE (s.pizza_name, 'N.A.') = COALESCE (e.pizza_name, 'N.A.') AND
			COALESCE (s."size", 'N.A.') = COALESCE (e."size", 'N.A.') AND
			COALESCE (s.price, 'N.A.') = COALESCE (e.price, 'N.A.') AND
			COALESCE (s.delivery_id, 'N.A.') = COALESCE (e.delivery_id, 'N.A.') AND
			COALESCE (s.delivery_name, 'N.A.') = COALESCE (e.delivery_name, 'N.A.') AND
			COALESCE (s.courier_id, 'N.A.') = COALESCE (s.courier_id, 'N.A.') AND
			COALESCE (s.courier_full_name, 'N.A.') = COALESCE (s.courier_full_name, 'N.A.') AND
			COALESCE (s.district, 'N.A.') = COALESCE (e.district, 'N.A.') AND
			COALESCE (s.address, 'N.A.') = COALESCE (e.address, 'N.A.') AND 
			COALESCE (s.quantity, 'N.A.') = COALESCE (e.quantity, 'N.A.')
	);

	SELECT count(*) INTO count_after FROM sa_online_sales.src_online_sales;
	
	rows_inserted := count_after - count_before;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
	
--	COMMIT;

END;
$$ LANGUAGE plpgsql; 

CREATE OR REPLACE PROCEDURE bl_cl.src_restaurant_sales_procedure (
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 
	
    username := current_user;
    table_name := 'sa_restaurant_sales.src_restaurant_sales';
    procedure_name := 'bl_cl.src_restaurant_sales_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';
	rows_updated := 0;

	SELECT count(*) INTO count_before FROM sa_restaurant_sales.src_restaurant_sales;

	INSERT INTO sa_restaurant_sales.src_restaurant_sales (
		customer_id, 
		customer_full_name, 
		order_id, 
		"timestamp", 
		pizza_type, 
		pizza_name, 
		"size", 
		price, 
		employee_id, 
		employee_full_name, 
		in_or_out,
		quantity,
		load_timestamp
	)
	SELECT 
		e.customer_id, 
		e.customer_full_name, 
		e.order_id, 
		e."timestamp", 
		e.pizza_type, 
		e.pizza_name, 
		e."size", 
		e.price, 
		e.employee_id, 
		e.employee_full_name, 
		e.in_or_out,
		e.quantity,
		current_timestamp 
	FROM 
		sa_restaurant_sales.ext_restaurant_sales_1 e
	WHERE NOT EXISTS (
		SELECT 
			1 
		FROM 
			sa_restaurant_sales.src_restaurant_sales s 
		WHERE 
			COALESCE (s.customer_id, 'N.A.') = COALESCE (e.customer_id, 'N.A.') AND
			COALESCE (s.customer_full_name, 'N.A.') =  COALESCE (e.customer_full_name, 'N.A.') AND
			COALESCE (s.order_id, 'N.A.') = COALESCE (e.order_id, 'N.A.') AND
			COALESCE (s."timestamp", 'N.A.') = COALESCE (e."timestamp", 'N.A.') AND
			COALESCE (s.pizza_type, 'N.A.') = COALESCE (e.pizza_type, 'N.A.') AND
			COALESCE (s.pizza_name, 'N.A.') = COALESCE (e.pizza_name, 'N.A.') AND
			COALESCE (s."size", 'N.A.') = COALESCE (e."size", 'N.A.') AND
			COALESCE (s.price, 'N.A.') = COALESCE (e.price, 'N.A.') AND
			COALESCE (s.employee_id, 'N.A.') = COALESCE (s.employee_id, 'N.A.') AND
			COALESCE (s.employee_full_name, 'N.A.') = COALESCE (s.employee_full_name, 'N.A.') AND
			COALESCE (s.in_or_out, 'N.A.') = COALESCE (e.in_or_out, 'N.A.') AND 
			COALESCE (s.quantity, 'N.A.') = COALESCE (e.quantity, 'N.A.')
	);

	SELECT count(*) INTO count_after FROM sa_restaurant_sales.src_restaurant_sales;
	
	rows_inserted := count_after - count_before;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
	
--	COMMIT;

END;
$$ LANGUAGE plpgsql; 



CREATE OR REPLACE PROCEDURE bl_cl.rolling_window_partitions(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
)
AS $$
DECLARE
	rows_before int;
	rows_after int;

    max_date_src date;
    min_date_src date;

	partition_name text;	

    last_partition_end_date date;
    next_partition_end_date date;
    cutoff_date date;
    old_partition_name text;
BEGIN

    username := current_user;
    table_name := 'bl_dm.fct_sales';
    procedure_name := 'bl_cl.rolling_window_partitions';
    procedure_starttime := current_timestamp::text;
	status := 'Success';
	rows_updated := 0;
	
    SELECT count(*) INTO rows_before FROM pg_class WHERE relname ~ '^fct_sales_from_'; 

	WITH unified_dates AS (
		SELECT max(TO_DATE(sos."timestamp", 'DD-MM-YY')) AS max_dt 
		FROM sa_online_sales.src_online_sales sos
		UNION ALL
		SELECT max(TO_DATE(srs."timestamp", 'DD-MM-YY')) AS max_dt 
		FROM sa_restaurant_sales.src_restaurant_sales srs
	)
	SELECT max(max_dt) INTO max_date_src FROM unified_dates;

    SELECT
        (regexp_replace(
            pg_get_expr(c.relpartbound, c.oid), 
            'FOR VALUES FROM \((.*)\) TO \((.*)\)', 
            '\2')::date)
		INTO last_partition_end_date
    FROM
        pg_class c
    WHERE
        c.relname ~ '^fct_sales_' 
    ORDER BY 
        last_partition_end_date DESC 
    LIMIT 1;

    WHILE last_partition_end_date <= max_date_src LOOP
        next_partition_end_date  := last_partition_end_date + INTERVAL '2 months';
        partition_name := 'fct_sales_from_' || TO_CHAR(last_partition_end_date, 'YYYY_MM') || '_to_' || TO_CHAR(next_partition_end_date, 'YYYY_MM');

        EXECUTE format(
            'CREATE TABLE IF NOT EXISTS bl_dm.%I PARTITION OF bl_dm.fct_sales FOR VALUES FROM (%L) TO (%L)',
            partition_name,
            last_partition_end_date,
            next_partition_end_date
        );

        last_partition_end_date := next_partition_end_date;
    END LOOP;

    SELECT count(*) INTO rows_after FROM pg_class WHERE relname ~ '^fct_sales_from_'; 

	rows_inserted := rows_after - rows_before;


EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;

--	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.default_rows_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
)
AS $$
DECLARE
    rows_before INT;
    rows_after INT;
	rows_ins_total int := 0;
BEGIN 

    username := current_user;
    table_name := '3nf_and_dim_layers';
    procedure_name := 'bl_cl.default_rows_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';
	rows_updated := 0;

    SELECT count(*) INTO rows_before FROM bl_3nf.ce_couriers;

	INSERT INTO bl_3nf.ce_couriers (
		courier_id,
		courier_src_id,
		source_system,
		source_entity,
		courier_full_name,
		insert_dt,
		update_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', '1900-01-01'::timestamp , '1900-01-01'::timestamp
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_couriers WHERE courier_id = -1);

    SELECT count(*) INTO rows_after FROM bl_3nf.ce_couriers;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after := 0;

--	COMMIT;

    SELECT count(*) INTO rows_before FROM bl_3nf.ce_deliveries;

	INSERT INTO bl_3nf.ce_deliveries (
		delivery_id,
		delivery_src_id,
		source_system,
		source_entity,
		delivery_name,
		courier_id,
		insert_dt,
		update_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', -1, '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_deliveries WHERE delivery_id = -1);

    SELECT count(*) INTO rows_after FROM bl_3nf.ce_deliveries;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

    SELECT count(*) INTO rows_before FROM bl_3nf.ce_customers_scd;

	INSERT INTO bl_3nf.ce_customers_scd (
		customer_id, 
		customer_src_id, 
		source_system, 
		source_entity, 
		customer_full_name, 
		is_active, 
		start_dt, 
		end_dt, 
		insert_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', 'Y', '1900-01-01'::timestamp , '1900-01-01'::timestamp, '1900-01-01'::timestamp
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_customers_scd WHERE customer_id = -1);

    SELECT count(*) INTO rows_after FROM bl_3nf.ce_customers_scd;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

    SELECT count(*) INTO rows_before FROM bl_3nf.ce_districts;

	INSERT INTO bl_3nf.ce_districts (
		district_id,
		district_src_id,
		source_system,
		source_entity,
		district_name,
		insert_dt,
		update_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_districts WHERE district_id = -1);

    SELECT count(*) INTO rows_after FROM bl_3nf.ce_districts;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_3nf.ce_addresses;

	INSERT INTO bl_3nf.ce_addresses (
		address_id,
		address_src_id,
		source_system,
		source_entity,
		address_name,
		district_id,
		insert_dt,
		update_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', -1, '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_addresses WHERE address_id = -1);

    SELECT count(*) INTO rows_after FROM bl_3nf.ce_addresses;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_3nf.ce_employees;

	INSERT INTO bl_3nf.ce_employees (
		employee_id,
		employee_src_id,
		source_system,
		source_entity,
		employee_full_name,
		insert_dt,
		update_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_employees WHERE employee_id = -1);

    SELECT count(*) INTO rows_after FROM bl_3nf.ce_employees;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_3nf.ce_pizzas_types;

	INSERT INTO bl_3nf.ce_pizzas_types (
		pizza_type_id,
		pizza_type_src_id,
		source_system,
		source_entity,
		pizza_type_name,
		insert_dt,
		update_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_pizzas_types WHERE pizza_type_id = -1);

    SELECT count(*) INTO rows_after FROM bl_3nf.ce_pizzas_types;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_3nf.ce_pizzas_sizes;

	INSERT INTO bl_3nf.ce_pizzas_sizes (
		pizza_size_id,
		pizza_size_src_id,
		source_system,
		source_entity,
		pizza_size_name,
		insert_dt,
		update_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_pizzas_sizes WHERE pizza_size_id = -1);

    SELECT count(*) INTO rows_after FROM bl_3nf.ce_pizzas_sizes;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_3nf.ce_pizzas;

	INSERT INTO bl_3nf.ce_pizzas (
		pizza_id,
		pizza_src_id,
		source_system,
		source_entity,
		pizza_name,
		pizza_type_id,
		pizza_size_id,
		insert_dt,
		update_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', -1, -1, '1900-01-01'::timestamp, '1900-01-01'::timestamp
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_pizzas WHERE pizza_id = -1);

    SELECT count(*) INTO rows_after FROM bl_3nf.ce_pizzas;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_3nf.ce_orders;

	INSERT INTO bl_3nf.ce_orders (
		order_id,
		order_src_id,
		source_system,
		source_entity,
		order_timestamp,
		order_type,
		offline_order_type,
		insert_dt,
		update_dt 
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', '1900-01-01'::timestamp, 'N.A.'::bl_3nf.type_order, 'N.A.'::bl_3nf.type_offline_order, '1900-01-01'::timestamp, '1900-01-01'::timestamp
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_orders WHERE order_id = -1);

    SELECT count(*) INTO rows_after FROM bl_3nf.ce_orders;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_dm.dim_orders;

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

    SELECT count(*) INTO rows_after FROM bl_dm.dim_orders ;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_dm.dim_addresses;

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

    SELECT count(*) INTO rows_after FROM bl_dm.dim_addresses ;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_dm.dim_customers_scd;

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

    SELECT count(*) INTO rows_after FROM bl_dm.dim_customers_scd ;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_dm.dim_pizzas;

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

    SELECT count(*) INTO rows_after FROM  bl_dm.dim_pizzas ;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_dm.dim_times;

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

    SELECT count(*) INTO rows_after FROM  bl_dm.dim_times ;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_dm.dim_dates;

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

    SELECT count(*) INTO rows_after FROM  bl_dm.dim_dates  ;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

--	COMMIT;

   SELECT count(*) INTO rows_before FROM bl_cl.load_metadata;

	INSERT INTO bl_cl.load_metadata (load_id, src_tablename, last_src_dt, load_dt)
	SELECT -1, 'SRC_ONLINE_SALES','1900-01-01'::timestamp, '1900-01-01'::timestamp
	WHERE NOT EXISTS (SELECT 1 FROM bl_cl.load_metadata WHERE load_id = -1)
	UNION ALL
	SELECT -2, 'SRC_RESTAURANT_SALES','1900-01-01'::timestamp, '1900-01-01'::timestamp
	WHERE NOT EXISTS (SELECT 1 FROM bl_cl.load_metadata WHERE load_id = -2);

    SELECT count(*) INTO rows_after FROM  bl_cl.load_metadata;	

	rows_ins_total := rows_ins_total + (rows_after - rows_before);

	rows_before := 0;
	rows_after:= 0;

	rows_inserted := rows_ins_total;

--	COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;

--	COMMIT;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.upd_load_metadata (
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
)
AS $$
DECLARE
    count_before INT;
    count_after INT;
BEGIN 

    username := current_user;
    table_name := 'bl_cl.load_metadata';
    procedure_name := 'bl_cl.upd_load_metadata';
    procedure_starttime := current_timestamp::text;
	status := 'Success';
	rows_updated := 0;

    SELECT count(*) INTO count_before FROM bl_cl.load_metadata;	
		
	INSERT INTO bl_cl.load_metadata (load_id, src_tablename, last_src_dt, load_dt)
	SELECT nextval('bl_cl.load_meadata_id_seq'), 
		'SRC_ONLINE_SALES', 
		(SELECT max(sos.load_timestamp) FROM sa_online_sales.src_online_sales sos),
		current_timestamp
	UNION ALL
	SELECT nextval('bl_cl.load_meadata_id_seq'), 
		'SRC_RESTAURANT_SALES',
		(SELECT max(sos.load_timestamp) FROM sa_restaurant_sales.src_restaurant_sales sos),
		current_timestamp;

    SELECT count(*) INTO count_after FROM bl_cl.load_metadata;

	rows_inserted := count_after - count_before;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;

--	COMMIT;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.lkp_pizzas_sizes_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff_online INT;
    rows_aff_offline INT;
BEGIN 

    username := current_user;
    table_name := 'bl_cl.lkp_pizzas_sizes';
    procedure_name := 'bl_cl.lkp_pizzas_sizes_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_cl.lkp_pizzas_sizes;

    WITH init_src AS (
            SELECT DISTINCT
                COALESCE(UPPER(s."size"), 'N.A.') AS pizza_size_src_id,
                'SA_ONLINE_SALES' AS source_system,
                'SRC_ONLINE_SALES' AS source_entity,
                COALESCE(UPPER(s."size"), 'N.A.') AS pizza_size_name,
                CURRENT_TIMESTAMP AS insert_dt,
                CURRENT_TIMESTAMP AS update_dt
            FROM 
                sa_online_sales.src_online_sales s
            WHERE NOT EXISTS (
                SELECT 1 
                FROM bl_cl.lkp_pizzas_sizes t
                WHERE UPPER(s."size") = UPPER(t.pizza_size_src_id)
                	AND UPPER(t.source_system) = 'SA_ONLINE_SALES'
                	AND UPPER(t.source_entity) = 'SRC_ONLINE_SALES'
					AND UPPER(s."size") = UPPER(t.pizza_size_name)
            ) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
	)
	INSERT INTO bl_cl.lkp_pizzas_sizes (
        pizza_size_id,
        pizza_size_src_id,
        source_system,
        source_entity,
        pizza_size_name,
        insert_dt,
        update_dt
    )
    SELECT 
        COALESCE(
			(SELECT pizza_size_id FROM bl_cl.lkp_pizzas_sizes t WHERE upper(t.pizza_size_src_id) = upper(s.pizza_size_src_id)), 
			nextval('bl_cl.lkp_pizzas_sizes_id_seq')
		),
        pizza_size_src_id,
        source_system,
        source_entity,
        pizza_size_name,
        insert_dt,
        update_dt 
    FROM init_src s
    ON CONFLICT (pizza_size_src_id, source_system, source_entity) DO UPDATE
    SET 
        pizza_size_name = EXCLUDED.pizza_size_name,
        update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff_online = ROW_COUNT;

    WITH init_src AS (
            SELECT DISTINCT
                COALESCE(UPPER(s."size"), 'N.A.') AS pizza_size_src_id,
                'SA_RESTAURANT_SALES' AS source_system,
                'SRC_RESTAURANT_SALES' AS source_entity,
                COALESCE(UPPER(s."size"), 'N.A.') AS pizza_size_name,
                CURRENT_TIMESTAMP AS insert_dt,
                CURRENT_TIMESTAMP AS update_dt 
            FROM 
                sa_restaurant_sales.src_restaurant_sales s
            WHERE NOT EXISTS (
                SELECT 1 
                FROM bl_cl.lkp_pizzas_sizes t
                WHERE UPPER(s."size") = UPPER(t.pizza_size_src_id)
                	AND UPPER(t.source_system) = 'SA_RESTAURANT_SALES'
                	AND UPPER(t.source_entity) = 'SRC_RESTAURANT_SALES'
					AND UPPER(s."size") = UPPER(t.pizza_size_name)
            ) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_RESTAURANT_SALES')
	) 
    INSERT INTO bl_cl.lkp_pizzas_sizes (
        pizza_size_id,
        pizza_size_src_id,
        source_system,
        source_entity,
        pizza_size_name,
        insert_dt,
        update_dt
    )
    SELECT 
        COALESCE(
			(SELECT pizza_size_id FROM bl_cl.lkp_pizzas_sizes t WHERE upper(t.pizza_size_src_id) = upper(s.pizza_size_src_id)), 
			nextval('bl_cl.lkp_pizzas_sizes_id_seq')
		),
        pizza_size_src_id,
        source_system,
        source_entity,
        pizza_size_name,
        insert_dt,
        update_dt 
    FROM init_src s
    ON CONFLICT (pizza_size_src_id, source_system, source_entity) DO UPDATE
    SET 
        pizza_size_name = EXCLUDED.pizza_size_name,
        update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff_offline = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_cl.lkp_pizzas_sizes;

    rows_inserted := count_after - count_before;
    rows_updated := (rows_aff_online + rows_aff_offline) - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
--	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.lkp_pizzas_types_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff_online INT;
    rows_aff_offline INT;
BEGIN 

    username := current_user;
    table_name := 'bl_cl.lkp_pizzas_types';
    procedure_name := 'bl_cl.lkp_pizzas_types_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_cl.lkp_pizzas_types;

    WITH init_src AS (
            SELECT DISTINCT
                COALESCE(UPPER(s.pizza_type), 'N.A.') AS pizza_type_src_id,
                'SA_ONLINE_SALES' AS source_system,
                'SRC_ONLINE_SALES' AS source_entity,
                COALESCE(UPPER(s.pizza_type), 'N.A.') AS pizza_type_name,
                CURRENT_TIMESTAMP AS insert_dt,
                CURRENT_TIMESTAMP AS update_dt
            FROM 
                sa_online_sales.src_online_sales s
            WHERE NOT EXISTS (
                SELECT 1 
                FROM bl_cl.lkp_pizzas_types t
                WHERE UPPER(s.pizza_type) = UPPER(t.pizza_type_src_id)
                	AND UPPER(t.source_system) = 'SA_ONLINE_SALES'
                	AND UPPER(t.source_entity) = 'SRC_ONLINE_SALES'
					AND UPPER(s.pizza_type) = UPPER(t.pizza_type_name)
            ) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
	)
    INSERT INTO bl_cl.lkp_pizzas_types (
        pizza_type_id,
        pizza_type_src_id,
        source_system,
        source_entity,
        pizza_type_name,
        insert_dt,
        update_dt
    )
    SELECT 
        COALESCE(
			(SELECT pizza_type_id FROM bl_cl.lkp_pizzas_types t WHERE upper(t.pizza_type_src_id) = upper(s.pizza_type_src_id)), 
			nextval('bl_cl.lkp_pizzas_types_id_seq')
		),
        pizza_type_src_id,
        source_system,
        source_entity,
        pizza_type_name,
        insert_dt,
        update_dt 
    FROM init_src s
    ON CONFLICT (pizza_type_src_id, source_system, source_entity) DO UPDATE
    SET 
        pizza_type_name = EXCLUDED.pizza_type_name,
        update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff_online = ROW_COUNT;

    WITH init_src AS (
            SELECT DISTINCT
                COALESCE(UPPER(s.pizza_type), 'N.A.') AS pizza_type_src_id,
                'SA_RESTAURANT_SALES' AS source_system,
                'SRC_RESTAURANT_SALES' AS source_entity,
                COALESCE(UPPER(s.pizza_type), 'N.A.') AS pizza_type_name,
                CURRENT_TIMESTAMP AS insert_dt,
                CURRENT_TIMESTAMP AS update_dt 
            FROM 
                sa_restaurant_sales.src_restaurant_sales s
            WHERE NOT EXISTS (
                SELECT 1 
                FROM bl_cl.lkp_pizzas_types t
                WHERE UPPER(s.pizza_type) = UPPER(t.pizza_type_src_id)
                	AND UPPER(t.source_system) = 'SA_RESTAURANT_SALES'
                	AND UPPER(t.source_entity) = 'SRC_RESTAURANT_SALES'
					AND UPPER(s.pizza_type) = UPPER(t.pizza_type_name)
            ) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_RESTAURANT_SALES')
	)
    INSERT INTO bl_cl.lkp_pizzas_types (
        pizza_type_id,
        pizza_type_src_id,
        source_system,
        source_entity,
        pizza_type_name,
        insert_dt,
        update_dt
    )
    SELECT 
        COALESCE(
			(SELECT pizza_type_id FROM bl_cl.lkp_pizzas_types t WHERE upper(t.pizza_type_src_id) = upper(s.pizza_type_src_id)), 
			nextval('bl_cl.lkp_pizzas_types_id_seq')
		),
        pizza_type_src_id,
        source_system,
        source_entity,
        pizza_type_name,
        insert_dt,
        update_dt 
    FROM init_src s
    ON CONFLICT (pizza_type_src_id, source_system, source_entity) DO UPDATE
    SET 
        pizza_type_name = EXCLUDED.pizza_type_name,
        update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff_offline = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_cl.lkp_pizzas_types;

    rows_inserted := count_after - count_before;
    rows_updated := (rows_aff_online + rows_aff_offline) - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;

--	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.lkp_pizzas_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff_online INT;
    rows_aff_offline INT;
BEGIN 

    username := current_user;
    table_name := 'bl_cl.lkp_pizzas';
    procedure_name := 'bl_cl.lkp_pizzas_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_cl.lkp_pizzas;

	WITH init_src AS (
		SELECT DISTINCT 
		    COALESCE(UPPER(s.pizza_name || '_' || s.pizza_type || '_' || s."size"), 'N.A.') AS pizza_src_id,
		    'SA_ONLINE_SALES' AS source_system,
		    'SRC_ONLINE_SALES' AS source_entity,
		    CURRENT_TIMESTAMP AS insert_dt,
		    CURRENT_TIMESTAMP AS update_dt
		FROM 
		    sa_online_sales.src_online_sales s
		WHERE NOT EXISTS (
		    SELECT 1 
		    FROM bl_cl.lkp_pizzas t
		    WHERE UPPER(s.pizza_name || '_' || s.pizza_type || '_' || s."size") = UPPER(t.pizza_src_id)
		    	AND UPPER(t.source_system) = 'SA_ONLINE_SALES'
		    	AND UPPER(t.source_entity) = 'SRC_ONLINE_SALES'
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
	)
	INSERT INTO bl_cl.lkp_pizzas (
	    pizza_id,
	    pizza_src_id,
	    source_system,
	    source_entity,
	    insert_dt,
	    update_dt
	)
	SELECT 
        COALESCE(
			(SELECT pizza_id FROM bl_cl.lkp_pizzas t WHERE upper(t.pizza_src_id) = upper(s.pizza_src_id)), 
			nextval('bl_cl.lkp_pizzas_id_seq')
		),
	    pizza_src_id,
	    source_system,
	    source_entity,
	    insert_dt,
	    update_dt  
	FROM init_src s
	ON CONFLICT (pizza_src_id, source_system, source_entity) DO UPDATE
	SET 
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff_online = ROW_COUNT;


	WITH init_src AS (
		SELECT DISTINCT
		    COALESCE(UPPER(s.pizza_name || '_' || s.pizza_type || '_' || s."size"), 'N.A.') AS pizza_src_id,
		    'SA_RESTAURANT_SALES' AS source_system,
		    'SRC_RESTAURANT_SALES' AS source_entity,
		    CURRENT_TIMESTAMP AS insert_dt,
		    CURRENT_TIMESTAMP AS update_dt
		FROM 
		    sa_restaurant_sales.src_restaurant_sales s
		WHERE NOT EXISTS (
		    SELECT 1 
		    FROM bl_cl.lkp_pizzas t
		    WHERE UPPER(s.pizza_name || '_' || s.pizza_type || '_' || s."size") = UPPER(t.pizza_src_id)
		    	AND UPPER(t.source_system) = 'SA_RESTAURANT_SALES'
		    	AND UPPER(t.source_entity) = 'SRC_RESTAURANT_SALES'
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_RESTAURANT_SALES')
	)
	INSERT INTO bl_cl.lkp_pizzas (
	    pizza_id,
	    pizza_src_id,
	    source_system,
	    source_entity,
	    insert_dt,
	    update_dt
	)
	SELECT 
        COALESCE(
			(SELECT pizza_id FROM bl_cl.lkp_pizzas t WHERE upper(t.pizza_src_id) = upper(s.pizza_src_id)), 
			nextval('bl_cl.lkp_pizzas_id_seq')
		),
	    pizza_src_id,
	    source_system,
	    source_entity,
	    insert_dt,
	    update_dt  
	FROM init_src s
	ON CONFLICT (pizza_src_id, source_system, source_entity) DO UPDATE
	SET 
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff_offline = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_cl.lkp_pizzas;

    rows_inserted := count_after - count_before;
    rows_updated := (rows_aff_online + rows_aff_offline) - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
--	COMMIT;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE bl_cl.ce_couriers_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_couriers';
    procedure_name := 'bl_cl.ce_couriers_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_3nf.ce_couriers;

    MERGE INTO bl_3nf.ce_couriers t
    USING (
        SELECT DISTINCT
            COALESCE(upper(courier_id), 'N.A.') AS courier_src_id,
            'SA_ONLINE_SALES' AS source_system,
            'SRC_ONLINE_SALES' AS source_entity,
            COALESCE(upper(courier_full_name), 'N.A.') AS courier_full_name,
            current_timestamp AS insert_dt,
            current_timestamp AS update_dt
        FROM 
            sa_online_sales.src_online_sales s
        WHERE NOT EXISTS (
			SELECT 1 FROM bl_3nf.ce_couriers t 
			WHERE upper(s.courier_id) = upper(t.courier_src_id) AND 
				upper(t.source_system) = 'SA_ONLINE_SALES' AND 
				upper(t.source_entity) = 'SRC_ONLINE_SALES' AND 
				upper(s.courier_full_name) = upper(t.courier_full_name)
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
    ) AS s
    ON t.courier_src_id = s.courier_src_id
        AND t.source_system = s.source_system
        AND t.source_entity = s.source_entity
    WHEN MATCHED THEN
        UPDATE SET 
            courier_full_name = s.courier_full_name,
            update_dt = s.update_dt
    WHEN NOT MATCHED THEN
        INSERT (
            courier_id,
            courier_src_id,
            source_system,
            source_entity,
            courier_full_name,
            insert_dt,
            update_dt
        )
        VALUES (
            nextval('bl_3nf.ce_couriers_id_seq'),
            s.courier_src_id,
            s.source_system,
            s.source_entity,
            s.courier_full_name,
            s.insert_dt,
            s.update_dt
        );

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_3nf.ce_couriers;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_deliveries_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_deliveries';
    procedure_name := 'bl_cl.ce_deliveries_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_3nf.ce_deliveries;

	WITH initial_table AS (
		SELECT DISTINCT
			COALESCE(upper(s.delivery_id), 'N.A.') AS delivery_src_id,
			'SA_ONLINE_SALES' AS source_system,
			'SRC_ONLINE_SALES' AS source_entity,
			COALESCE (upper(s.delivery_name), 'N.A.') AS delivery_name,
			COALESCE ((SELECT courier_id FROM bl_3nf.ce_couriers e WHERE upper(s.courier_id) = upper(e.courier_src_id)), -1) AS courier_id,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM 
			sa_online_sales.src_online_sales s
		WHERE NOT EXISTS (
			SELECT 1 FROM bl_3nf.ce_deliveries t 
			WHERE upper(s.delivery_id) = upper(t.delivery_src_id) AND 
				upper(t.source_system) = 'SA_ONLINE_SALES' AND 
				upper(t.source_entity) = 'SRC_ONLINE_SALES' AND
				upper(s.delivery_name) = upper(t.delivery_name)
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
	)
	INSERT INTO bl_3nf.ce_deliveries (
		delivery_id,
		delivery_src_id,
		source_system,
		source_entity,
		delivery_name,
		courier_id,
		insert_dt,
		update_dt
	)
	SELECT nextval('bl_3nf.ce_deliveries_id_seq'),
		delivery_src_id,
		source_system,
		source_entity,
		delivery_name,
		courier_id,
		insert_dt,
		update_dt
	FROM initial_table
	ON CONFLICT (delivery_src_id, courier_id) DO UPDATE
	SET 
	    delivery_name = EXCLUDED.delivery_name,
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_3nf.ce_deliveries;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_customers_scd_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
	counts_before INT;
	counts_after INT;
    rows_aff_online INT;  
    rows_aff_offline INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_customers_scd';
    procedure_name := 'bl_cl.ce_customers_scd_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

	SELECT count(*) INTO counts_before FROM bl_3nf.ce_customers_scd;

	WITH src_cte AS (
        SELECT DISTINCT 
            COALESCE (s.customer_id, 'N.A.') AS customer_src_id,
            'SA_ONLINE_SALES' AS source_system,
            'SRC_ONLINE_SALES' AS source_entity,
            COALESCE (upper(s.customer_full_name), 'N.A.') AS customer_full_name,
            'Y' AS is_active,
            current_timestamp AS start_dt,
            '9999-12-31'::timestamp AS end_dt,
            current_timestamp AS insert_dt
        FROM sa_online_sales.src_online_sales s
		WHERE NOT EXISTS (
            SELECT 1 FROM bl_3nf.ce_customers_scd t 
            WHERE upper(s.customer_id) = upper(t.customer_src_id) AND 
                upper(t.source_system) = 'SA_ONLINE_SALES' AND 
                upper(t.source_entity) = 'SRC_ONLINE_SALES' AND
				upper(s.customer_full_name) = upper(t.customer_full_name)
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
	)
	UPDATE bl_3nf.ce_customers_scd t
	SET is_active = 'N',
		end_dt = current_timestamp
	WHERE EXISTS (
		SELECT 1 FROM src_cte s 
			WHERE upper(t.customer_src_id) = upper(s.customer_src_id) AND
	            upper(t.source_system) = 'SA_ONLINE_SALES' AND 
	            upper(t.source_entity) = 'SRC_ONLINE_SALES'
		);

    GET DIAGNOSTICS rows_aff_online = ROW_COUNT;
	
	WITH src_cte AS (
        SELECT DISTINCT 
            COALESCE (s.customer_id, 'N.A.') AS customer_src_id,
            'SA_ONLINE_SALES' AS source_system,
            'SRC_ONLINE_SALES' AS source_entity,
            COALESCE (upper(s.customer_full_name), 'N.A.') AS customer_full_name,
            'Y' AS is_active,
            current_timestamp AS start_dt,
            '9999-12-31'::timestamp AS end_dt,
            current_timestamp AS insert_dt
        FROM sa_online_sales.src_online_sales s
		WHERE NOT EXISTS (
            SELECT 1 FROM bl_3nf.ce_customers_scd t 
            WHERE upper(s.customer_id) = upper(t.customer_src_id) AND 
                upper(t.source_system) = 'SA_ONLINE_SALES' AND 
                upper(t.source_entity) = 'SRC_ONLINE_SALES' AND
				upper(s.customer_full_name) = upper(t.customer_full_name)
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
	)
	INSERT INTO bl_3nf.ce_customers_scd (customer_id, customer_src_id, source_system, source_entity, customer_full_name, is_active, start_dt, end_dt, insert_dt)
    SELECT 
        COALESCE(
			(SELECT customer_id FROM bl_3nf.ce_customers_scd t
				WHERE t.customer_src_id = s.customer_src_id AND 
					t.source_system = s.source_system AND
					t.source_entity = s.source_entity),
			nextval('bl_3nf.ce_customers_scd_id_seq')
		),
		s.customer_src_id,
		s.source_system,
		s.source_entity,
		s.customer_full_name,
		s.is_active,
		s.start_dt,
		s.end_dt,
		s.insert_dt
	FROM src_cte s;

	WITH src_cte AS (
        SELECT DISTINCT 
            COALESCE (s.customer_id, 'N.A.') AS customer_src_id,
            'SA_RESTAURANT_SALES' AS source_system,
            'SRC_RESTAURANT_SALES' AS source_entity,
            COALESCE (upper(s.customer_full_name), 'N.A.') AS customer_full_name,
            'Y' AS is_active,
            current_timestamp AS start_dt,
            '9999-12-31'::timestamp AS end_dt,
            current_timestamp AS insert_dt
        FROM sa_restaurant_sales.src_restaurant_sales s
		WHERE NOT EXISTS (
            SELECT 1 FROM bl_3nf.ce_customers_scd t 
            WHERE upper(s.customer_id) = upper(t.customer_src_id) AND 
                upper(t.source_system) = 'SA_RESTAURANT_SALES' AND 
                upper(t.source_entity) = 'SRC_RESTAURANT_SALES' AND
				upper(s.customer_full_name) = upper(t.customer_full_name)
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_RESTAURANT_SALES')
	)
	UPDATE bl_3nf.ce_customers_scd t
	SET is_active = 'N',
		end_dt = current_timestamp
	WHERE EXISTS (
		SELECT 1 FROM src_cte s 
			WHERE upper(t.customer_src_id) = upper(s.customer_src_id) AND
				upper(t.source_system) = 'SA_RESTAURANT_SALES' AND 
                upper(t.source_entity) = 'SRC_RESTAURANT_SALES'
		);

    GET DIAGNOSTICS rows_aff_offline = ROW_COUNT;
	
	WITH src_cte AS (
        SELECT DISTINCT 
            COALESCE (s.customer_id, 'N.A.') AS customer_src_id,
            'SA_RESTAURANT_SALES' AS source_system,
            'SRC_RESTAURANT_SALES' AS source_entity,
            COALESCE (upper(s.customer_full_name), 'N.A.') AS customer_full_name,
            'Y' AS is_active,
            current_timestamp AS start_dt,
            '9999-12-31'::timestamp AS end_dt,
            current_timestamp AS insert_dt
        FROM sa_restaurant_sales.src_restaurant_sales s
		WHERE NOT EXISTS (
            SELECT 1 FROM bl_3nf.ce_customers_scd t 
            WHERE upper(s.customer_id) = upper(t.customer_src_id) AND 
                upper(t.source_system) = 'SA_RESTAURANT_SALES' AND 
                upper(t.source_entity) = 'SRC_RESTAURANT_SALES' AND
				upper(s.customer_full_name) = upper(t.customer_full_name)
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_RESTAURANT_SALES')
	)
	INSERT INTO bl_3nf.ce_customers_scd (customer_id, customer_src_id, source_system, source_entity, customer_full_name, is_active, start_dt, end_dt, insert_dt)
    SELECT 
        COALESCE(
			(SELECT customer_id FROM bl_3nf.ce_customers_scd t
				WHERE t.customer_src_id = s.customer_src_id AND 
					t.source_system = s.source_system AND
					t.source_entity = s.source_entity),
			nextval('bl_3nf.ce_customers_scd_id_seq')
		),
		s.customer_src_id,
		s.source_system,
		s.source_entity,
		s.customer_full_name,
		s.is_active,
		s.start_dt,
		s.end_dt,
		s.insert_dt
	FROM src_cte s;



	SELECT count(*) INTO counts_after FROM bl_3nf.ce_customers_scd;

    rows_inserted := counts_after - counts_before;
    rows_updated := (rows_aff_online + rows_aff_offline);

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;


	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_districts_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_districts';
    procedure_name := 'bl_cl.ce_districts_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_3nf.ce_districts;

	WITH initial_table AS (
		SELECT DISTINCT
			COALESCE (upper(s.district), 'N.A.') AS district_src_id,
			'SA_ONLINE_SALES' AS source_system,
			'SRC_ONLINE_SALES' AS source_entity,
			COALESCE (upper(s.district), 'N.A.') AS district_name ,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM 
			sa_online_sales.src_online_sales s
		WHERE NOT EXISTS (
			SELECT 1 FROM bl_3nf.ce_districts t 
			WHERE upper(s.district) = upper(t.district_src_id) AND 
				upper(t.source_system) = 'SA_ONLINE_SALES' AND
				upper(t.source_entity) = 'SRC_ONLINE_SALES' AND
				upper(s.district) = upper(t.district_name)
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
	)
	INSERT INTO bl_3nf.ce_districts (
		district_id,
		district_src_id,
		source_system,
		source_entity,
		district_name,
		insert_dt,
		update_dt
	)
	SELECT nextval('bl_3nf.ce_districts_id_seq'),
		district_src_id,
		source_system,
		source_entity,
		district_name,
		insert_dt,
		update_dt
	FROM initial_table
	ON CONFLICT (district_src_id, source_system, source_entity) DO UPDATE
	SET 
	    district_name = EXCLUDED.district_name,
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_3nf.ce_districts;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_addresses_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_addresses';
    procedure_name := 'bl_cl.ce_addresses_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_3nf.ce_addresses;

	WITH initial_table AS (
		SELECT DISTINCT
			COALESCE (upper(s.address), 'N.A.') AS address_src_id,
			'SA_ONLINE_SALES' AS source_system,
			'SRC_ONLINE_SALES' AS source_entity,
			COALESCE (upper(s.address), 'N.A.') AS address_name,
			COALESCE ((SELECT district_id FROM bl_3nf.ce_districts e WHERE upper(s.district) = upper(e.district_src_id)), -1) AS district_id,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM 
			sa_online_sales.src_online_sales s
		WHERE NOT EXISTS (
			SELECT 1 FROM bl_3nf.ce_addresses t 
			WHERE upper(s.address) = upper(t.address_src_id) AND 
				upper(t.source_system) = 'SA_ONLINE_SALES' AND 
				upper(t.source_entity) = 'SRC_ONLINE_SALES' AND
				upper(s.address) = upper(t.address_name)
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
	)
	INSERT INTO bl_3nf.ce_addresses (
		address_id,
		address_src_id,
		source_system,
		source_entity,
		address_name,
		district_id,
		insert_dt,
		update_dt
	)
	SELECT nextval('bl_3nf.ce_addresses_id_seq'),
		address_src_id,
		source_system,
		source_entity,
		address_name,
		district_id,
		insert_dt,
		update_dt
	FROM initial_table
	ON CONFLICT (address_src_id, district_id) DO UPDATE
	SET 
	    address_name = EXCLUDED.address_name,
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_3nf.ce_addresses;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_employees_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_employees';
    procedure_name := 'bl_cl.ce_employees_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_3nf.ce_employees;

	WITH initial_table AS (
		SELECT DISTINCT
			COALESCE (upper(s.employee_id), 'N.A.') AS employee_src_id,
			'SA_RESTAURANT_SALES' AS source_system,
			'SRC_RESTAURANT_SALES' AS source_entity,
			COALESCE (upper(s.employee_full_name), 'N.A.') AS employee_full_name,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM 
			sa_restaurant_sales.src_restaurant_sales s
		WHERE NOT EXISTS (
			SELECT 1 FROM bl_3nf.ce_employees t 
			WHERE upper(s.employee_id) = upper(t.employee_src_id) AND 
				upper(t.source_system) = 'SA_RESTAURANT_SALES' AND 
				upper(t.source_entity) = 'SRC_RESTAURANT_SALES' AND
				upper(s.employee_full_name) = upper(t.employee_full_name)
		) AND (s.load_timestamp) > (SELECT max(last_src_dt)::timestamp FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_RESTAURANT_SALES')
	)
	INSERT INTO bl_3nf.ce_employees (
		employee_id,
		employee_src_id,
		source_system,
		source_entity,
		employee_full_name,
		insert_dt,
		update_dt
	)
	SELECT nextval('bl_3nf.ce_employees_id_seq'),
		employee_src_id,
		source_system,
		source_entity,
		employee_full_name,
		insert_dt,
		update_dt
	FROM initial_table
	ON CONFLICT (employee_src_id, source_system, source_entity) DO UPDATE
	SET 
	    employee_full_name = EXCLUDED.employee_full_name,
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_3nf.ce_employees;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_pizzas_types_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_pizzas_types';
    procedure_name := 'bl_cl.ce_pizzas_types_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_3nf.ce_pizzas_types;

	WITH initial_table AS (
		SELECT DISTINCT 
			COALESCE (s.pizza_type_id::varchar(255), 'N.A.') AS pizza_type_src_id,
			'BL_CL' AS source_system,
			'LKP_PIZZAS_TYPES' AS source_entity,
			COALESCE (upper(s.pizza_type_name), 'N.A.') AS pizza_type_name,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM 
			bl_cl.lkp_pizzas_types s
		WHERE 
			NOT EXISTS (
				SELECT 1 FROM bl_3nf.ce_pizzas_types t 
				WHERE upper(s.pizza_type_id::text) = upper(t.pizza_type_src_id) AND 
					upper(t.source_system) = 'BL_CL' AND 
					upper(t.source_entity) = 'LKP_PIZZAS_TYPES'
		) AND (s.update_dt) > (SELECT max(load_dt) FROM bl_cl.load_metadata)
	)
	INSERT INTO bl_3nf.ce_pizzas_types (
		pizza_type_id,
		pizza_type_src_id,
		source_system,
		source_entity,
		pizza_type_name,
		insert_dt,
		update_dt
	)
	SELECT nextval('bl_3nf.ce_pizzas_types_id_seq'),
		pizza_type_src_id,
		source_system,
		source_entity,
		pizza_type_name,
		insert_dt,
		update_dt
	FROM initial_table
	ON CONFLICT (pizza_type_src_id, source_system, source_entity) DO UPDATE
	SET 
	    pizza_type_name = EXCLUDED.pizza_type_name,
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_3nf.ce_pizzas_types;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_pizzas_sizes_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_pizzas_sizes';
    procedure_name := 'bl_cl.ce_pizzas_sizes_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_3nf.ce_pizzas_sizes;

	WITH initial_table AS (
		SELECT DISTINCT 
			COALESCE (s.pizza_size_id::varchar(255), 'N.A.') AS pizza_size_src_id,
			'BL_CL' AS source_system,
			'LKP_PIZZAS_SIZES' AS source_entity,
			COALESCE (upper(s.pizza_size_name), 'N.A.') AS pizza_size_name,
			current_timestamp AS insert_dt ,
			current_timestamp AS update_dt 
		FROM 
			bl_cl.lkp_pizzas_sizes  s
		WHERE 
			NOT EXISTS (
				SELECT 1 FROM bl_3nf.ce_pizzas_sizes t 
				WHERE upper(s.pizza_size_id::text) = upper(t.pizza_size_src_id) AND 
					upper(t.source_system) = 'BL_CL' AND 
					upper(t.source_entity) = 'LKP_PIZZAS_SIZES'
			) AND (s.update_dt) > (SELECT max(load_dt) FROM bl_cl.load_metadata)
	)
	INSERT INTO bl_3nf.ce_pizzas_sizes (
		pizza_size_id,
		pizza_size_src_id,
		source_system,
		source_entity,
		pizza_size_name,
		insert_dt,
		update_dt
	)
	SELECT nextval('bl_3nf.ce_pizzas_sizes_id_seq'),
		pizza_size_src_id,
		source_system,
		source_entity,
		pizza_size_name,
		insert_dt,
		update_dt
	FROM initial_table
	ON CONFLICT (pizza_size_src_id, source_system, source_entity) DO UPDATE
	SET 
	    pizza_size_name = EXCLUDED.pizza_size_name,
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_3nf.ce_pizzas_sizes;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_pizzas_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_pizzas';
    procedure_name := 'bl_cl.ce_pizzas_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_3nf.ce_pizzas;

	WITH initial_table AS (
		SELECT DISTINCT 
			COALESCE (s.pizza_id::text, 'N.A.') AS pizza_src_id,
			'BL_CL' AS source_system,
			'LKP_PIZZAS' AS source_entity,
			COALESCE (upper(split_part(s.pizza_src_id, '_', 1)), 'N.A.') AS pizza_name,
			COALESCE((
                SELECT DISTINCT cpt.pizza_type_id 
                FROM bl_3nf.ce_pizzas_types cpt
                LEFT JOIN bl_cl.lkp_pizzas_types lpt ON cpt.pizza_type_src_id::int = lpt.pizza_type_id
                WHERE UPPER(lpt.pizza_type_src_id) = UPPER(split_part(s.pizza_src_id, '_', 2)) AND UPPER(cpt.pizza_type_name) = UPPER(split_part(s.pizza_src_id, '_', 2))
            ), -1) AS pizza_type_id,
            COALESCE((
                SELECT DISTINCT cps.pizza_size_id 
                FROM bl_3nf.ce_pizzas_sizes cps
                LEFT JOIN bl_cl.lkp_pizzas_sizes lps ON cps.pizza_size_src_id::int = lps.pizza_size_id
                WHERE UPPER(lps.pizza_size_src_id) = UPPER(split_part(s.pizza_src_id, '_', 3)) AND UPPER(cps.pizza_size_name) = UPPER(split_part(s.pizza_src_id, '_', 3))
            ), -1) AS pizza_size_id,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt 
		FROM 
			bl_cl.lkp_pizzas  s
		WHERE 
			NOT EXISTS (
				SELECT 1 FROM bl_3nf.ce_pizzas t 
				WHERE upper(s.pizza_id::text) = upper(t.pizza_src_id) AND 
					upper(t.source_system) = 'BL_CL' AND 
					upper(t.source_entity) = 'LKP_PIZZAS'
			) AND (s.update_dt) > (SELECT max(load_dt) FROM bl_cl.load_metadata)
	)
	INSERT INTO bl_3nf.ce_pizzas (
		pizza_id,
		pizza_src_id,
		source_system,
		source_entity,
		pizza_name,
		pizza_type_id,
		pizza_size_id,
		insert_dt,
		update_dt
	)
	SELECT nextval('bl_3nf.ce_pizzas_id_seq'),
		pizza_src_id,
		source_system,
		source_entity,
		pizza_name,
		pizza_type_id,
		pizza_size_id,
		insert_dt,
		update_dt
	FROM initial_table
	ON CONFLICT (pizza_src_id, source_system, source_entity) DO UPDATE
	SET 
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_3nf.ce_pizzas;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_orders_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
	counts_before INT;
	counts_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_orders';
    procedure_name := 'bl_cl.ce_orders_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

	SELECT count(*) INTO counts_before FROM bl_3nf.ce_orders;

	WITH online_orders AS (
		SELECT DISTINCT
			COALESCE (upper(s.order_id), 'N.A.') AS order_src_id,
			'SA_ONLINE_SALES' AS source_system,
			'SRC_ONLINE_SALES' AS source_entity,
			COALESCE (TO_TIMESTAMP(s."timestamp", 'DD-MM-YY HH24:MI')::TIMESTAMP WITHOUT TIME ZONE, '1900-01-01 00:00:00'::timestamp) AS order_timestamp,
			'ONLINE'::bl_3nf.type_order AS order_type,
			'N.A.'::bl_3nf.type_offline_order AS offline_order_type,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM 
			sa_online_sales.src_online_sales s
		WHERE NOT EXISTS (
			SELECT 1 FROM bl_3nf.ce_orders t
			WHERE upper(t.order_src_id) = upper(s.order_id) AND 
				upper(t.source_system) = 'SA_ONLINE_SALES' AND 
				upper(t.source_entity) = 'SRC_ONLINE_SALES'
		) AND (s.load_timestamp) > (SELECT max(last_src_dt) FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
	),  restaurant_orders AS (
		SELECT DISTINCT
			COALESCE (upper(s.order_id), 'N.A.') AS order_src_id,
			'SA_RESTAURANT_SALES' AS source_system,
			'SRC_RESTAURANT_SALES' AS source_entity,
			COALESCE (TO_TIMESTAMP(s."timestamp", 'DD-MM-YY HH24:MI')::TIMESTAMP WITHOUT TIME ZONE, '1900-01-01 00:00:00'::timestamp) AS order_timestamp,
			'OFFLINE'::bl_3nf.type_order AS order_type,
			COALESCE (s.in_or_out::bl_3nf.type_offline_order, 'N.A.'::bl_3nf.type_offline_order) AS offline_order_type,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM 
			sa_restaurant_sales.src_restaurant_sales s
		WHERE NOT EXISTS (
			SELECT 1 FROM bl_3nf.ce_orders t
			WHERE upper(t.order_src_id) = upper(s.order_id) AND 
				upper(t.source_system) = 'SA_RESTAURANT_SALES' AND 
				upper(t.source_entity) = 'SRC_RESTAURANT_SALES'
		) AND (s.load_timestamp) > (SELECT max(last_src_dt) FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_RESTAURANT_SALES')
	)
	INSERT INTO bl_3nf.ce_orders (
		order_id,
		order_src_id,
		source_system,
		source_entity,
		order_timestamp,
		order_type,
		offline_order_type,
		insert_dt,
		update_dt 
	)
	SELECT 
		nextval('bl_3nf.ce_orders_id_seq'),
		order_src_id,
		source_system,
		source_entity,
		order_timestamp,
		order_type,
		offline_order_type,
		insert_dt,
		update_dt 
	FROM online_orders
	UNION ALL
	SELECT 
		nextval('bl_3nf.ce_orders_id_seq'),
		order_src_id,
		source_system,
		source_entity,
		order_timestamp,
		order_type,
		offline_order_type,
		insert_dt,
		update_dt 
	FROM restaurant_orders;

	GET DIAGNOSTICS rows_aff = ROW_COUNT;

	SELECT count(*) INTO counts_after FROM bl_3nf.ce_orders;


    rows_inserted := counts_after - counts_before;
    rows_updated := (rows_aff) - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;

	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_sales_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
	counts_before INT;
	counts_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_3nf.ce_sales';
    procedure_name := 'bl_cl.ce_sales_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

	SELECT count(*) INTO counts_before FROM bl_3nf.ce_sales;
	
	WITH online_sales AS (
		SELECT
			COALESCE (co.order_id, -1) AS order_id,
			-1 AS employee_id,
			COALESCE ((
				SELECT delivery_id FROM bl_3nf.ce_deliveries cd
				LEFT JOIN bl_3nf.ce_couriers cc ON cd.courier_id = cc.courier_id
				WHERE upper(s.delivery_id) = cd.delivery_src_id AND
					upper(s.courier_id) = cc.courier_src_id
			), -1) AS delivery_id,
			COALESCE ((
				SELECT customer_id FROM bl_3nf.ce_customers_scd ccs
				WHERE upper(s.customer_id) = ccs.customer_src_id AND
					ccs.source_system = 'SA_ONLINE_SALES' AND
					ccs.source_entity = 'SRC_ONLINE_SALES' AND
					ccs.is_active = 'Y'
			), -1) AS customer_id,
			COALESCE ((
				SELECT address_id FROM bl_3nf.ce_addresses ca
				LEFT JOIN bl_3nf.ce_districts cd ON ca.district_id = cd.district_id
				WHERE upper(s.district) = cd.district_src_id AND
					upper(s.address) = ca.address_src_id
			), -1) AS address_id,
			COALESCE ((
				SELECT pizza_id FROM bl_3nf.ce_pizzas cp
				LEFT JOIN bl_3nf.ce_pizzas_types cpt ON cp.pizza_type_id = cpt.pizza_type_id
--					AND cpt.source_system = 'BL_CL' AND cpt.source_entity = 'LKP_PIZZAS_TYPES'
				LEFT JOIN bl_3nf.ce_pizzas_sizes cps ON cp.pizza_size_id = cps.pizza_size_id
--					AND cpt.source_system = 'BL_CL' AND cpt.source_entity = 'LKP_PIZZAS_SIZES'
				WHERE upper(s.pizza_name) = cp.pizza_name AND
					upper(s.pizza_type) = cpt.pizza_type_name AND
					upper(s."size") = cps.pizza_size_name
					AND cp.source_system = 'BL_CL' AND cp.source_entity = 'LKP_PIZZAS'
			), -1) AS pizza_id,
			COALESCE(s.quantity::int, 0) as quantity,
			COALESCE(s.price::decimal(6,2), 0) as price,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM 
			sa_online_sales.src_online_sales s
		LEFT JOIN bl_3nf.ce_orders co ON upper(s.order_id) = co.order_src_id AND
			co.source_system = 'SA_ONLINE_SALES' AND
			co.source_entity = 'SRC_ONLINE_SALES'
		WHERE (s.load_timestamp) > (SELECT max(last_src_dt) FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES')
	),  restaurant_sales AS (
		SELECT
			COALESCE ((
				SELECT order_id FROM bl_3nf.ce_orders co
				WHERE upper(s.order_id) = co.order_src_id AND
					co.source_system = 'SA_RESTAURANT_SALES' AND
					co.source_entity = 'SRC_RESTAURANT_SALES'
			), -1) AS order_id,
			COALESCE ((
				SELECT employee_id FROM bl_3nf.ce_employees ce
				WHERE upper(s.employee_id) = ce.employee_src_id
			), -1) AS employee_id,
			-1 AS delivery_id,
			COALESCE ((
				SELECT customer_id FROM bl_3nf.ce_customers_scd ccs
				WHERE upper(s.customer_id) = ccs.customer_src_id AND
					ccs.source_system = 'SA_RESTAURANT_SALES' AND
					ccs.source_entity = 'SRC_RESTAURANT_SALES' AND
					ccs.is_active = 'Y'
			), -1) AS customer_id,
			-1 AS address_id,
			COALESCE ((
				SELECT pizza_id FROM bl_3nf.ce_pizzas cp
				LEFT JOIN bl_3nf.ce_pizzas_types cpt ON cp.pizza_type_id = cpt.pizza_type_id
--					AND cpt.source_system = 'BL_CL' AND cpt.source_entity = 'LKP_PIZZAS_TYPES'
				LEFT JOIN bl_3nf.ce_pizzas_sizes cps ON cp.pizza_size_id = cps.pizza_size_id
--					AND cpt.source_system = 'BL_CL' AND cpt.source_entity = 'LKP_PIZZAS_SIZES'
				WHERE upper(s.pizza_name) = cp.pizza_name AND
					upper(s.pizza_type) = cpt.pizza_type_name AND
					upper(s."size") = cps.pizza_size_name
					AND cp.source_system = 'BL_CL' AND cp.source_entity = 'LKP_PIZZAS'
			), -1) AS pizza_id,
			COALESCE(s.quantity::int, 0) as quantity,
			COALESCE(s.price::decimal(6,2), 0) as price,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM 
			sa_restaurant_sales.src_restaurant_sales s
		WHERE (s.load_timestamp) > (SELECT max(last_src_dt) FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_RESTAURANT_SALES')
	)
	INSERT INTO bl_3nf.ce_sales (
		order_id,
		employee_id,
		delivery_id,
		customer_id,
		address_id,
		pizza_id,
		quantity,
		price,
		insert_dt,
		update_dt 
	)
	SELECT 
		order_id,
		employee_id,
		delivery_id,
		customer_id,
		address_id,
		pizza_id,
		quantity,
		price,
		insert_dt,
		update_dt 
	FROM online_sales
	UNION ALL
	SELECT 
		order_id,
		employee_id,
		delivery_id,
		customer_id,
		address_id,
		pizza_id,
		quantity,
		price,
		insert_dt,
		update_dt 
	FROM restaurant_sales;

	GET DIAGNOSTICS rows_aff = ROW_COUNT;

	SELECT count(*) INTO counts_after FROM bl_3nf.ce_sales;


    rows_inserted := counts_after - counts_before;
    rows_updated := (rows_aff) - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;

--	COMMIT;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE bl_cl.dim_times_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_dm.dim_times';
    procedure_name := 'bl_cl.dim_times_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_dm.dim_times;

	INSERT INTO bl_dm.dim_times (
		time_id,
		time_hourofday,
		time_quarterhour,
		time_minuteofday,
		time_daytimename,
		time_daynightname
	)
	select to_char(minute, 'hh24:mi') AS TimeOfDay,
		-- Hour of the day (0 - 23)
		extract(hour from minute) as Hour, 
		-- Extract and format quarter hours
		to_char(minute - (extract(minute from minute)::integer % 15 || 'minutes')::interval, 'hh24:mi') ||
		' – ' ||
		to_char(minute - (extract(minute from minute)::integer % 15 || 'minutes')::interval + '14 minutes'::interval, 'hh24:mi')
			as QuarterHour,
		-- Minute of the day (0 - 1439)
		extract(hour from minute)*60 + extract(minute from minute) as minute,
		-- Names of day periods
		case when to_char(minute, 'hh24:mi') between '06:00' and '08:29'
			then 'Morning'
		     when to_char(minute, 'hh24:mi') between '08:30' and '11:59'
			then 'AM'
		     when to_char(minute, 'hh24:mi') between '12:00' and '17:59'
			then 'PM'
		     when to_char(minute, 'hh24:mi') between '18:00' and '22:29'
			then 'Evening'
		     else 'Night'
		end as DaytimeName,
		-- Indicator of day or night
		case when to_char(minute, 'hh24:mi') between '07:00' and '19:59' then 'Day'
		     else 'Night'
		end AS DayNight
	from (SELECT '0:00'::time + (sequence.minute || ' minutes')::interval AS minute
		FROM generate_series(0,1439) AS sequence(minute)
		GROUP BY sequence.minute
	     ) DQ
	WHERE NOT EXISTS (
	    SELECT 1 
	    FROM bl_dm.dim_times 
	    WHERE time_id = to_char(DQ.minute, 'hh24:mi')
	)
	order by 1;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_dm.dim_times;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.dim_dates_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_dm.dim_dates';
    procedure_name := 'bl_cl.dim_dates_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_dm.dim_dates;

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
		datum as Date,
		extract(year from datum) AS Year,
		extract(month from datum) AS Month,
		-- Localized month name
		to_char(datum, 'TMMonth') AS MonthName,
		extract(day from datum) AS Day,
		extract(doy from datum) AS DayOfYear,
		-- Localized weekday
		to_char(datum, 'TMDay') AS WeekdayName,
		-- ISO calendar week
		extract(week from datum) AS CalendarWeek,
		to_char(datum, 'dd. mm. yyyy') AS FormattedDate,
		'Q' || to_char(datum, 'Q') AS Quartal,
		to_char(datum, 'yyyy/"Q"Q') AS YearQuartal,
		to_char(datum, 'yyyy/mm') AS YearMonth,
		-- ISO calendar year and week
		to_char(datum, 'iyyy/IW') AS YearCalendarWeek,
		-- Weekend
		CASE WHEN extract(isodow from datum) in (6, 7) THEN 'Weekend' ELSE 'Weekday' END AS Weekend,
		-- Fixed holidays 
	        -- for Georgia
	        CASE WHEN to_char(datum, 'MMDD') IN 
	        ('0101', '0107', '0119', '0303', '0308', '0409', '0505', '0509', '0512', '0526', '0828', '1014', '1123')
			THEN 'Holiday' ELSE 'No holiday' END
			AS GeorgianHoliday,
		-- Some periods of the year, adjust for your organisation and country
		CASE WHEN to_char(datum, 'MMDD') BETWEEN '0601' AND '0831' THEN 'Summer season'
		     WHEN to_char(datum, 'MMDD') BETWEEN '1215' AND '1225' THEN 'Christmas season'
		     WHEN to_char(datum, 'MMDD') > '1225' OR to_char(datum, 'MMDD') <= '0106' THEN 'New Year Season'
			ELSE 'Normal' END
			AS Period,
		-- ISO start and end of the week of this date
		datum + (1 - extract(isodow from datum))::integer AS CWStart,
		datum + (7 - extract(isodow from datum))::integer AS CWEnd,
		-- Start and end of the month of this date
		datum + (1 - extract(day from datum))::integer AS MonthStart,
		(datum + (1 - extract(day from datum))::integer + '1 month'::interval)::date - '1 day'::interval AS MonthEnd
	FROM (
		SELECT '2021-01-01'::DATE + sequence.day AS datum
		FROM generate_series(0,1825) AS sequence(day)
		GROUP BY sequence.day
	     ) DQ
	WHERE NOT EXISTS (
	    SELECT 1 
	    FROM bl_dm.dim_dates 
	    WHERE date_id = datum
	)
	order by 1;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_dm.dim_dates;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE bl_cl.dim_addresses_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_dm.dim_addresses';
    procedure_name := 'bl_cl.dim_addresses_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_dm.dim_addresses;

	WITH init_table AS (
		SELECT 
			ca.address_id AS address_src_id,
			'BL_3NF' AS source_system,
			'CE_ADDRESSES' AS source_entity ,
			ca.address_name AS address_name,
			ca.district_id AS district_src_id ,
			cd.district_name AS distict_name,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM bl_3nf.ce_addresses ca 
		LEFT JOIN bl_3nf.ce_districts cd ON ca.district_id = cd.district_id 
		WHERE ca.address_id > 0 AND (ca.update_dt) > (SELECT max(load_dt) FROM bl_cl.load_metadata)
	)
	INSERT INTO bl_dm.dim_addresses (address_surr_id, address_src_id, source_system, source_entity, address_name, district_src_id, district_name, insert_dt, update_dt)
	SELECT 
		nextval('bl_dm.dim_addresses_surr_id_seq'),
		address_src_id,
		source_system,
		source_entity ,
		address_name,
		district_src_id ,
		distict_name,
		insert_dt,
		update_dt
	FROM init_table s
	WHERE NOT EXISTS (
		SELECT 1 FROM bl_dm.dim_addresses t 
		WHERE upper(t.address_src_id::TEXT) = upper(s.address_src_id::TEXT) AND 
			upper(t.district_src_id::TEXT) = upper(s.district_src_id::TEXT)
	);

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_dm.dim_addresses;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.dim_pizzas_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_dm.dim_pizzas';
    procedure_name := 'bl_cl.dim_pizzas_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_dm.dim_pizzas;

	WITH init_table AS (
		SELECT 
			upper(cp.pizza_id::TEXT) AS pizza_src_id,
			'BL_3NF' AS source_system,
			'CE_PIZZAS' AS source_entity ,
			cp.pizza_name AS pizza_name,
			cp.pizza_type_id AS pizza_type_src_id ,
			cpt.pizza_type_name AS pizza_type_name ,
			cp.pizza_size_id AS pizza_size_src_id ,
			cps.pizza_size_name AS pizza_size_name ,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM bl_3nf.ce_pizzas cp 
		LEFT JOIN bl_3nf.ce_pizzas_types cpt ON cp.pizza_type_id = cpt.pizza_type_id
		LEFT JOIN bl_3nf.ce_pizzas_sizes cps ON cp.pizza_size_id = cps.pizza_size_id
		WHERE cp.pizza_id > 0 AND (cp.update_dt) > (SELECT max(load_dt) FROM bl_cl.load_metadata)
	)
	INSERT INTO bl_dm.dim_pizzas (pizza_surr_id, pizza_src_id, source_system, source_entity, pizza_name, pizza_type_src_id, pizza_type_name, pizza_size_src_id, pizza_size_name, insert_dt, update_dt)
	SELECT 
		nextval('bl_dm.dim_pizzas_surr_id_seq'),
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
	FROM init_table s
	WHERE NOT EXISTS (
		SELECT 1 FROM bl_dm.dim_pizzas t 
		WHERE upper(t.pizza_src_id::TEXT) = upper(s.pizza_src_id::TEXT) AND 
			upper(t.pizza_type_src_id::TEXT) = upper(s.pizza_type_src_id::TEXT) AND 
			upper(t.pizza_size_src_id::TEXT) = upper(s.pizza_size_src_id::TEXT)
	);

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_dm.dim_pizzas;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.dim_customers_scd_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
	counts_before INT;
	counts_after INT;
    rows_aff INT;
BEGIN 

    username := current_user;
    table_name := 'bl_dm.dim_customers_scd';
    procedure_name := 'bl_cl.dim_customers_scd_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

	SELECT count(*) INTO counts_before FROM bl_dm.dim_customers_scd;

	WITH init_table AS (
		SELECT 
			customer_id::text AS customer_src_id ,
			'BL_3NF' AS source_system,
			'CE_CUSTOMERS_SCD' AS source_entity ,
			CASE 
				WHEN source_system = 'SA_ONLINE_SALES' THEN 'ONLINE'
				WHEN source_system = 'SA_RESTAURANT_SALES' THEN 'OFFLINE'
				ELSE 'MANUAL'
			END AS original_source,
			customer_full_name AS customer_full_name,
			is_active AS is_active,
			start_dt AS start_dt,
			end_dt AS end_dt,
			current_timestamp AS insert_dt
		FROM bl_3nf.ce_customers_scd s
		WHERE NOT EXISTS (            
		SELECT 1 FROM bl_dm.dim_customers_scd t 
            WHERE upper(s.customer_id::text) = upper(t.customer_src_id) AND 
				upper(t.original_source) = 'ONLINE' AND 
				upper(s.customer_full_name) = upper(t.customer_full_name) AND 
				upper(s.is_active) = upper(t.is_active) OR 
				upper(s.customer_id::text) = upper(t.customer_src_id) AND 
				upper(t.original_source) = 'OFFLINE' AND 
				upper(s.customer_full_name) = upper(t.customer_full_name) AND 
				upper(s.is_active) = upper(t.is_active)
		) AND customer_id::int > 0 AND (s.end_dt) > (SELECT max(load_dt) FROM bl_cl.load_metadata)
	)
	UPDATE bl_dm.dim_customers_scd t
	SET is_active = 'N',
		end_dt = current_timestamp
	WHERE EXISTS (
		SELECT 1 FROM init_table s
		WHERE t.customer_src_id::text = s.customer_src_id::TEXT AND 
			t.source_system = s.source_system AND 
			t.source_entity = s.source_entity AND
			t.original_source = s.original_source);

    GET DIAGNOSTICS rows_aff = ROW_COUNT;
	
	WITH init_table AS (
		SELECT 
			customer_id::text AS customer_src_id ,
			'BL_3NF' AS source_system,
			'CE_CUSTOMERS_SCD' AS source_entity ,
			CASE 
				WHEN source_system = 'SA_ONLINE_SALES' THEN 'ONLINE'
				WHEN source_system = 'SA_RESTAURANT_SALES' THEN 'OFFLINE'
				ELSE 'MANUAL'
			END AS original_source,
			customer_full_name AS customer_full_name,
			is_active AS is_active,
			start_dt AS start_dt,
			end_dt AS end_dt,
			current_timestamp AS insert_dt
		FROM bl_3nf.ce_customers_scd s
		WHERE NOT EXISTS (            
		SELECT 1 FROM bl_dm.dim_customers_scd t 
            WHERE upper(s.customer_id::text) = upper(t.customer_src_id) AND 
				upper(t.original_source) = 'ONLINE' AND 
				upper(s.customer_full_name) = upper(t.customer_full_name) OR 
				upper(s.customer_id::text) = upper(t.customer_src_id) AND 
				upper(t.original_source) = 'OFFLINE' AND 
				upper(s.customer_full_name) = upper(t.customer_full_name)
		) AND customer_id::int > 0 AND (s.end_dt) > (SELECT max(load_dt) FROM bl_cl.load_metadata)
	)
	INSERT INTO bl_dm.dim_customers_scd (customer_surr_id, customer_src_id, source_system, source_entity, original_source, customer_full_name, is_active, start_dt, end_dt, insert_dt)
	SELECT 
		nextval('bl_dm.dim_customers_scd_surr_id_seq'),
		customer_src_id, 
		source_system, 
		source_entity, 
		original_source, 
		customer_full_name, 
		is_active, 
		start_dt, 
		end_dt, 
		insert_dt
		FROM init_table;

	SELECT count(*) INTO counts_after FROM bl_dm.dim_customers_scd;


    rows_inserted := counts_after - counts_before;
    rows_updated := (rows_aff);

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;

	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.dim_orders_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT := 0;
    order_rec bl_dm.order_record_type;
    row_cursor CURSOR FOR
        SELECT DISTINCT
            co.order_id AS order_src_id,
            'BL_3NF' AS source_system,
            'CE_ORDERS' AS source_entity,
            order_src_id AS order_name,
            cs.employee_id AS employee_src_id,
            ce.employee_full_name AS employee_full_name,
            order_type AS order_type,
            offline_order_type AS offline_order_type,
            cs.delivery_id AS delivery_src_id,
            cd.delivery_name AS delivery_name,
            cd.courier_id AS courier_src_id,
            cc.courier_full_name AS courier_full_name,
            current_timestamp AS insert_dt,
            current_timestamp AS update_dt
        FROM bl_3nf.ce_orders co
		LEFT JOIN bl_3nf.ce_sales cs ON co.order_id = cs.order_id
        LEFT JOIN bl_3nf.ce_deliveries cd ON cs.delivery_id = cd.delivery_id
		LEFT JOIN bl_3nf.ce_couriers cc ON cd.courier_id = cc.courier_id
		LEFT JOIN bl_3nf.ce_employees ce ON cs.employee_id = ce.employee_id
        WHERE NOT EXISTS (
            SELECT 1 FROM bl_dm.dim_orders t
            WHERE upper(co.order_id::TEXT) = upper(t.order_src_id::TEXT) AND 
                upper(co.order_type::TEXT) = upper(t.order_type::TEXT) AND 
                upper(co.order_src_id::TEXT) = upper(t.order_name::TEXT)
        ) AND co.order_id > 0 AND (co.update_dt) > (SELECT max(load_dt) FROM bl_cl.load_metadata);
BEGIN 

	username := current_user;
    table_name := 'bl_dm.dim_orders';
    procedure_name := 'bl_cl.dim_orders_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_dm.dim_orders;

    OPEN row_cursor;

    LOOP
        FETCH row_cursor INTO order_rec;
        EXIT WHEN NOT FOUND;

        INSERT INTO bl_dm.dim_orders(order_surr_id, order_src_id, source_system, source_entity, order_name, employee_src_id, employee_full_name, order_type, offline_order_type, delivery_src_id, delivery_name, courier_src_id, courier_full_name, insert_dt, update_dt)
        VALUES (
            nextval('bl_dm.dim_orders_surr_id_seq'),
            order_rec.order_src_id, 
            order_rec.source_system, 
            order_rec.source_entity, 
            order_rec.order_name, 
            order_rec.employee_src_id, 
            order_rec.employee_full_name, 
            order_rec.order_type, 
            order_rec.offline_order_type, 
            order_rec.delivery_src_id, 
            order_rec.delivery_name, 
            order_rec.courier_src_id, 
            order_rec.courier_full_name, 
            order_rec.insert_dt, 
            order_rec.update_dt
        );

	rows_aff := rows_aff + 1;

    END LOOP;

    CLOSE row_cursor;

    SELECT count(*) INTO count_after FROM bl_dm.dim_orders;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;

--	COMMIT;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.fct_sales_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime TEXT,
    OUT status text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 
    username := current_user;
    table_name := 'bl_dm.fct_sales';
    procedure_name := 'bl_cl.fct_sales_procedure';
    procedure_starttime := current_timestamp::text;
	status := 'Success';

    SELECT count(*) INTO count_before FROM bl_dm.fct_sales;

    WITH init_table AS (
        SELECT 
            COALESCE (do2.order_surr_id, -1) AS order_surr_id,
            COALESCE (cs.customer_surr_id, -1) AS customer_surr_id,
            COALESCE (dp.pizza_surr_id, -1) AS pizza_surr_id,
            COALESCE (da.address_surr_id, -1) AS address_surr_id, 
            COALESCE (dd.date_id, '1900-01-01'::date) AS event_dt,
			CASE 
				WHEN COALESCE (dd.date_id, '1900-01-01'::date) = '1900-01-01'::date THEN 'N.A.'
				ELSE COALESCE (dt.time_id, 'N.A.')
			END AS event_time,
			COALESCE (co.quantity, 0) as quantity,
            COALESCE (co.price, 0) AS price,
			(co.quantity * co.price) AS fct_cost_order,
            current_timestamp AS insert_dt,
            current_timestamp AS update_dt
        FROM bl_3nf.ce_sales co
		LEFT JOIN bl_3nf.ce_orders css ON co.order_id = css.order_id
        LEFT JOIN bl_dm.dim_orders do2 ON do2.order_src_id = co.order_id::text
            AND upper(do2.source_system) = 'BL_3NF' AND upper(do2.source_entity) = 'CE_ORDERS'
        LEFT JOIN bl_dm.dim_customers_scd cs ON upper(cs.customer_src_id) = upper(co.customer_id::text)
            AND upper(cs.original_source) = upper(css.order_type::TEXT) AND upper(cs.is_active) = 'Y'
            AND upper(cs.source_system) = 'BL_3NF' AND upper(cs.source_entity) = 'CE_CUSTOMERS_SCD'
        LEFT JOIN bl_dm.dim_pizzas dp ON upper(dp.pizza_src_id) = upper(co.pizza_id::text)
            AND upper(dp.source_system) = 'BL_3NF' AND upper(dp.source_entity) = 'CE_PIZZAS'
        LEFT JOIN bl_dm.dim_addresses da ON upper(da.address_src_id) = upper(co.address_id::text)
            AND upper(da.source_system) = 'BL_3NF' AND upper(da.source_entity) = 'CE_ADDRESSES'
        LEFT JOIN bl_dm.dim_dates dd ON css.order_timestamp::date = dd.date_id
        LEFT JOIN bl_dm.dim_times dt ON TO_CHAR(css.order_timestamp::time, 'HH24:MI') = dt.time_id
        WHERE (co.update_dt) > (SELECT max(load_dt) FROM bl_cl.load_metadata)
    )
    INSERT INTO bl_dm.fct_sales (
        customer_surr_id,
        order_surr_id,
        pizza_surr_id,
        event_time,
        address_surr_id,
        event_dt,
		quantity,
        price,
        fct_cost_order,
        insert_dt,
        update_dt
    )
    SELECT     
        customer_surr_id,
        order_surr_id,
        pizza_surr_id,
        event_time,
        address_surr_id,
        event_dt,
		quantity,
        price,
        fct_cost_order,
        insert_dt,
        update_dt
    FROM init_table;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_dm.fct_sales;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;

EXCEPTION
    WHEN OTHERS THEN
        status := 'Error: ' || SQLERRM;
        rows_updated := 0;
        rows_inserted := 0;
    
--	COMMIT;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION bl_cl.procedures_to_log()
RETURNS TABLE (
    username name,
    table_name text,
    procedure_name text,
    rows_updated int,
    rows_inserted int,
    procedure_timestamp text,
    status text
) AS $$
DECLARE
    v_username name;
    v_table_name text;
    v_procedure_name text;
    v_rows_updated int;
    v_rows_inserted int;
    v_procedure_timestamp text;
    v_status text;
    v_procedures text[] := ARRAY[
		'bl_cl.src_online_sales_procedure',
		'bl_cl.src_restaurant_sales_procedure',
		'bl_cl.rolling_window_partitions',
		'bl_cl.default_rows_procedure',
        'bl_cl.lkp_pizzas_sizes_procedure',
        'bl_cl.lkp_pizzas_procedure',
        'bl_cl.lkp_pizzas_types_procedure',
        'bl_cl.ce_couriers_procedure',
        'bl_cl.ce_deliveries_procedure',
        'bl_cl.ce_customers_scd_procedure',
        'bl_cl.ce_districts_procedure',
        'bl_cl.ce_addresses_procedure',
        'bl_cl.ce_employees_procedure',
        'bl_cl.ce_pizzas_types_procedure',
        'bl_cl.ce_pizzas_sizes_procedure',
        'bl_cl.ce_pizzas_procedure',
        'bl_cl.ce_orders_procedure',
		'bl_cl.ce_sales_procedure',
		'bl_cl.dim_times_procedure',
		'bl_cl.dim_dates_procedure',
        'bl_cl.dim_addresses_procedure',
        'bl_cl.dim_pizzas_procedure',
        'bl_cl.dim_customers_scd_procedure',
        'bl_cl.dim_orders_procedure',
		'bl_cl.fct_sales_procedure',
		'bl_cl.upd_load_metadata'
    ];
BEGIN

    FOREACH v_procedure_name IN ARRAY v_procedures
    LOOP
        BEGIN
            EXECUTE format('CALL %s($1, $2, $3, $4, $5, $6, $7)', v_procedure_name)
            INTO v_username, v_table_name, v_procedure_name, v_rows_updated, v_rows_inserted, v_procedure_timestamp, v_status
            USING v_username, v_table_name, v_procedure_name, v_rows_updated, v_rows_inserted, v_procedure_timestamp, v_status;

            RETURN QUERY SELECT v_username, v_table_name, v_procedure_name, v_rows_updated, v_rows_inserted, v_procedure_timestamp, v_status;

        END;
    END LOOP;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.master_procedure()
AS $$
BEGIN 

	INSERT INTO bl_cl.procedure_log (
		username,
		table_name,
		procedure_name,
		rows_updated,
		rows_inserted,
		procedure_timestamp,
		status
	)
	SELECT username, table_name, procedure_name, rows_updated, rows_inserted, procedure_timestamp, status FROM bl_cl.procedures_to_log();

END;
$$ LANGUAGE plpgsql;

--CALL bl_cl.master_procedure();

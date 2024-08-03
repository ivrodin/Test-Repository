CREATE TABLE IF NOT EXISTS bl_cl.procedure_log (
	username name,
	table_name varchar(255),
	procedure_name varchar(255),
	rows_updated int,
	rows_inserted int,
	procesure_starttime varchar(50),
	status varchar(255)
);


CREATE OR REPLACE FUNCTION bl_cl.lkp_cust_ids(src_id varchar(255))
RETURNS INT AS $$
DECLARE 
	result_id int;
BEGIN
	IF EXISTS (SELECT 1 FROM bl_cl.lkp_customers WHERE upper(customer_src_id) = upper(src_id)) THEN
		SELECT customer_id INTO result_id FROM bl_cl.lkp_customers 
			WHERE upper(customer_src_id) = upper(src_id);
	ELSE
		SELECT nextval('bl_cl.lkp_customers_id_seq') INTO result_id;
	END IF;
	RETURN result_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bl_cl.lkp_pizza_type_ids(src_id varchar(255))
RETURNS INT AS $$
DECLARE 
	result_id int;
BEGIN
	IF EXISTS (SELECT 1 FROM bl_cl.lkp_pizzas_types WHERE upper(pizza_type_src_id) = upper(src_id)) THEN
		SELECT pizza_type_id INTO result_id FROM bl_cl.lkp_pizzas_types
			WHERE upper(pizza_type_src_id) = upper(src_id);
	ELSE
		SELECT nextval('bl_cl.lkp_pizzas_types_id_seq') INTO result_id;
	END IF;
	RETURN result_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bl_cl.lkp_pizza_size_ids(src_id varchar(255))
RETURNS INT AS $$
DECLARE 
	result_id int;
BEGIN
	IF EXISTS (SELECT 1 FROM bl_cl.lkp_pizzas_sizes WHERE upper(pizza_size_src_id) = upper(src_id)) THEN
		SELECT pizza_size_id INTO result_id FROM bl_cl.lkp_pizzas_sizes
			WHERE upper(pizza_size_src_id) = upper(src_id);
	ELSE
		SELECT nextval('bl_cl.lkp_pizzas_sizes_id_seq') INTO result_id;
	END IF;
	RETURN result_id;
END;
$$ LANGUAGE plpgsql;

SELECT max(update_dt) FROM bl_cl.lkp_customers WHERE customer_src_id = 'CUST0069';

CREATE OR REPLACE PROCEDURE bl_cl.lkp_pizzas_sizes_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff_online INT;
    rows_aff_offline INT;
BEGIN 

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
            )
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
        (SELECT * FROM bl_cl.lkp_pizza_size_ids(pizza_size_src_id)),
        pizza_size_src_id,
        source_system,
        source_entity,
        pizza_size_name,
        insert_dt,
        update_dt 
    FROM init_src
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
            )
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
        (SELECT * FROM bl_cl.lkp_pizza_size_ids(pizza_size_src_id)),
        pizza_size_src_id,
        source_system,
        source_entity,
        pizza_size_name,
        insert_dt,
        update_dt 
    FROM init_src
    ON CONFLICT (pizza_size_src_id, source_system, source_entity) DO UPDATE
    SET 
        pizza_size_name = EXCLUDED.pizza_size_name,
        update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff_offline = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_cl.lkp_pizzas_sizes;

    rows_inserted := count_after - count_before;
    rows_updated := (rows_aff_online + rows_aff_offline) - rows_inserted;
    username := current_user;
    table_name := 'bl_cl.lkp_pizzas_sizes';
    procedure_name := 'bl_cl.lkp_pizzas_sizes_procedure';
    procedure_starttime := current_timestamp::text;
    
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.lkp_customers_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff_online INT;
    rows_aff_offline INT;
BEGIN 

    SELECT count(*) INTO count_before FROM bl_cl.lkp_customers;

	WITH init_src AS (
		SELECT DISTINCT 
		    COALESCE(UPPER(s.customer_id), 'N.A.') AS customer_src_id,
		    'SA_ONLINE_SALES' AS source_system,
		    'SRC_ONLINE_SALES' AS source_entity,
		    COALESCE(UPPER(s.customer_full_name), 'N.A.') AS customer_full_name,
		    CURRENT_TIMESTAMP AS insert_dt,
		    CURRENT_TIMESTAMP AS update_dt
		FROM 
		    sa_online_sales.src_online_sales s
		WHERE NOT EXISTS (
		    SELECT 1 
		    FROM bl_cl.lkp_customers t
		    WHERE UPPER(s.customer_id) = UPPER(t.customer_src_id)
		    	AND UPPER(t.source_system) = 'SA_ONLINE_SALES'
		    	AND UPPER(t.source_entity) = 'SRC_ONLINE_SALES'
				AND UPPER(t.customer_full_name) = upper(s.customer_full_name)
		)
	)
	INSERT INTO bl_cl.lkp_customers (
	    customer_id,
	    customer_src_id,
	    source_system,
	    source_entity,
	    customer_full_name,
	    insert_dt,
	    update_dt
	)
	SELECT 
	    (SELECT * FROM bl_cl.lkp_cust_ids(customer_src_id)),
	    customer_src_id,
	    source_system,
	    source_entity,
	    customer_full_name,
	    insert_dt,
	    update_dt  
	FROM init_src
	ON CONFLICT (customer_src_id, source_system, source_entity) DO UPDATE
	SET 
	    customer_full_name = EXCLUDED.customer_full_name,
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff_online = ROW_COUNT;


	WITH init_src AS (
		SELECT DISTINCT
		    COALESCE(UPPER(s.customer_id), 'N.A.') AS customer_src_id,
		    'SA_RESTAURANT_SALES' AS source_system,
		    'SRC_RESTAURANT_SALES' AS source_entity,
		    COALESCE(UPPER(s.customer_full_name), 'N.A.') AS customer_full_name,
		    CURRENT_TIMESTAMP AS insert_dt,
		    CURRENT_TIMESTAMP AS update_dt
		FROM 
		    sa_restaurant_sales.src_restaurant_sales s
		WHERE NOT EXISTS (
		    SELECT 1 
		    FROM bl_cl.lkp_customers t
		    WHERE UPPER(s.customer_id) = UPPER(t.customer_src_id)
		    	AND UPPER(t.source_system) = 'SA_RESTAURANT_SALES'
		    	AND UPPER(t.source_entity) = 'SRC_RESTAURANT_SALES'
				AND UPPER(t.customer_full_name) = upper(s.customer_full_name)
		)
	)
	INSERT INTO bl_cl.lkp_customers (
	    customer_id,
	    customer_src_id,
	    source_system,
	    source_entity,
	    customer_full_name,
	    insert_dt,
	    update_dt
	)
	SELECT 
	    (SELECT * FROM bl_cl.lkp_cust_ids(customer_src_id)),
	    customer_src_id,
	    source_system,
	    source_entity,
	    customer_full_name,
	    insert_dt,
	    update_dt  
	FROM init_src
	ON CONFLICT (customer_src_id, source_system, source_entity) DO UPDATE
	SET 
	    customer_full_name = EXCLUDED.customer_full_name,
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff_offline = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_cl.lkp_customers;

    rows_inserted := count_after - count_before;
    rows_updated := (rows_aff_online + rows_aff_offline) - rows_inserted;
    username := current_user;
    table_name := 'bl_cl.lkp_customers';
    procedure_name := 'bl_cl.lkp_customers_procedure';
    procedure_starttime := current_timestamp::text;
    
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.lkp_pizzas_types_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff_online INT;
    rows_aff_offline INT;
BEGIN 

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
            )
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
        (SELECT * FROM bl_cl.lkp_pizza_type_ids(pizza_type_src_id)),
        pizza_type_src_id,
        source_system,
        source_entity,
        pizza_type_name,
        insert_dt,
        update_dt 
    FROM init_src
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
            )
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
        (SELECT * FROM bl_cl.lkp_pizza_type_ids(pizza_type_src_id)),
        pizza_type_src_id,
        source_system,
        source_entity,
        pizza_type_name,
        insert_dt,
        update_dt 
    FROM init_src
    ON CONFLICT (pizza_type_src_id, source_system, source_entity) DO UPDATE
    SET 
        pizza_type_name = EXCLUDED.pizza_type_name,
        update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff_offline = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_cl.lkp_pizzas_types;

    rows_inserted := count_after - count_before;
    rows_updated := (rows_aff_online + rows_aff_offline) - rows_inserted;
    username := current_user;
    table_name := 'bl_cl.lkp_pizzas_types';
    procedure_name := 'bl_cl.lkp_pizzas_types_procedure';
    procedure_starttime := current_timestamp::text;

END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE bl_cl.ce_couriers_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    SELECT count(*) INTO count_before FROM bl_3nf.ce_couriers;

	WITH initial_table AS (
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
		)
	)
	INSERT INTO bl_3nf.ce_couriers (
		courier_id,
		courier_src_id,
		source_system,
		source_entity,
		courier_full_name,
		insert_dt,
		update_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_couriers WHERE courier_id = -1)
	UNION 
	SELECT nextval('bl_3nf.ce_couriers_id_seq'),
		courier_src_id,
		source_system,
		source_entity,
		courier_full_name,
		insert_dt,
		update_dt
	FROM initial_table
	ON CONFLICT (courier_src_id, source_system, source_entity) DO UPDATE
	SET 
	    courier_full_name = EXCLUDED.courier_full_name,
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_3nf.ce_couriers;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;
    username := current_user;
    table_name := 'bl_3nf.ce_couriers';
    procedure_name := 'bl_cl.ce_couriers_procedure';
    procedure_starttime := current_timestamp::text;
    
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_deliveries_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

    SELECT count(*) INTO count_before FROM bl_3nf.ce_deliveries;

	WITH initial_table AS (
		SELECT 
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
		)
		GROUP BY 
			delivery_id, delivery_name, courier_id
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
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', -1, '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_deliveries WHERE delivery_id = -1)
	UNION ALL
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
    username := current_user;
    table_name := 'bl_3nf.ce_deliveries';
    procedure_name := 'bl_cl.ce_deliveries_procedure';
    procedure_starttime := current_timestamp::text;
    
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_customers_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 
    SELECT count(*) INTO count_before FROM bl_3nf.ce_customers;

	WITH initial_table AS (
		SELECT DISTINCT 
			COALESCE (s.customer_id::varchar(255), 'N.A.') AS customer_src_id,
			'BL_CL' AS source_system,
			'LKP_CUSTOMERS' AS source_entity,
			COALESCE (upper(s.customer_full_name), 'N.A.') AS customer_full_name,
			current_timestamp AS insert_dt,
			current_timestamp AS update_dt
		FROM 
			bl_cl.lkp_customers  s
		WHERE NOT EXISTS (
				SELECT 1 FROM bl_3nf.ce_customers t 
				WHERE upper(s.customer_id::text) = upper(t.customer_src_id) AND 
					upper(t.source_system) = 'BL_CL' AND 
					upper(t.source_entity) = 'LKP_CUSTOMERS' AND
					upper((SELECT DISTINCT customer_full_name FROM bl_cl.lkp_customers
						WHERE upper(customer_id::text) = upper(t.customer_src_id) AND 
							update_dt = (SELECT max(update_dt) FROM bl_cl.lkp_customers
								WHERE upper(customer_id::text) = upper(t.customer_src_id)))) = upper(t.customer_full_name)
		)
	)
	INSERT INTO bl_3nf.ce_customers (
		customer_id,
		customer_src_id,
		source_system,
		source_entity,
		customer_full_name,
		insert_dt,
		update_dt
	)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.','1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_customers WHERE customer_id = -1)
	UNION ALL 
	SELECT nextval('bl_3nf.ce_customers_id_seq'),
		customer_src_id,
		source_system,
		source_entity,
		customer_full_name,
		insert_dt,
		update_dt
	FROM initial_table
	ON CONFLICT (customer_src_id, source_system, source_entity) DO UPDATE
	SET 
	    customer_full_name = EXCLUDED.customer_full_name,
	    update_dt = EXCLUDED.update_dt;

    GET DIAGNOSTICS rows_aff = ROW_COUNT;

    SELECT count(*) INTO count_after FROM bl_3nf.ce_customers;

    rows_inserted := count_after - count_before;
    rows_updated := rows_aff - rows_inserted;
    username := current_user;
    table_name := 'bl_3nf.ce_customers';
    procedure_name := 'bl_cl.ce_customers_procedure';
    procedure_starttime := current_timestamp::text;
    
END;
$$ LANGUAGE plpgsql;


















CREATE OR REPLACE PROCEDURE bl_cl.ce_districts_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

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
		)
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
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_districts WHERE district_id = -1)
	UNION 
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
    username := current_user;
    table_name := 'bl_3nf.ce_districts';
    procedure_name := 'bl_cl.ce_districts_procedure';
    procedure_starttime := current_timestamp::text;
    
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_addresses_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

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
		)
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
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', -1, '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_addresses WHERE address_id = -1)
	UNION 
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
    username := current_user;
    table_name := 'bl_3nf.ce_addresses';
    procedure_name := 'bl_cl.ce_addresses_procedure';
    procedure_starttime := current_timestamp::text;
    
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_employees_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

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
		)
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
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_employees WHERE employee_id = -1)
	UNION 
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
    username := current_user;
    table_name := 'bl_3nf.ce_employees';
    procedure_name := 'bl_cl.ce_employees_procedure';
    procedure_starttime := current_timestamp::text;
    
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_pizzas_types_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 

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
					upper(t.source_entity) = 'LKP_PIZZAS_TYPES' AND
					upper((SELECT pizza_type_name FROM bl_cl.lkp_pizzas_types
						WHERE update_dt = (SELECT max(update_dt) FROM bl_cl.lkp_pizzas_types
							WHERE upper(pizza_type_id::text) = upper(t.pizza_type_src_id)))) = upper(t.pizza_type_name)
		)
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
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_pizzas_types WHERE pizza_type_id = -1)
	UNION ALL
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
    username := current_user;
    table_name := 'bl_3nf.ce_pizzas_types';
    procedure_name := 'bl_cl.ce_pizzas_types_procedure';
    procedure_starttime := current_timestamp::text;
    
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_pizzas_sizes_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
    count_before INT;
    count_after INT;
    rows_aff INT;
BEGIN 
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
					upper(t.source_entity) = 'LKP_PIZZAS_SIZES' AND 
					upper((SELECT pizza_size_name FROM bl_cl.lkp_pizzas_sizes 
						WHERE update_dt = (SELECT max(update_dt) FROM bl_cl.lkp_pizzas_sizes 
							WHERE upper(pizza_size_id::text) = upper(t.pizza_size_src_id)))) = upper(t.pizza_size_name)
			)
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
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', '1900-01-01'::date , '1900-01-01'::date
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_pizzas_sizes WHERE pizza_size_id = -1)
	UNION 
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
    username := current_user;
    table_name := 'bl_3nf.ce_pizzas_sizes';
    procedure_name := 'bl_cl.ce_pizzas_sizes_procedure';
    procedure_starttime := current_timestamp::text;
    
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE bl_cl.ce_pizzas_scd_procedure(
    OUT username name,
    OUT table_name text,
    OUT procedure_name text,
    OUT rows_updated int,
    OUT rows_inserted int,
    OUT procedure_starttime text
) AS $$
DECLARE 
	counts_before INT;
	counts_after INT;
	rows_aff_default INT;
    rows_aff_online INT;  
    rows_aff_offline INT;
BEGIN 

	SELECT count(*) INTO counts_before FROM bl_3nf.ce_pizzas_scd;

	INSERT INTO bl_3nf.ce_pizzas_scd (pizza_id, pizza_src_id, source_system, source_entity, pizza_name, pizza_type_id, pizza_size_id, pizza_price, is_active, start_dt, end_dt, insert_dt)
	SELECT -1, 'N.A.', 'MANUAL', 'MANUAL', 'N.A.', -1, -1, -1, 'N.A.', '1900-01-01'::date , '1900-01-01'::timestamp, '1900-01-01'::timestamp
	WHERE NOT EXISTS (SELECT 1 FROM bl_3nf.ce_pizzas_scd WHERE pizza_id = -1);

    GET DIAGNOSTICS rows_aff_default = ROW_COUNT;

	WITH src_cte AS (
        SELECT DISTINCT 
            COALESCE(UPPER(s.pizza_name || '_' || s.pizza_type || '_' || s."size"), 'N.A.') AS pizza_src_id,
            'SA_ONLINE_SALES' AS source_system,
            'SRC_ONLINE_SALES' AS source_entity,
            COALESCE(UPPER(s.pizza_name), 'N.A.') AS pizza_name,
            COALESCE((
                SELECT DISTINCT cpt.pizza_type_id 
                FROM bl_3nf.ce_pizzas_types cpt
                LEFT JOIN bl_cl.lkp_pizzas_types lpt ON cpt.pizza_type_src_id::int = lpt.pizza_type_id
                WHERE UPPER(lpt.pizza_type_src_id) = UPPER(s.pizza_type) AND UPPER(cpt.pizza_type_name) = UPPER(s.pizza_type)
            ), -1) AS pizza_type_id,
            COALESCE((
                SELECT DISTINCT cps.pizza_size_id 
                FROM bl_3nf.ce_pizzas_sizes cps
                LEFT JOIN bl_cl.lkp_pizzas_sizes lps ON cps.pizza_size_src_id::int = lps.pizza_size_id
                WHERE UPPER(lps.pizza_size_src_id) = UPPER(s."size") AND UPPER(cps.pizza_size_name) = UPPER(s."size")
            ), -1) AS pizza_size_id,
            COALESCE(s.price::decimal(6,2), -1) AS pizza_price,
            COALESCE('Y', 'N.A.') AS is_active,
            COALESCE(MIN(TO_TIMESTAMP(s."timestamp", 'DD-MM-YY')) OVER (PARTITION BY s.pizza_name, s.pizza_type, s."size"), '1900-01-01'::timestamp) AS start_dt,
            '9999-12-31'::timestamp AS end_dt,
            current_timestamp AS insert_dt
        FROM sa_online_sales.src_online_sales s
		WHERE NOT EXISTS (
            SELECT 1 FROM bl_3nf.ce_pizzas_scd t 
            WHERE upper(s.pizza_name || '_' || s.pizza_type || '_' || s."size") = upper(t.pizza_src_id) AND 
                upper(t.source_system) = 'SA_ONLINE_SALES' AND 
                upper(t.source_entity) = 'SRC_ONLINE_SALES' AND
				s.price::decimal(6,2) = t.pizza_price
		)
	)
	UPDATE bl_3nf.ce_pizzas_scd t
	SET is_active = 'N',
		end_dt = current_timestamp
	WHERE EXISTS (
		SELECT 1 FROM src_cte s 
			WHERE upper(t.pizza_src_id) = upper(s.pizza_src_id) AND
	            upper(t.source_system) = 'SA_ONLINE_SALES' AND 
	            upper(t.source_entity) = 'SRC_ONLINE_SALES'
		);

    GET DIAGNOSTICS rows_aff_online = ROW_COUNT;
	
	with src_cte as (
		SELECT DISTINCT 
            COALESCE(UPPER(s.pizza_name || '_' || s.pizza_type || '_' || s."size"), 'N.A.') AS pizza_src_id,
            'SA_ONLINE_SALES' AS source_system,
            'SRC_ONLINE_SALES' AS source_entity,
            COALESCE(UPPER(s.pizza_name), 'N.A.') AS pizza_name,
            COALESCE((
                SELECT DISTINCT cpt.pizza_type_id 
                FROM bl_3nf.ce_pizzas_types cpt
                LEFT JOIN bl_cl.lkp_pizzas_types lpt ON cpt.pizza_type_src_id::int = lpt.pizza_type_id
                WHERE UPPER(lpt.pizza_type_src_id) = UPPER(s.pizza_type) AND UPPER(cpt.pizza_type_name) = UPPER(s.pizza_type)
            ), -1) AS pizza_type_id,
            COALESCE((
                SELECT DISTINCT cps.pizza_size_id 
                FROM bl_3nf.ce_pizzas_sizes cps
                LEFT JOIN bl_cl.lkp_pizzas_sizes lps ON cps.pizza_size_src_id::int = lps.pizza_size_id
                WHERE UPPER(lps.pizza_size_src_id) = UPPER(s."size") AND UPPER(cps.pizza_size_name) = UPPER(s."size")
            ), -1) AS pizza_size_id,
            COALESCE(s.price::decimal(6,2), -1) AS pizza_price,
            COALESCE('Y', 'N.A.') AS is_active,
            COALESCE(MIN(TO_TIMESTAMP(s."timestamp", 'DD-MM-YY')) OVER (PARTITION BY s.pizza_name, s.pizza_type, s."size"), '1900-01-01'::timestamp) AS start_dt,
            '9999-12-31'::timestamp AS end_dt,
            current_timestamp AS insert_dt
        FROM sa_online_sales.src_online_sales s
		WHERE NOT EXISTS (
            SELECT 1 FROM bl_3nf.ce_pizzas_scd t 
            WHERE upper(s.pizza_name || '_' || s.pizza_type || '_' || s."size") = upper(t.pizza_src_id) AND 
                upper(t.source_system) = 'SA_ONLINE_SALES' AND 
                upper(t.source_entity) = 'SRC_ONLINE_SALES' AND
				s.price::decimal(6,2) = t.pizza_price
		)
	)
	INSERT INTO bl_3nf.ce_pizzas_scd (pizza_id, pizza_src_id, source_system, source_entity, pizza_name, pizza_type_id, pizza_size_id, pizza_price, is_active, start_dt, end_dt, insert_dt)
    SELECT 
        nextval('bl_3nf.ce_pizzas_scd_id_seq'),
        s.pizza_src_id,
        s.source_system,
        s.source_entity,
        s.pizza_name,
        s.pizza_type_id,
        s.pizza_size_id,
        s.pizza_price,
        s.is_active,
        s.start_dt,
        s.end_dt,
        s.insert_dt
	FROM src_cte s;

	WITH src_cte AS (
        SELECT DISTINCT 
            COALESCE(UPPER(s.pizza_name || '_' || s.pizza_type || '_' || s."size"), 'N.A.') AS pizza_src_id,
            'SA_RESTAURANT_SALES' AS source_system,
            'SRC_RESTAURANT_SALES' AS source_entity,
            COALESCE(UPPER(s.pizza_name), 'N.A.') AS pizza_name,
            COALESCE((
                SELECT DISTINCT cpt.pizza_type_id 
                FROM bl_3nf.ce_pizzas_types cpt
                LEFT JOIN bl_cl.lkp_pizzas_types lpt ON cpt.pizza_type_src_id::int = lpt.pizza_type_id
                WHERE UPPER(lpt.pizza_type_src_id) = UPPER(s.pizza_type) AND UPPER(cpt.pizza_type_name) = UPPER(s.pizza_type)
            ), -1) AS pizza_type_id,
            COALESCE((
                SELECT DISTINCT cps.pizza_size_id 
                FROM bl_3nf.ce_pizzas_sizes cps
                LEFT JOIN bl_cl.lkp_pizzas_sizes lps ON cps.pizza_size_src_id::int = lps.pizza_size_id
                WHERE UPPER(lps.pizza_size_src_id) = UPPER(s."size") AND UPPER(cps.pizza_size_name) = UPPER(s."size")
            ), -1) AS pizza_size_id,
            COALESCE(s.price::decimal(6,2), -1) AS pizza_price,
            COALESCE('Y', 'N.A.') AS is_active,
            COALESCE(MIN(TO_TIMESTAMP(s."timestamp", 'DD-MM-YY')) OVER (PARTITION BY s.pizza_name, s.pizza_type, s."size"), '1900-01-01'::timestamp) AS start_dt,
            '9999-12-31'::timestamp AS end_dt,
            current_timestamp AS insert_dt
        FROM sa_restaurant_sales.src_restaurant_sales s
		WHERE NOT EXISTS (
            SELECT 1 FROM bl_3nf.ce_pizzas_scd t 
            WHERE upper(s.pizza_name || '_' || s.pizza_type || '_' || s."size") = upper(t.pizza_src_id) AND 
                upper(t.source_system) = 'SA_RESTAURANT_SALES' AND 
                upper(t.source_entity) = 'SRC_RESTAURANT_SALES' AND
				s.price::decimal(6,2) = t.pizza_price
		)
	)
	UPDATE bl_3nf.ce_pizzas_scd t
	SET is_active = 'N',
		end_dt = current_timestamp
	WHERE EXISTS (
		SELECT 1 FROM src_cte s 
			WHERE upper(t.pizza_src_id) = upper(s.pizza_src_id) AND
				upper(t.source_system) = 'SA_RESTAURANT_SALES' AND 
                upper(t.source_entity) = 'SRC_RESTAURANT_SALES'
		);

    GET DIAGNOSTICS rows_aff_offline = ROW_COUNT;
	
	with src_cte as (
		SELECT DISTINCT 
            COALESCE(UPPER(s.pizza_name || '_' || s.pizza_type || '_' || s."size"), 'N.A.') AS pizza_src_id,
            'SA_RESTAURANT_SALES' AS source_system,
            'SRC_RESTAURANT_SALES' AS source_entity,
            COALESCE(UPPER(s.pizza_name), 'N.A.') AS pizza_name,
            COALESCE((
                SELECT DISTINCT cpt.pizza_type_id 
                FROM bl_3nf.ce_pizzas_types cpt
                LEFT JOIN bl_cl.lkp_pizzas_types lpt ON cpt.pizza_type_src_id::int = lpt.pizza_type_id
                WHERE UPPER(lpt.pizza_type_src_id) = UPPER(s.pizza_type) AND UPPER(cpt.pizza_type_name) = UPPER(s.pizza_type)
            ), -1) AS pizza_type_id,
            COALESCE((
                SELECT DISTINCT cps.pizza_size_id 
                FROM bl_3nf.ce_pizzas_sizes cps
                LEFT JOIN bl_cl.lkp_pizzas_sizes lps ON cps.pizza_size_src_id::int = lps.pizza_size_id
                WHERE UPPER(lps.pizza_size_src_id) = UPPER(s."size") AND UPPER(cps.pizza_size_name) = UPPER(s."size")
            ), -1) AS pizza_size_id,
            COALESCE(s.price::decimal(6,2), -1) AS pizza_price,
            COALESCE('Y', 'N.A.') AS is_active,
            COALESCE(MIN(TO_TIMESTAMP(s."timestamp", 'DD-MM-YY')) OVER (PARTITION BY s.pizza_name, s.pizza_type, s."size"), '1900-01-01'::timestamp) AS start_dt,
            '9999-12-31'::timestamp AS end_dt,
            current_timestamp AS insert_dt
        FROM sa_restaurant_sales.src_restaurant_sales s
		WHERE NOT EXISTS (
            SELECT 1 FROM bl_3nf.ce_pizzas_scd t 
            WHERE upper(s.pizza_name || '_' || s.pizza_type || '_' || s."size") = upper(t.pizza_src_id) AND 
                upper(t.source_system) = 'SA_RESTAURANT_SALES' AND 
                upper(t.source_entity) = 'SRC_RESTAURANT_SALES' AND
				s.price::decimal(6,2) = t.pizza_price
		)
	)
	INSERT INTO bl_3nf.ce_pizzas_scd (pizza_id, pizza_src_id, source_system, source_entity, pizza_name, pizza_type_id, pizza_size_id, pizza_price, is_active, start_dt, end_dt, insert_dt)
    SELECT 
        nextval('bl_3nf.ce_pizzas_scd_id_seq'),
        s.pizza_src_id,
        s.source_system,
        s.source_entity,
        s.pizza_name,
        s.pizza_type_id,
        s.pizza_size_id,
        s.pizza_price,
        s.is_active,
        s.start_dt,
        s.end_dt,
        s.insert_dt
	FROM src_cte s;



	SELECT count(*) INTO counts_after FROM bl_3nf.ce_pizzas_scd;

    username := current_user;
    table_name := 'bl_3nf.ce_pizzas_scd';
    procedure_name := 'bl_cl.ce_pizzas_scd_procedure';
    rows_inserted := counts_after - counts_before;
    rows_updated := (rows_aff_online + rows_aff_offline);
    procedure_starttime := current_timestamp::text;

END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION bl_cl.bl_3nf_procedures_to_log()
RETURNS TABLE (
    username name,
    table_name text,
    procedure_name text,
    rows_updated int,
    rows_inserted int,
    procedure_starttime text,
    status text
) AS $$
DECLARE
    v_username name;
    v_table_name text;
    v_procedure_name text;
    v_rows_updated int;
    v_rows_inserted int;
    v_procedure_starttime text;
    v_status text;
    v_procedures text[] := ARRAY[
        'bl_cl.lkp_pizzas_sizes_procedure',
        'bl_cl.lkp_customers_procedure',
        'bl_cl.lkp_pizzas_types_procedure',
        'bl_cl.ce_couriers_procedure',
        'bl_cl.ce_deliveries_procedure',
        'bl_cl.ce_customers_procedure',
        'bl_cl.ce_districts_procedure',
        'bl_cl.ce_addresses_procedure',
        'bl_cl.ce_employees_procedure',
        'bl_cl.ce_pizzas_types_procedure',
        'bl_cl.ce_pizzas_sizes_procedure',
        'bl_cl.ce_pizzas_scd_procedure'
    ];
BEGIN
    v_status := 'Success';

    FOREACH v_procedure_name IN ARRAY v_procedures
    LOOP
        BEGIN
            EXECUTE format('CALL %s($1, $2, $3, $4, $5, $6)', v_procedure_name)
            INTO v_username, v_table_name, v_procedure_name, v_rows_updated, v_rows_inserted, v_procedure_starttime
            USING v_username, v_table_name, v_procedure_name, v_rows_updated, v_rows_inserted, v_procedure_starttime;

            RETURN QUERY SELECT v_username, v_table_name, v_procedure_name, v_rows_updated, v_rows_inserted, v_procedure_starttime, v_status;
        EXCEPTION
            WHEN OTHERS THEN
                v_status := 'Error: ' || SQLERRM;
                RETURN QUERY SELECT v_username, v_table_name, v_procedure_name, v_rows_updated, v_rows_inserted, v_procedure_starttime, v_status;
        END;
    END LOOP;
END;
$$ LANGUAGE plpgsql;



INSERT INTO bl_cl.procedure_log (
	username,
	table_name,
	procedure_name,
	rows_updated,
	rows_inserted,
	procesure_starttime,
	status
)
SELECT * FROM bl_cl.bl_3nf_procedures_to_log();

SELECT * FROM bl_cl.procedure_log;

--TRUNCATE bl_cl.procedure_log;

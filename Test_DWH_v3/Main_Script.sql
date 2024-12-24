SET ROLE developer_role;

CALL bl_cl.master_procedure();

SELECT * FROM bl_cl.procedure_log;


-- Count checks in 3NF and DIM facts
SELECT count(*) FROM bl_dm.fct_sales fs2 
UNION ALL
SELECT count(*) FROM bl_3nf.ce_sales cs ;


-- Order with no employee
--SELECT * FROM bl_dm.fct_sales fs2 
--LEFT JOIN bl_dm.dim_orders do2 ON fs2.order_surr_id = do2.order_surr_id 
--WHERE do2.order_name = 'ORD130026' AND do2.order_type = 'OFFLINE';

-- Previous load still wtitten as SARAH MILLER, not N.A.
--SELECT * FROM bl_dm.fct_sales fs2 
--LEFT JOIN bl_dm.dim_orders do2 ON fs2.order_surr_id = do2.order_surr_id 
--WHERE do2.order_name = 'ORD018186' AND do2.order_type = 'OFFLINE';

-- Order with no customer and no id of courier
--SELECT * FROM bl_dm.fct_sales fs2 
--LEFT JOIN bl_dm.dim_orders do2 ON fs2.order_surr_id = do2.order_surr_id 
--WHERE do2.order_name = 'ORD130362' AND do2.order_type = 'ONLINE';

-- Overwritten order data
--SELECT * FROM bl_dm.fct_sales fs2 
--LEFT JOIN bl_dm.dim_orders do2 ON fs2.order_surr_id = do2.order_surr_id 
--WHERE do2.order_name = 'ORD115121' AND do2.order_type = 'ONLINE';


-- Customers SCD2 change and history
SELECT * FROM  bl_dm.dim_customers_scd
WHERE customer_full_name LIKE '%GARY%';
--
SELECT * FROM bl_3nf.ce_customers_scd ccs 
WHERE customer_full_name LIKE '%GARY%';

-- Courier overwrited as JEFFREY KINGIE
SELECT * FROM bl_3nf.ce_couriers cc 
WHERE courier_src_id = 'CR0030';

-- Order with all nulls
SELECT * FROM bl_dm.fct_sales fs2 
LEFT JOIN bl_dm.dim_orders do2 ON fs2.order_surr_id = do2.order_surr_id 
WHERE do2.order_name = 'ORD999999';
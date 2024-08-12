SET ROLE developer_role;

CALL bl_cl.master_procedure();

SELECT * FROM bl_cl.procedure_log;
--
--SELECT * FROM bl_dm.fct_sales fs2 
--LEFT JOIN bl_dm.dim_orders do2 ON fs2.order_surr_id = do2.order_surr_id 
--WHERE do2.order_name = 'ORD999999';
--
--SELECT * FROM bl_dm.fct_sales fs2 
--LEFT JOIN bl_dm.dim_orders do2 ON fs2.order_surr_id = do2.order_surr_id 
--WHERE do2.order_name = 'ORD130026' AND do2.order_type = 'OFFLINE';
--
--SELECT * FROM bl_dm.fct_sales fs2 
--LEFT JOIN bl_dm.dim_orders do2 ON fs2.order_surr_id = do2.order_surr_id 
--WHERE do2.order_name = 'ORD018186' AND do2.order_type = 'OFFLINE';
--
--SELECT * FROM bl_dm.fct_sales fs2 
--LEFT JOIN bl_dm.dim_orders do2 ON fs2.order_surr_id = do2.order_surr_id 
--WHERE do2.order_name = 'ORD130362' AND do2.order_type = 'ONLINE';
--
--SELECT * FROM  bl_dm.dim_customers_scd
--WHERE customer_full_name LIKE '%GARY%';
--
--SELECT * FROM bl_3nf.ce_customers_scd ccs 
--WHERE customer_full_name LIKE '%GARY%';
--
--SELECT * FROM bl_3nf.ce_couriers cc 
--WHERE courier_src_id = 'CR0030'
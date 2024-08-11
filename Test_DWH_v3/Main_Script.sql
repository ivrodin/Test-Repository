SET ROLE developer_role;

CALL bl_cl.master_procedure();

SELECT * FROM bl_cl.procedure_log;

--
--SELECT * FROM bl_dm.dim_orders do2 
--WHERE order_name = 'ORD108666';
--
--SELECT * FROM bl_3nf.ce_orders co 
--WHERE order_src_id = 'ORD108666';

--SELECT * FROM bl_3nf.ce_sales cs 
--WHERE order_id = 410227;
--
--SELECT (
--co.order_id
--		) AS iip
--		FROM 
--			sa_online_sales.src_online_sales s
--		LEFT JOIN bl_3nf.ce_orders co ON upper(s.order_id) = co.order_src_id AND
--			co.source_system = 'SA_ONLINE_SALES' AND
--			co.source_entity = 'SRC_ONLINE_SALES'
--		WHERE (s.load_timestamp) > (SELECT max(last_src_dt) FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES');
	

--
--		SELECT
--			COALESCE (co.order_id, -1) AS order_id,
--			-1 AS employee_id,
--			COALESCE ((
--				SELECT delivery_id FROM bl_3nf.ce_deliveries cd
--				LEFT JOIN bl_3nf.ce_couriers cc ON cd.courier_id = cc.courier_id
--				WHERE COALESCE(upper(s.delivery_id), 'N.A.') = cd.delivery_src_id AND
--					COALESCE(upper(s.courier_id), 'N.A.') = cc.courier_src_id AND
--					cd.source_system = 'SA_ONLINE_SALES' AND
--					cd.source_entity = 'SRC_ONLINE_SALES'
--			), -1) AS delivery_id,
--			COALESCE ((
--				SELECT customer_id FROM bl_3nf.ce_customers_scd ccs
--				WHERE COALESCE(upper(s.customer_id), 'N.A.') = ccs.customer_src_id AND
--					ccs.source_system = 'SA_ONLINE_SALES' AND
--					ccs.source_entity = 'SRC_ONLINE_SALES' AND
--					ccs.is_active = 'Y'
--			), -1) AS customer_id,
--			COALESCE ((
--				SELECT address_id FROM bl_3nf.ce_addresses ca
--				LEFT JOIN bl_3nf.ce_districts cd ON ca.district_id = cd.district_id
--				WHERE upper(s.district) = cd.district_src_id AND
--					upper(s.address) = ca.address_src_id AND 
--					ca.source_system = 'SA_ONLINE_SALES' AND
--					ca.source_entity = 'SRC_ONLINE_SALES'
--					
--			), -1) AS address_id,
--			COALESCE ((
--				SELECT pizza_id FROM bl_3nf.ce_pizzas cp
--				LEFT JOIN bl_3nf.ce_pizzas_types cpt ON cp.pizza_type_id = cpt.pizza_type_id
--					AND cpt.source_system = 'BL_CL' AND cpt.source_entity = 'LKP_PIZZAS_TYPES'
--				LEFT JOIN bl_3nf.ce_pizzas_sizes cps ON cp.pizza_size_id = cps.pizza_size_id
--					AND cps.source_system = 'BL_CL' AND cps.source_entity = 'LKP_PIZZAS_SIZES'
--				WHERE COALESCE(upper(s.pizza_name), 'N.A.') = cp.pizza_name AND
--					COALESCE(upper(s.pizza_type), 'N.A.') = cpt.pizza_type_name AND
--					COALESCE(upper(s."size"), 'N.A.') = cps.pizza_size_name
--					AND cp.source_system = 'BL_CL' AND cp.source_entity = 'LKP_PIZZAS'
--			), -1) AS pizza_id,
--			COALESCE(s.quantity::int, 0) as quantity,
--			COALESCE(s.price::decimal(6,2), 0) as price,
--			current_timestamp AS insert_dt,
--			current_timestamp AS update_dt
--		FROM 
--			sa_online_sales.src_online_sales s
--		LEFT JOIN bl_3nf.ce_orders co ON COALESCE(upper(s.order_id), 'N.A.') = co.order_src_id AND
--			co.source_system = 'SA_ONLINE_SALES' AND
--			co.source_entity = 'SRC_ONLINE_SALES'
--		WHERE (s.load_timestamp) > (SELECT max(last_src_dt) FROM bl_cl.load_metadata lm WHERE src_tablename = 'SRC_ONLINE_SALES');
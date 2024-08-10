SET ROLE developer_role;

--RESET ROLE ;

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
	sa_restaurant_sales.ext_restaurant_sales_2 e
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

COMMIT;

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
	sa_online_sales.ext_online_sales_2 e
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

COMMIT;
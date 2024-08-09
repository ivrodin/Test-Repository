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
		s.customer_id = e.customer_id AND
		s.customer_full_name = e.customer_full_name AND
		s.order_id = e.order_id AND
		s."timestamp"= e."timestamp" AND
		s.pizza_type = e.pizza_type AND
		s.pizza_name = e.pizza_name AND
		s."size" = e."size" AND
		s.price = e.price AND
		s.employee_id = s.employee_id AND
		s.employee_full_name = s.employee_full_name AND
		s.in_or_out = e.in_or_out AND 
		s.quantity = e.quantity
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
		s.customer_id = e.customer_id AND
		s.customer_full_name = e.customer_full_name AND
		s.order_id = e.order_id AND
		s."timestamp" = e."timestamp" AND
		s.pizza_type = e.pizza_type AND
		s.pizza_name = e.pizza_name AND
		s."size" = e."size" AND
		s.price = e.price AND
		s.delivery_id = e.delivery_id AND
		s.delivery_name = e.delivery_name AND
		s.courier_id = s.courier_id AND
		s.courier_full_name = s.courier_full_name AND
		s.district = e.district AND
		s.address = e.address AND 
		s.quantity = e.quantity
);

COMMIT;
INSERT INTO sa_restaurant_sales.src_restaurant_sales (
	record_id, 
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
	in_or_out
)
SELECT 
	e.record_id, 
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
	e.in_or_out
FROM 
	sa_restaurant_sales.ext_restaurant_sales_2 e
WHERE NOT EXISTS (
	SELECT 
		1 
	FROM 
		sa_restaurant_sales.src_restaurant_sales s 
	WHERE 
		s.record_id = e.record_id AND
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
		s.in_or_out = e.in_or_out
);

COMMIT;

SELECT * FROM sa_restaurant_sales.src_restaurant_sales;

INSERT INTO sa_online_sales.src_online_sales (record_id, 
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
	address
)
SELECT 
	e.record_id, 
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
	address
FROM 
	sa_online_sales.ext_online_sales_2 e
WHERE NOT EXISTS (
	SELECT 
		1 
	FROM 
		sa_online_sales.src_online_sales s 
	WHERE 
		s.record_id = e.record_id AND
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
		s.address = e.address
);

COMMIT;

SELECT * FROM sa_online_sales.src_online_sales;
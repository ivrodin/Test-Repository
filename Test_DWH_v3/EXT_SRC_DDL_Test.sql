SET ROLE postgres;

--RESET ROLE ;

CREATE EXTENSION IF NOT EXISTS file_fdw;

CREATE SERVER IF NOT EXISTS csv_log FOREIGN DATA WRAPPER file_fdw;

CREATE SCHEMA IF NOT EXISTS sa_online_sales;

CREATE SCHEMA IF NOT EXISTS sa_restaurant_sales;

CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales_1 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	delivery_id varchar(255),
	delivery_name varchar(255),
	courier_id varchar(255),
	courier_full_name varchar(255),
	district varchar(255),
	address varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/online/pizzaplace_online_init_1.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales_2 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	delivery_id varchar(255),
	delivery_name varchar(255),
	courier_id varchar(255),
	courier_full_name varchar(255),
	district varchar(255),
	address varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/online/pizzaplace_online_init_2.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales_3 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	delivery_id varchar(255),
	delivery_name varchar(255),
	courier_id varchar(255),
	courier_full_name varchar(255),
	district varchar(255),
	address varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/online/pizzaplace_online_init_3.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales_4 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	delivery_id varchar(255),
	delivery_name varchar(255),
	courier_id varchar(255),
	courier_full_name varchar(255),
	district varchar(255),
	address varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/online/pizzaplace_online_init_4.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales_5 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	delivery_id varchar(255),
	delivery_name varchar(255),
	courier_id varchar(255),
	courier_full_name varchar(255),
	district varchar(255),
	address varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/online/pizzaplace_online_init_5.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales_6 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	delivery_id varchar(255),
	delivery_name varchar(255),
	courier_id varchar(255),
	courier_full_name varchar(255),
	district varchar(255),
	address varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/online/pizzaplace_online_init_6.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales_7 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	delivery_id varchar(255),
	delivery_name varchar(255),
	courier_id varchar(255),
	courier_full_name varchar(255),
	district varchar(255),
	address varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/online/pizzaplace_online_init_7.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales_8 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	delivery_id varchar(255),
	delivery_name varchar(255),
	courier_id varchar(255),
	courier_full_name varchar(255),
	district varchar(255),
	address varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/online/pizzaplace_online_init_8.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales_9 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	delivery_id varchar(255),
	delivery_name varchar(255),
	courier_id varchar(255),
	courier_full_name varchar(255),
	district varchar(255),
	address varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/demo_csvs/pizzaplace_online_incr.csv', FORMAT 'csv', HEADER 'true');


CREATE FOREIGN TABLE IF NOT EXISTS sa_restaurant_sales.ext_restaurant_sales_1 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	employee_id varchar(255),
	employee_full_name varchar(255),
	in_or_out varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/rest/pizzaplace_rest_init_1.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_restaurant_sales.ext_restaurant_sales_2 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	employee_id varchar(255),
	employee_full_name varchar(255),
	in_or_out varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/rest/pizzaplace_rest_init_2.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_restaurant_sales.ext_restaurant_sales_3 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	employee_id varchar(255),
	employee_full_name varchar(255),
	in_or_out varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/rest/pizzaplace_rest_init_3.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_restaurant_sales.ext_restaurant_sales_4 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	employee_id varchar(255),
	employee_full_name varchar(255),
	in_or_out varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/rest/pizzaplace_rest_init_4.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_restaurant_sales.ext_restaurant_sales_5 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	employee_id varchar(255),
	employee_full_name varchar(255),
	in_or_out varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/rest/pizzaplace_rest_init_5.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_restaurant_sales.ext_restaurant_sales_6 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	employee_id varchar(255),
	employee_full_name varchar(255),
	in_or_out varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/rest/pizzaplace_rest_init_6.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_restaurant_sales.ext_restaurant_sales_7 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	employee_id varchar(255),
	employee_full_name varchar(255),
	in_or_out varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/rest/pizzaplace_rest_init_7.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_restaurant_sales.ext_restaurant_sales_8 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	employee_id varchar(255),
	employee_full_name varchar(255),
	in_or_out varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/parts_csvs/rest/pizzaplace_rest_init_8.csv', FORMAT 'csv', HEADER 'true');

CREATE FOREIGN TABLE IF NOT EXISTS sa_restaurant_sales.ext_restaurant_sales_9 (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	employee_id varchar(255),
	employee_full_name varchar(255),
	in_or_out varchar(255),
	quantity varchar(255)
) SERVER csv_log
OPTIONS (filename 'csv_files/demo_csvs/pizzaplace_rest_incr.csv', FORMAT 'csv', HEADER 'true');

CREATE TABLE IF NOT EXISTS sa_restaurant_sales.src_restaurant_sales (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	employee_id varchar(255),
	employee_full_name varchar(255),
	in_or_out varchar(255),
	quantity varchar(255),
	load_timestamp timestamp
);

CREATE TABLE IF NOT EXISTS sa_online_sales.src_online_sales (
	customer_id varchar(255),
	customer_full_name varchar(255),
	order_id varchar(255),
	timestamp varchar(255),
	pizza_type varchar(255),
	pizza_name varchar(255),
	size varchar(255),
	price varchar(255),
	delivery_id varchar(255),
	delivery_name varchar(255),
	courier_id varchar(255),
	courier_full_name varchar(255),
	district varchar(255),
	address varchar(255),
	quantity varchar(255),
	load_timestamp timestamp
);
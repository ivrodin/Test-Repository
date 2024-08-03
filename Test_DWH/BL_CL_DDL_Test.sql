CREATE SCHEMA IF NOT EXISTS bl_cl;

CREATE SEQUENCE IF NOT EXISTS bl_cl.lkp_customers_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_cl.lkp_pizzas_types_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;

CREATE SEQUENCE IF NOT EXISTS bl_cl.lkp_pizzas_sizes_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;


CREATE TABLE IF NOT EXISTS bl_cl.lkp_customers(
	customer_id bigint,
	customer_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	customer_full_name varchar(20) NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT lkp_customers_pk UNIQUE (customer_src_id, source_system, source_entity)
);


CREATE TABLE IF NOT EXISTS bl_cl.lkp_pizzas_types(
	pizza_type_id bigint,
	pizza_type_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_type_name varchar(20) NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT lkp_pizzas_types_pk PRIMARY KEY (pizza_type_id, pizza_type_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_cl.lkp_pizzas_sizes(
	pizza_size_id bigint,
	pizza_size_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_size_name varchar(20) NOT NULL,
	insert_dt date NOT NULL,
	update_dt date NOT NULL,
	CONSTRAINT lkp_pizzas_sizes_pk PRIMARY KEY (pizza_size_id, pizza_size_src_id, source_system, source_entity)
);

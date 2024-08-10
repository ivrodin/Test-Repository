SET ROLE postgres;

--RESET ROLE ;

CREATE SCHEMA IF NOT EXISTS bl_cl;

CREATE SEQUENCE IF NOT EXISTS bl_cl.lkp_pizzas_id_seq
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

CREATE SEQUENCE IF NOT EXISTS bl_cl.load_meadata_id_seq
	START WITH 1
	INCREMENT BY 1
	CACHE 1;


CREATE TABLE IF NOT EXISTS bl_cl.lkp_pizzas(
	pizza_id bigint,
	pizza_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT lkp_pizza_unique UNIQUE (pizza_src_id, source_system, source_entity)
);


CREATE TABLE IF NOT EXISTS bl_cl.lkp_pizzas_types(
	pizza_type_id bigint,
	pizza_type_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_type_name varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT lkp_pizzas_types_unique UNIQUE (pizza_type_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_cl.lkp_pizzas_sizes(
	pizza_size_id bigint,
	pizza_size_src_id varchar(255) NOT NULL,
	source_system varchar(255) NOT NULL,
	source_entity varchar(255) NOT NULL,
	pizza_size_name varchar(255) NOT NULL,
	insert_dt timestamp NOT NULL,
	update_dt timestamp NOT NULL,
	CONSTRAINT lkp_pizzas_sizes_unique UNIQUE (pizza_size_src_id, source_system, source_entity)
);

CREATE TABLE IF NOT EXISTS bl_cl.procedure_log (
	username name,
	table_name varchar(255),
	procedure_name varchar(255),
	rows_updated int,
	rows_inserted int,
	procedure_timestamp varchar(50),
	status varchar(255)
);

CREATE TABLE IF NOT EXISTS bl_cl.load_metadata (
	load_id int PRIMARY KEY,
	src_tablename varchar (255),
	last_src_dt timestamp,
	load_dt timestamp
);

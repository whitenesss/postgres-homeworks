-- SQL-команды для создания таблиц
CREATE TABLE employees
(
	employee_id int PRIMARY KEY,
	first_name varchar(100) NOT NULL,
	last_name varchar(100) NOT NULL,
	title varchar(100) NOT NULL,
	birth_date date,
	notes text
);

CREATE TABLE customers
(
	customer_id varchar(100) PRIMARY KEY NOT NULL,
	company_name varchar(100) NOT NULL,
	contact_name varchar(100) NOT NULL
);


CREATE TABLE orders
(
	order_id int PRIMARY KEY NOT NULL,
	customer_id varchar(100) REFERENCES customers(customer_id) NOT NULL,
	employee_id int REFERENCES employees(employee_id) NOT NULL,
	order_date date NOT NULL,
	ship_city varchar(100) NOT NULL
);


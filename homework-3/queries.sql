-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT customers.company_name, employees.last_name, employees.first_name
FROM orders
JOIN customers
ON orders.customer_id = customers.customer_id
JOIN employees
ON orders.employee_id = employees.employee_id
WHERE order_id IN(SELECT order_id
					FROM orders
					JOIN shippers
					ON orders.ship_via=shippers.shipper_id
					WHERE company_name='United Package' )
AND	customers.city = 'London' AND  employees.city = 'London'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT products.product_name, products.units_in_stock,suppliers.contact_name,suppliers.phone
FROM products
JOIN suppliers
ON products.supplier_id = suppliers.supplier_id
WHERE discontinued = 0 AND units_in_stock <  25 AND category_id IN (SELECT category_id
																  from categories
																  where category_name='Dairy Products' or category_name='Condiments')
order by units_in_stock asc

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select company_name
from customers
where customer_id not in (select distinct customer_id
						 from  orders)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select distinct product_name
from products
where product_id in (select product_id
					from order_details
					where quantity = 10)

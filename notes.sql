-- ? Start a postgres server
-- ! docker run -d --name sql_cc -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres:18
-- ? Enter psql terminal
-- ! docker exec -it sql_cc psql -U postgres
-- ? Create a database
-- ! CREATE DATABASE chaicode_ecom_db;

-- ! DDL (Data Definition language)
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY, -- value cannot be NULL and it must be unique
    department_name VARCHAR(50) NOT NULL
); 

INSERT INTO departments (department_name) 
VALUES
('Sales'),
('Support'),
('Warehouse');

INSERT INTO departments (department_id, department_name) 
VALUES
(4,'Tech');

SELECT * FROM departments;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY, -- cannot be null it is unique
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    bio TEXT,
    job_title VARCHAR(50) NOT NULL,
    salary INT NOT NULL CHECK (salary > 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    hire_date DATE NOT NULL,
    last_login TIMESTAMP,
    employee_status VARCHAR(20) NOT NULL DEFAULT 'active'
                    CHECK (
                        employee_status IN ('active', 'on_leave', 'terminated')
                    ), -- active, on_leave, terminated
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    department_id INT REFERENCES departments(department_id),
    manager_id INT REFERENCES employees(employee_id)
);

INSERT INTO employees (first_name, last_name, email, department_id, job_title, salary, manager_id, hire_date) VALUES
    ('Priya',  'Nair',      'priya.nair@techbazaar.com',      1, 'Sales Representative', 62000.00, 1,    '2020-06-15'),
    ('Fake',   'Robert',    'robert.chen@techbazaar.com',     1, 'Rep',                  50000.00, 1,    '2024-01-01'),
    ('Marcus', 'Webb',      'marcus.webb@techbazaar.com',     1, 'Sales Representative', 58000.00, 1,    '2021-09-01'),
    ('Elena',  'Garcia',    'elena.garcia@techbazaar.com',    1, 'Senior Sales Rep',     68000.00, 1,    '2019-11-20'),
    ('James',  'Okafor',    'james.okafor@techbazaar.com',    2, 'Support Lead',         72000.00, NULL, '2018-05-10'),
    ('Lily',   'Zhang',     'lily.zhang@techbazaar.com',      2, 'Support Agent',        48000.00, 5,    '2022-02-14'),
    ('Diego',  'Fernandez', 'diego.fernandez@techbazaar.com', 2, 'Support Agent',        46000.00, 5,    '2023-01-09'),
    ('Sara',   'Osei',      'sara.osei@techbazaar.com',       5, 'Warehouse Lead',       55000.00, NULL, '2020-08-23');


SELECT * FROM employees;

SELECT * from departments;

 INSERT INTO employees (first_name, last_name, email, department_id, job_title, salary, hire_date)
VALUES (NULL, 'NoFirstName', 'nofirstname.demo@example.com', 1, 'Rep', 50000.00, '2024-01-01');

 INSERT INTO employees (first_name, last_name, email, department_id, job_title, salary, hire_date)
VALUES ('Fake', 'Robert', 'robert.chen@techbazaar.com', 1, 'Rep', 50000.00, '2024-01-01');

 INSERT INTO employees (first_name, last_name, email, department_id, job_title, salary, hire_date)
VALUES ('Unpaid', 'Intern', 'unpaid.demo@example.com', 1, 'Intern', 0, '2024-01-01');

 INSERT INTO employees (first_name, last_name, email, department_id, job_title, salary, hire_date, employee_status)
VALUES ('Bad', 'Status', 'badstatus.demo@example.com', 1, 'Rep', 50000.00, '2024-01-01', 'retired');




ALTER TABLE employees
ADD COLUMN internal_note VARCHAR(100) NOT NULL DEFAULT 'N/A';

SELECT * FROM employees;

ALTER TABLE employees
RENAME COLUMN internal_note TO hr_note;

ALTER TABLE employees
DROP COLUMN hr_note;

--! ======== DDL End ========
-- ! INSERT< UPDATE < DELETE are called as DML - Data Manipulation language

INSERT INTO customers
(
    first_name, 
    last_name,
    email,
    phone,
    city,
    country
)
VALUES 
(
   'John',
   'Doe',
   'john.doe@gmail.com',
   '9999999999',
   'Mumbai',
   'India'
);

SELECT * FROM categories;


INSERT INTO categories
(
    category_name,
    description
)
VALUES
('Dairy', 'Dairy products'),
('Gym', 'Gym products'),
('Cold drinks', 'cold drinks description');



SELECT * FROM products;

UPDATE products
SET stock_quantity = 50
WHERE product_id = 1;

UPDATE products
SET is_active = FALSE;

UPDATE products
SET price = price + 100;

UPDATE products
SET price = price + 200
WHERE product_id = 3;


SELECT * FROM orders;

-- order_item_id: 1, 2
SELECT * FROM order_items
WHERE order_id = 1;

DELETE FROM orders
WHERE order_id = 1;


SELECT customer_id, first_name, phone
FROM customers
WHERE phone is NULL;  

--! ======== DML End ========
-- ! DQL - Data Query Language

SELECT * FROM products;

SELECT 
    product_id, 
    product_name AS "Product Name", 
    stock_quantity
FROM products;

SELECT * FROM customers;

SELECT DISTINCT country FROM customers;


SELECT * 
FROM products
WHERE price > 200;

-- Give me products having stock qty > 0 and price < 150

SELECT * FROM products
WHERE stock_quantity > 0
    AND price > 150;

-- Give me products having 0 as stock qty or price < 150

SELECT * FROM products
WHERE stock_quantity = 0
    OR price < 150;

-- Give me products which are not active

SELECT * FROM products
WHERE NOT is_active;

-- Give me product having price > 120 and price < 200

SELECT * FROM products
WHERE price >= 120 AND price <= 200;

SELECT * FROM products
WHERE price BETWEEN 120 AND 200;


SELECT * FROM categories;

-- Give me product from Electronics as well as books
SELECT * FROM products
WHERE category_id = 1 
OR category_id = 3 
OR category_id = 4;

SELECT * FROM products
WHERE category_id IN (1, 3, 4, 5);


-- ! give me product having product name 
-- ! starting with "Wireless"
-- ! Wireless headphones
-- ! Wireless mouse

INSERT INTO products
(product_name, price, stock_quantity, category_id)
VALUES
('Wireless keyboard', 100, 20, 1),
('Wireless light', 200, 0, 1),
('Wireless headphones', 150, 0, 1);

SELECT * FROM products
WHERE product_name LIKE '%less%';

-- ! Give me customers who does not have phone numbers


SELECT * FROm customers;

SELECT * FROM customers
WHERE phone IS NOT NULL;


SELECT 
    first_name,
    last_name,
    COALESCE(phone, 'Phone number unavailable') AS phone_num,
    COALESCE(city, 'No city') AS city_name
FROM customers;


-- ! Give me products from cheapest to expensive order

SELECT * FROm products
ORDER BY price DESC; -- ASC: ascending, DESC: descending


-- ! Give me product from cheap to exp price for each category

SELECT * FROm products
ORDER BY category_id DESC, price ASC;


-- ! Give me top 10 most expensive products

SELECT * FROm products
ORDER by price DESC
LIMIT 10;


-- ! Pagination

SELECT * FROM products 
ORDER BY product_id
LIMIT 10
OFFSET 10;


FE: page: 0, 10, 20

p: 1: OFFSET: 0
p: 2: OFFSET: 10
p: 3: OFFSET: 10 + 10: 20 

offset = (page - 1) * limit


off = (3 - 1) * 10 = 20


-- ! Joins Start

-- ! Give me all orders including employee details of the employee who processed
-- ! that order 
-- ! only include orders punched by employees

SELECT * FROM orders;

SELECT o.status,
    o.order_id,
    e.email,
    e.first_name
FROM orders as o
    INNER JOIN employees as e ON o.employee_id = e.employee_id;


-- ! give me all orders and include employee details of employee who processed
-- ! that order and if it is directly coming from customer keep employee
-- ! details empty

SELECT o.status,
    o.order_id,
    e.email,
    e.first_name
FROM orders as o
    LEFT JOIN employees as e ON o.employee_id = e.employee_id;


SELECT o.status,
    o.order_id,
    e.email,
    e.first_name
FROM orders as o
    RIGHT JOIN employees as e ON o.employee_id = e.employee_id;


SELECT o.status,
    o.order_id,
    e.email,
    e.first_name
FROM orders as o
    FULL OUTER JOIN employees as e ON o.employee_id = e.employee_id;


SELECT * 
FROM departments
CROSS JOIN categories;

-- ! Joins examples

-- ! Give me all customers who did not place any order

SELECT 
    c.first_name,
    c.email,
    o.status,
    o.order_id
FROM customers as c
LEFT JOIN orders as o ON o.customer_id = c.customer_id
WHERE o.status IS NULL;

-- ! Give me orders which have not been paid

SELECT * 
FROM orders as o
LEFT JOIN payments as p ON p.order_id = o.order_id
WHERE p.payment_id IS NULL;


-- ! Give information about all orders thata are there in the DB
-- ! Include info about order_items, product, customer and 
-- ! category the product belongs to


SELECT 
    o.order_id,
    o.status,
    oi.product_id,
    oi.unit_price,
    p.product_name,
    p.price,
    c.category_name,
    cu.first_name,
    cu.last_name
FROM orders as o
LEFT JOIN order_items as oi ON oi.order_id = o.order_id
LEFT JOIN products as p ON p.product_id = oi.product_id
LEFT JOIN categories as c ON c.category_id = p.category_id
LEFT JOIN customers as cu ON cu.customer_id = o.customer_id;


-- ! Give me info about employees including their manager's info

SELECT 
    emp.first_name as "Employee First Name",
    emp.last_name as "Employee Last Name",
    manager_tbl.first_name as "Manager First Name",
    manager_tbl.last_name as "Manager Last Name"
FROm employees as emp
LEFT JOIN employees as manager_tbl ON emp.manager_id = manager_tbl.employee_id;


-- ! Aggregation start
-- ! Give me total count customers on our platform

SELECT * FROM customers;

SELECT 
    COUNT(*) AS cust_count,
    COUNT(phone) AS cust_with_phone_number
FROM customers;

SELECT COUNT(DISTINCT country) from customers;

-- ! Give me total revenue across all orders till now


SELECT 
    order_item_id,
    quantity,
    unit_price,
    quantity * unit_price as total_selling_val
 FROM order_items;

SELECT SUM(quantity * unit_price) as total_revenue FROM order_items;

-- ! give average price of product across all products

SELECT * FROM products;

SELECT 
    ROUND(AVG(price), 2) as avg_price
 FROM products;


 -- ! Give me min price and max price across all products

 SELECT price FROM products ORDER BY price ASC LIMIT 1;

 SELECT MIN(price) as minimum_price, MAX(price) as max_price
 FROM products;

 SELECT 
    COUNT(*) as total_product,
    ROUND(AVG(price), 2) as average_price,
    MIN(price) as min_price,
    MAX(price) as max_price,
    SUM(stock_quantity) as total_stock
 FROM products;

SELECT * FROM products;
SELECT * FROM categories;
-- SELECT * FROM employees;


SELECT COUNT(*) as product_count FROM products;

-- ! Give me total number of products in each category

SELECT category_id, COUNT(*) 
FROM products
GROUP BY category_id;

-- ! Give me total number of active and inactive
-- ! products in each category

SELECT category_id, is_active, COUNT(*) 
FROM products
GROUP BY category_id, is_active;


-- ! Give me total number of products in each category
-- ! include category name in the results

SELECT 
    p.category_id, 
    c.category_name,
    COUNT(*) 
FROM products as p
LEFT JOIN categories as c on c.category_id = p.category_id
GROUP BY p.category_id, c.category_name;


-- ! Give me total number of products in each category

-- ! and give me categories having > 5 products

SELECT category_id, COUNT(*) 
FROM products
GROUP BY category_id
HAVING COUNT(*) > 5;


-- ! Find departments having more than one managed employee,
-- ! where their combined salary of whole department exceeds 200000 rupees.


SELECT 
    department_id,
    COUNT(*),
    SUM(salary) as total_dep_salary
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY department_id
HAVING COUNT(*) > 1;

-- ! ========= Aggregation End ========
--! Subquery start
-- ! Give me all the customer having at least one cancelled order
SELECT *
FROM customers;
SELECT *
FROM orders;
SELECT *
FROM customers
WHERE customer_id IN (
        SELECT customer_id
        FROM orders
        WHERE status = 'cancelled'
    );
-- ! Give me all the products which are having 
-- ! price > average price across all products
-- ! p1 - 100, p2 - 200, p3 = 1000, p4 - 200, p5- 900
-- ! 1500/4 - average -> 375
-- ! p3, p5 -> returned
SELECT *
FROM products
WHERE price > (
        SELECT AVG(price)
        from products
);

-- ! give me sales on category level
--! electronics - 3000
-- ! clothing - 4000
-- ! give me categories having sales > 500
-- ! return category name in the result

SELECT * FROM orders;
SELECT * FROM order_items;

-- ! derived table
SELECT c.category_name,
    category_stats.category_sales
FROM (
        SELECT p.category_id as stat_id,
            SUM(oi.quantity * oi.unit_price) as category_sales
        FROM order_items as oi
            LEFT JOIN products as p ON p.product_id = oi.product_id
        GROUP BY p.category_id
    ) as category_stats
    LEFT JOIN categories as c ON c.category_id = category_stats.stat_id
WHERE category_sales > 500;

-- ! ================= Subquery ends ===================


-- ! CTE Starts
-- ! CTE - Common Table Expressions

SELECT 
    c.category_name,
    category_stats.category_sales
FROM (
    SELECT 
        p.category_id as stat_id,
        SUM(oi.quantity * oi.unit_price) as category_sales
    FROM order_items as oi
    LEFT JOIN products as p ON p.product_id = oi.product_id
    GROUP BY p.category_id
) as category_stats
LEFT JOIN categories as c ON c.category_id = category_stats.stat_id;


WITH category_stats AS (
    SELECT 
        p.category_id,
        SUM(oi.quantity * oi.unit_price) as category_sales
    FROM order_items as oi
    LEFT JOIN products as p ON p.product_id = oi.product_id
    GROUP BY p.category_id
)
SELECT 
    c.category_name,
    category_stats.category_sales
FROM category_stats
LEFT JOIN categories as c ON c.category_id = category_stats.category_id;

-- WITH var_name AS (
--     ...SQL query
-- )



WITH category_stats AS (
    SELECT 
        p.category_id,
        SUM(oi.quantity * oi.unit_price) as category_sales
    FROM order_items as oi
    LEFT JOIN products as p ON p.product_id = oi.product_id
    GROUP BY p.category_id
),
hsc AS (
    SELECT * FROM category_stats
    ORDER BY category_sales DESC
    LIMIT 1
)
SELECT 
    c.category_name,
    hsc.category_sales
FROM hsc
LEFT JOIN categories as c ON c.category_id = hsc.category_id;


-- ! Reusability

-- ! Give me total spend of a customer
-- ! Also give me average spend of all customer
-- ! Also give me flag TRUE or FALSE basis of if the customer 
-- ! have above average spending


WITH customer_total AS (
    SELECT 
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS customer_spend
    FROm orders as o
    LEFT JOIN order_items as oi ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY o.customer_id
)
SELECT 
    ct.customer_id,
    ct.customer_spend,
    ROUND((SELECT AVG(customer_spend) FROM customer_total), 2) as avg_spend,
    ct.customer_spend > (SELECT AVG(customer_spend) FROM customer_total) as is_above_avg
FROM customer_total as ct;


-- ! equivalent subquery for the above query

SELECT 
    ct.customer_id,
    ct.customer_spend,
    ROUND(
        (SELECT AVG(customer_spend)
         FROM (
             SELECT 
                 o.customer_id,
                 SUM(oi.quantity * oi.unit_price) AS customer_spend
             FROM orders AS o
             LEFT JOIN order_items AS oi 
                 ON oi.order_id = o.order_id
             WHERE o.status = 'completed'
             GROUP BY o.customer_id
         ) AS customer_total
        ), 
        2
    ) AS avg_spend,
    ct.customer_spend > (
        SELECT AVG(customer_spend)
        FROM (
            SELECT 
                o.customer_id,
                SUM(oi.quantity * oi.unit_price) AS customer_spend
            FROM orders AS o
            LEFT JOIN order_items AS oi 
                ON oi.order_id = o.order_id
            WHERE o.status = 'completed'
            GROUP BY o.customer_id
        ) AS customer_total
    ) AS is_above_avg
FROM (
    SELECT 
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS customer_spend
    FROM orders AS o
    LEFT JOIN order_items AS oi 
        ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY o.customer_id
) AS ct;


-- ! ============= CTE Ends =================
-- ! Window Functions Start
-- ! Give me total product's price sum on category level
SELECT 
    category_id,
    SUM(price) as product_sum
FROM products
GROUP BY category_id;

-- ! Window func
SELECT
    *,
    SUM(price) OVER (PARTITION BY category_id) as category_total_price
FROM products;

-- ! Without affectng or reducing the table structure
-- ! give me average price across all the products

SELECT 
    *,
    AVG(price) OVER () as avg_price
FROM products;

-- ! Give rank to a product based on how pricy it is

SELECT 
    product_name,
    price,
    ROW_NUMBER() OVER (ORDER BY price DESC) as prod_row_num,
    RANK() OVER (ORDER BY price DESC) as prod_rank,
    DENSE_RANK() OVER (ORDER BY price DESC) as prod_dense_rank
FROM products;

-- ! ============ Window Functions End =================
-- ! UNION and UNION ALL
--  ! Give me list of users/humans that are there inside the community

SELECT first_name,last_name,  'employee' as role FROM employees
UNION
SELECT first_name, last_name, 'customer' as role FROM customers;
-- ! ========== UNION and UNION ALL end ============
-- ! Create an index
CREATE INDEX idx_customer_email ON customers(email);
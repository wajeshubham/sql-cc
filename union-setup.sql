-- ! Run this query only for UNION and UNION ALL examples
INSERT INTO employees
    (first_name, last_name, email, phone, job_title, salary, hire_date)
VALUES
    ('Alice', 'Johnson', 'alice.johnson@email.com', '212-555-0101',
     'Sales Manager', 75000, '2024-01-10'),

    ('Brian', 'Kim', 'brian.kim@email.com', NULL,
     'Software Engineer', 85000, '2024-02-15'),

    ('Carla', 'Mendes', 'carla.mendes@email.com', '305-555-0103',
     'Marketing Specialist', 65000, '2024-03-20'),

    ('David', 'Okoro', 'david.okoro@email.com', '312-555-0104',
     'HR Executive', 70000, '2024-04-05'),

    ('Emma', 'Wilson', 'emma.wilson@email.com', NULL,
     'Product Manager', 90000, '2024-05-12');

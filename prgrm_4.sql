======Insert=======


-> select * from regions;
+-----------+-------------+
| region_id | region_name |
+-----------+-------------+
|         1 | Asia        |
|         2 | Europe      |
|         3 | America     |
+-----------+-------------+
3 rows in set (0.00 sec)

-> select * from countries;
+------------+---------------+-----------+
| country_id | country_name  | region_id |
+------------+---------------+-----------+
| DE         | Germany       |         1 |
| IN         | India         |         3 |
| US         | United States |         2 |
+------------+---------------+-----------+
3 rows in set (0.05 sec)

-> select * from locations;
+-------------+----------------+-------------+-----------+----------------+------------+
| location_id | street_address | postal_code | city      | state_province | country_id |
+-------------+----------------+-------------+-----------+----------------+------------+
|        1700 | myRoad         | 56000       | Bangalore | Karnataka      | IN         |
|        1800 | oxford         | w1          | London    | London         | US         |
+-------------+----------------+-------------+-----------+----------------+------------+
2 rows in set (0.04 sec)

->  select * from departments;
+---------+-----------+-------------+
| dept_id | dept_name | location_id |
+---------+-----------+-------------+
|       1 | IT        |        1700 |
|       2 | HR        |        1700 |
|       3 | finance   |        1800 |
|       4 | marketing |        1800 |
+---------+-----------+-------------+
4 rows in set (0.01 sec)

->  select * from jobs;
+---------+--------------+------------+------------+
| job_id  | job_title    | min_salary | max_salary |
+---------+--------------+------------+------------+
| FIN_ACC | Accountant   |    6000.00 |   18000.00 |
| HR_REP  | HR Represent |    4000.00 |   15000.00 |
| IT_PRO6 | Programmer   |    5000.00 |   20000.00 |
| MKT_MAN | Marketing    |    8000.00 |   25000.00 |
+---------+--------------+------------+------------+
4 rows in set (0.00 sec)

->  select * from employees;
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+
| employee_id | first_name | last_name | email           | phone_no | hire_date  | job_id  | salary   | manager_id | dept_id |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+
|         101 | Rahul      | Sharma    | rahul@gmail.com | 999991   | 2022-01-10 | IT_PRO6 | 15000.00 |       NULL |       1 |
|         102 | Aisha      | Khan      | aisha@email.com | 999992   | 2021-01-12 | HR_REP  |  9000.00 |        101 |       2 |
|         103 | John       | Smith     | john@gmail.com  | 999993   | 2020-03-15 | FIN_ACC | 12000.00 |        101 |       3 |
|         104 | Priya      | Nair      | priya@gmail.com | 999994   | 2024-04-18 | IT_PRO6 |  7000.00 |        101 |       1 |
|         105 | David      | Brown     | david@gmail.com | 999995   | 2022-05-20 | MKT_MAN | 22000.00 |        103 |       4 |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+
5 rows in set (0.01 sec)

->  select * from dependents;
+--------------+------------+-----------+--------------+-------------+
| dependent_id | first_name | last_name | relationship | employee_id |
+--------------+------------+-----------+--------------+-------------+
|            1 | Anu        | Sharma    | Daughter     |         101 |
|            2 | Sara       | Khan      | wife         |         102 |
+--------------+------------+-----------+--------------+-------------+
2 rows in set (0.04 sec)




=========Questions=========


#1
select first_name,last_name from employees join departments using(dept_id)where location_id=1700;
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Rahul      | Sharma    |
| Priya      | Nair      |
| Aisha      | Khan      |
+------------+-----------+
3 rows in set (0.00 sec)

#2
select first_name,last_name from employees join departments using(dept_id)where location_id<>1700;
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| John       | Smith     |
| David      | Brown     |
+------------+-----------+
2 rows in set (0.00 sec)

#3
select * from employees where salary=(select MAX(salary)from employees);
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
| employee_id | first_name | last_name | email           | phone_no | hire_date  | job_id  | salary   | manager_id | dept_id | commission_pct |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
|         105 | David      | Brown     | david@gmail.com | 999995   | 2022-05-20 | MKT_MAN | 22000.00 |        103 |       4 |           0.10 |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
1 row in set (0.05 sec)

#4
select * from employees where salary>(select AVG(salary)from employees);
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
| employee_id | first_name | last_name | email           | phone_no | hire_date  | job_id  | salary   | manager_id | dept_id | commission_pct |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
|         101 | Rahul      | Sharma    | rahul@gmail.com | 999991   | 2022-01-10 | IT_PRO6 | 15000.00 |       NULL |       1 |           NULL |
|         105 | David      | Brown     | david@gmail.com | 999995   | 2022-05-20 | MKT_MAN | 22000.00 |        103 |       4 |           0.10 |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
2 rows in set (0.00 sec)

#5
select distinct dept_id,dept_name from departments join employees using(dept_id)where salary>1000;
+---------+-----------+
| dept_id | dept_name |
+---------+-----------+
|       1 | IT        |
|       2 | HR        |
|       3 | finance   |
|       4 | marketing |
+---------+-----------+
4 rows in set (0.00 sec)

#6
select dept_id,dept_name from departments where dept_id not in(select dept_id from employees where salary>1000);
Empty set (0.00 sec)

#7
select * from employees where salary > all(select MIN(salary) from employees group by dept_id);
Empty set (0.00 sec)

#8
select * from employees where salary >= all(select MAX(salary) from employees group by dept_id);
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
| employee_id | first_name | last_name | email           | phone_no | hire_date  | job_id  | salary   | manager_id | dept_id | commission_pct |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
|         105 | David      | Brown     | david@gmail.com | 999995   | 2022-05-20 | MKT_MAN | 22000.00 |        103 |       4 |           0.10 |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
1 row in set (0.00 sec)

#9
select AVG(avg_salary) from (select AVG(salary) as avg_salary from employees group by dept_id)as dept_avg;
+------------------+
| AVG(avg_salary)  |
+------------------+
| 13500.0000000000 |
+------------------+
1 row in set (0.00 sec)

#10
select first_name,salary,(select AVG(salary) from employees) as avg_salary,salary-(select AVG(salary) from employees)as difference from employees;
+------------+----------+--------------+--------------+
| first_name | salary   | avg_salary   | difference   |
+------------+----------+--------------+--------------+
| Rahul      | 15000.00 | 13000.000000 |  2000.000000 |
| Aisha      |  9000.00 | 13000.000000 | -4000.000000 |
| John       | 12000.00 | 13000.000000 | -1000.000000 |
| Priya      |  7000.00 | 13000.000000 | -6000.000000 |
| David      | 22000.00 | 13000.000000 |  9000.000000 |
+------------+----------+--------------+--------------+
5 rows in set (0.00 sec)

#11
select * from employees e where salary >(select AVG(salary)from employees where dept_id=e.dept_id);
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
| employee_id | first_name | last_name | email           | phone_no | hire_date  | job_id  | salary   | manager_id | dept_id | commission_pct |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
|         101 | Rahul      | Sharma    | rahul@gmail.com | 999991   | 2022-01-10 | IT_PRO6 | 15000.00 |       NULL |       1 |           NULL |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
1 row in set (0.00 sec)

#12
select *from employees where not exists(select *from dependents where dependents.employee_id=employees.employee_id);
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
| employee_id | first_name | last_name | email           | phone_no   | hire_date  | job_id  | salary   | manager_id | dept_id | commission_pct |
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
|         103 | John       | Smith     | john@gmail.com  | 7907561753 | 2020-03-15 | FIN_ACC | 12000.00 |        101 |       3 |           0.05 |
|         104 | Priya      | Nair      | priya@gmail.com | 999994     | 2024-04-18 | IT_PRO6 |  7000.00 |        101 |       1 |           NULL |
|         105 | David      | Brown     | david@gmail.com | 999995     | 2022-05-20 | MKT_MAN | 22000.00 |        103 |       4 |           0.10 |
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
3 rows in set (0.00 sec)

#13
select e.first_name,e.last_name,d.dept_name from employees e join departments d on e.dept_id=d.dept_id where e.dept_id in(1,2,3);
+------------+-----------+-----------+
| first_name | last_name | dept_name |
+------------+-----------+-----------+
| Rahul      | Sharma    | IT        |
| Priya      | Nair      | IT        |
| Aisha      | Khan      | HR        |
| John       | Smith     | finance   |
+------------+-----------+-----------+
4 rows in set (0.00 sec)

#14
select e.first_name,e.last_name,j.job_title,d.dept_name from employees e join jobs j on e.job_id=j.job_id join departments d on e.dept_id=d.dept_id where e.dept_id in(1,2,3) and e.salary>10000;
+------------+-----------+------------+-----------+
| first_name | last_name | job_title  | dept_name |
+------------+-----------+------------+-----------+
| John       | Smith     | Accountant | finance   |
| Rahul      | Sharma    | Programmer | IT        |
+------------+-----------+------------+-----------+
2 rows in set (0.00 sec)

#15
SELECT  d.dept_name, l.street_address,l.postal_code, c.country_name, r.region_name FROM departments d JOIN locations l  ON d.location_id = l.location_id JOIN countries c  ON l.country_id = c.country_id JOIN regions r  ON c.region_id = r.region_id;
+-----------+----------------+-------------+---------------+-------------+
| dept_name | street_address | postal_code | country_name  | region_name |
+-----------+----------------+-------------+---------------+-------------+
| IT        | myRoad         | 56000       | India         | America     |
| HR        | myRoad         | 56000       | India         | America     |
| finance   | oxford         | w1          | United States | Europe      |
| marketing | oxford         | w1          | United States | Europe      |
+-----------+----------------+-------------+---------------+-------------+
4 rows in set (0.00 sec)

#16
select e.first_name,e.last_name,e.dept_id,d.dept_name from employees e left join departments d on e.dept_id=d.dept_id;
+------------+-----------+---------+-----------+
| first_name | last_name | dept_id | dept_name |
+------------+-----------+---------+-----------+
| Rahul      | Sharma    |       1 | IT        |
| Aisha      | Khan      |       2 | HR        |
| John       | Smith     |       3 | finance   |
| Priya      | Nair      |       1 | IT        |
| David      | Brown     |       4 | marketing |
+------------+-----------+---------+-----------+
5 rows in set (0.00 sec)

#17
select e.first_name,e.last_name,e.dept_id,d.dept_name,l.city,l.state_province from employees e  join departments d on e.dept_id=d.dept_id join locations l on d.location_id=l.location_id where e.first_name like '%z';
Empty set (0.00 sec)

#18
select e.first_name,e.last_name,d.dept_id,d.dept_name from departments d left join employees e  on d.dept_id=e.dept_id;
+------------+-----------+---------+-----------+
| first_name | last_name | dept_id | dept_name |
+------------+-----------+---------+-----------+
| Rahul      | Sharma    |       1 | IT        |
| Priya      | Nair      |       1 | IT        |
| Aisha      | Khan      |       2 | HR        |
| John       | Smith     |       3 | finance   |
| David      | Brown     |       4 | marketing |
+------------+-----------+---------+-----------+
5 rows in set (0.00 sec)

#19
select e.first_name as employee_name,m.first_name as manager_name from employees e left join employees m on e.manager_id=m.employee_id;
+---------------+--------------+
| employee_name | manager_name |
+---------------+--------------+
| Rahul         | NULL         |
| Aisha         | Rahul        |
| John          | Rahul        |
| Priya         | Rahul        |
| David         | John         |
+---------------+--------------+
5 rows in set (0.00 sec)

#20
select first_name,last_name,dept_id from employees where dept_id=(select dept_id from employees where last_name='Taylor');
Empty set (0.00 sec)

#21
select j.job_title,e.first_name,(j.max_salary-e.salary)as salary_difference from employees e join jobs j on e.job_id=j.job_id;
+--------------+------------+-------------------+
| job_title    | first_name | salary_difference |
+--------------+------------+-------------------+
| Accountant   | John       |           6000.00 |
| HR Represent | Aisha      |           6000.00 |
| Programmer   | Rahul      |           5000.00 |
| Programmer   | Priya      |          13000.00 |
| Marketing    | David      |           3000.00 |
+--------------+------------+-------------------+
5 rows in set (0.00 sec)

#22
select d.dept_name,avg(e.salary)as avg_salary,count(e.commission_pct)as commission_count from departments d left join employees e on d.dept_id=e.dept_i
d group by d.dept_name;
+-----------+--------------+------------------+
| dept_name | avg_salary   | commission_count |
+-----------+--------------+------------------+
| IT        | 11000.000000 |                0 |
| HR        |  9000.000000 |                0 |
| finance   | 12000.000000 |                1 |
| marketing | 22000.000000 |                1 |
+-----------+--------------+------------------+
4 rows in set (0.05 sec)

#23
create view Bangalore_emp as select e.employee_id,e.first_name,e.phone_no,j.job_title,d.dept_name,m.first_name as manager_name from employees e join jobs j on e.job_id=j.job_id join departments d on e.dept_id=d.dept_id join locations l on d.location_id=l.location_id left join employees m on e.manager_id=m.employee_id where l.city='Bangalore';
Query OK, 0 rows affected (0.05 sec)

#24
select first_name from Bangalore_emp where job_title='manager' and dept_name='finance';
Empty set (0.00 sec)

#25
update employees set phone_no='7907561753' where last_name='Smith';
Query OK, 1 row affected (0.01 sec)
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
| employee_id | first_name | last_name | email           | phone_no   | hire_date  | job_id  | salary   | manager_id | dept_id | commission_pct |
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
|         101 | Rahul      | Sharma    | rahul@gmail.com | 999991     | 2022-01-10 | IT_PRO6 | 15000.00 |       NULL |       1 |           NULL |
|         102 | Aisha      | Khan      | aisha@email.com | 999992     | 2021-01-12 | HR_REP  |  9000.00 |        101 |       2 |           NULL |
|         103 | John       | Smith     | john@gmail.com  | 7907561753 | 2020-03-15 | FIN_ACC | 12000.00 |        101 |       3 |           0.05 |
|         104 | Priya      | Nair      | priya@gmail.com | 999994     | 2024-04-18 | IT_PRO6 |  7000.00 |        101 |       1 |           NULL |
|         105 | David      | Brown     | david@gmail.com | 999995     | 2022-05-20 | MKT_MAN | 22000.00 |        103 |       4 |           0.10 |
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
5 rows in set (0.00 sec)

#26
select * from employees e where not exists (select * from dependents d where d.employee_id=e.employee_id);
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
| employee_id | first_name | last_name | email           | phone_no   | hire_date  | job_id  | salary   | manager_id | dept_id | commission_pct |
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
|         103 | John       | Smith     | john@gmail.com  | 7907561753 | 2020-03-15 | FIN_ACC | 12000.00 |        101 |       3 |           0.05 |
|         104 | Priya      | Nair      | priya@gmail.com | 999994     | 2024-04-18 | IT_PRO6 |  7000.00 |        101 |       1 |           NULL |
|         105 | David      | Brown     | david@gmail.com | 999995     | 2022-05-20 | MKT_MAN | 22000.00 |        103 |       4 |           0.10 |
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
3 rows in set (0.00 sec)

#27
select * from employees where manager_id=101 union select * from employees where manager_id=201;
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
| employee_id | first_name | last_name | email           | phone_no   | hire_date  | job_id  | salary   | manager_id | dept_id | commission_pct |
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
|         102 | Aisha      | Khan      | aisha@email.com | 999992     | 2021-01-12 | HR_REP  |  9000.00 |        101 |       2 |           NULL |
|         103 | John       | Smith     | john@gmail.com  | 7907561753 | 2020-03-15 | FIN_ACC | 12000.00 |        101 |       3 |           0.05 |
|         104 | Priya      | Nair      | priya@gmail.com | 999994     | 2024-04-18 | IT_PRO6 |  7000.00 |        101 |       1 |           NULL |
+-------------+------------+-----------+-----------------+------------+------------+---------+----------+------------+---------+----------------+
3 rows in set (0.00 sec)

#28
select * from employees e where exists (select * from dependents d where d.employee_id=e.employee_id);
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
| employee_id | first_name | last_name | email           | phone_no | hire_date  | job_id  | salary   | manager_id | dept_id | commission_pct |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
|         101 | Rahul      | Sharma    | rahul@gmail.com | 999991   | 2022-01-10 | IT_PRO6 | 15000.00 |       NULL |       1 |           NULL |
|         102 | Aisha      | Khan      | aisha@email.com | 999992   | 2021-01-12 | HR_REP  |  9000.00 |        101 |       2 |           NULL |
+-------------+------------+-----------+-----------------+----------+------------+---------+----------+------------+---------+----------------+
2 rows in set (0.00 sec)

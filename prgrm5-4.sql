create table employee(emp_id int primary key,emp_name varchar(50),department varchar(50));

insert into employee values(1,'Ravi','IT'),(2,'Ravi','HR'),(3,'Anita','Finance');

===Procedure===
DELIMITER //
create function emp_count(e_name varchar(50))
returns int
deterministic
begin
declare total int;
select count(*) into total from employee where emp_name=e_name;
return total;
END //
DELIMITER ;

===OUTPUT===

select emp_count('Ravi');
+-------------------+
| emp_count('Ravi') |
+-------------------+
|                 2 |
+-------------------+

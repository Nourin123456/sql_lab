 create table bill(customer_id int primary key,
    -> name varchar(50),pre_reading int,cur_reading int,unit int,amount decimal(10,2));

insert into bill values(1,'Arun',100,180,NULL,NULL),(2,'Rahul',200,300,NULL,NULL),(3,'Meera',150,240,NULL,NULL),(4,'Anu',300,450,NULL,NULL);

==CALL==
call calculate_bill();

===PROCEDURE===
DELIMITER $$
create procedure calculate_bill()
begin
update bill set unit=cur_reading-pre_reading;
if true then
update bill set amount=unit*2 where unit<=100;
update bill set amount=(100*2)+(unit-100)*2.5 where unit>100 and unit<=200;
update bill set amount=(100*2)+(100*2.5)+(unit-200)*3
where unit>200 and unit<=300;
update bill set amount=(100*2)+(100*2.5)+(100*3)+(unit-300)*4
where unit>300;
end if;
END $$
DELIMITER ;


===OUTPUT===
select * from bill;
+-------------+-------+-------------+-------------+------+--------+
| customer_id | name  | pre_reading | cur_reading | unit | amount |
+-------------+-------+-------------+-------------+------+--------+
|           1 | Arun  |         100 |         180 |   80 | 160.00 |
|           2 | Rahul |         200 |         300 |  100 | 200.00 |
|           3 | Meera |         150 |         240 |   90 | 180.00 |
|           4 | Anu   |         300 |         450 |  150 | 325.00 |
+-------------+-------+-------------+-------------+------+--------+

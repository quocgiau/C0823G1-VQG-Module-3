create database module3;
use module3;

create table student (
id int primary key,
name varchar(50),
score float
);

insert into student (id, name, score)
values (3, 'Nguyễn Văn C', 8.2);

alter table student add description varchar(100);

select * from student;


update 
  student 
set 
  name = 'Nguyễn Ngọc Quang', 
  score = 9.8 
where 
  id = 1;
  

set sql_safe_updates = 0;
update 
  student 
set 
  description = 'Người anh từng thương'
where 
  id = 3;
set sql_safe_updates = 1;

delete from student where id = 3;

use module3;

select * from student;


select customer_id id, customer_type_id, customer_name as name,
customer_birthday as date_of_birth, customer_gender as gender
, customer_id_card as id_card,
customer_phone as phone_number
, customer_email email
, customer_address address from customer;


select customer_type_id id, customer_type_name name from customer_type;

-- =================================
create database module3;
drop schema module3;




create database if not exists demo_ss1;
use demo_ss1;

create table class (
	class_id int primary key auto_increment,
    class_name varchar(50)
);
-- ctrl + R
create table student(
	student_id int primary key auto_increment,
    student_name varchar(50),
    student_birthday date,
    student_gender bit,
    class_id int,
    foreign key(class_id) references class(class_id)
);

drop table student;

SELECT 
    *
FROM
    student;

insert into student( student_name, student_birthday, student_gender)
values ('Văn Độ','2000-10-11',1),
		('Văn Độ','2000-10-11',1),
		('Tùng Lâm','2000-10-12',1),
        ('Thái Bảo','2000-10-13',1);
        
delete from student
where student_id = 1;
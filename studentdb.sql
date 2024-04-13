show databases;
use sisd;
show tables;
desc enrollment;
insert into students (s_id, f_name,l_name,dob,emai,phone_number) values (1,'Ajit','Doval','1980-01-16','ajit@gmail', 987532765),
																	(2,'Vikram','Batra','1986-02-05','vikram@gmail',87543287),
                                                                    (3,'Bibin','Rawat','1978-06-14','bibin@gmail',9843217),
                                                                    (4,'Jadunath','Singh','1965-12-08','jadunath@gmail',546732);
  select *
  from course;
  
  insert into teacher(f_name,l_name,email) values( 'Jaya','Rohatki','jaya@gmail'),
                                                  ('Jayanti','Bakshi','jayanti@gmail'),
                                                  ('kk','Patel','kk@gmail'),
                                                  ('Payal','Mishra','payal@gmail');
                                                  
insert into course(name,credit,teacher_id) values( 'Java Programming',90,2),
                                                  ('Python Programming',80,1),
                                                  ('HTML',70,3),
                                                  ('CSS',80,4),
                                                  ('C++',90,2);
                                                  DELETE FROM course
                                                   WHERE id in(7,8,9,10,11,12,13,14,16,17,15);
set foreign_key_checks=0;
insert into enrollment(id,e_date,students_s_id,course_id) values(1,'2024-03-09',1,1),
																(2,'2024-03-10',2,5),
                                                                 (3,'2024-03-08',4,4),
                                                                 (4,'2024-03-07',3,2),
                                                                  (5,'2024-03-06',2,3);
                                                            
 select *
 from payment;
delete from students
 where s_id in(5,6,7,8,9);
 
 describe payment;
 show tables;
 
 insert into payment(amount,students_s_id) values(8000,3),
												 (5000,1),
                                                 (7000,2),
                                                 (5000,4);
                                                 
-- task 02

-- 01 add new student in the students table

insert into students (f_name,l_name,dob,emai,phone_number) values('John','Doe','1995-08-15','doe@example.com',1234567890);
select *
from students;

-- output
/*
1	Ajit	Doval	1980-01-16	     ajit@gmail	         987532765
2	Vikram	Batra	1986-02-05	     vikram@gmail	     87543287
3	Bibin	Rawat	1978-06-14	     bibin@gmail	     9843217
4   Jadunath Singh	1965-12-08	    jadunath@gmail	     546732
5	John	Doe	1995-08-15	        doe@example.com 	1234567890
*/

-- 02 enroll student into corse

insert into enrollment(id,e_date,students_s_id,course_id) values(1,'2024-03-09',1,1),
																(2,'2024-03-10',2,5),
                                                                 (3,'2024-03-08',4,4),
                                                                 (4,'2024-03-07',3,2),
                                                                  (5,'2024-03-06',2,3);
/*
output
1	2024-03-09	1	1
2	2024-03-10	2	5
3	2024-03-08	4	4
4	2024-03-07	3	2
5	2024-03-06	2	3

*/

-- 03 update email of specific teacher

update teacher
set email = 'rohatki@gmail.com'
where id = 1;

-- output
/*
1	Jaya	Rohatki	rohatki@gmail.com
2	Jayanti	Bakshi	jayanti@gmail
3	kk	Patel	kk@gmail
4	Payal	Mishra	payal@gmail
*/

-- 04 delete specific enrollment

delete from enrollment
where students_s_id in(1);

select *
from enrollment;

-- output
/*
2	2024-03-10	2	5
3	2024-03-08	4	4
4	2024-03-07	3	2
5	2024-03-06	2	3
*/

-- 05 update course to assign specific teacher

update course
set teacher_id = 3
where id = 2;

select *
from course;

-- output

/*
1	Java Programming	90	2
2	Python Programming	80	3
3	HTML	            70	3
4	CSS	                80	4
5	C++	                90	2
*/

-- 06 delete student from students table with enrollment records

-- 07  modify the payment amount

update payment
set amount = 10000
where id = 1;

select *
from payment;

-- output
/*
1	10000	3
2	5000	1
3	7000	2
4	5000	4
*/

-- Task 03

-- 01. tota; payment made by specific student

select s.f_name,sum(amount)
from payment p JOIN students s ON s.s_id=p.students_s_id
group by s.f_name;

-- output
/*
Bibin	10000
Ajit	5000
Vikram	7000
Jadunath	5000
*/

-- 02 list of courses along with count of studenst enrolled

select c.name,count(e.course_id)
from enrollment e JOIN course c ON c.id=e.course_id
group by e.course_id;

-- output
/*
Python Programming	1
HTML	            1
CSS	                1
C++              	1
*/

-- 03 find the names of students who have not enrolled in any course
select f_name,l_name
from students
where S_id NOT IN(select e.students_s_id
				from enrollment e LEFT JOIN students s ON s.s_id=e.students_s_id);
                
-- output
/*
Ajit Doval
John Doe
*/

-- 04 list students along with course name

select s.f_name,s.l_name,c.name
from students s 
JOIN enrollment e ON s.s_id=e.students_s_id
JOIN course c ON c.id=e.course_id;

-- output

/*
Vikram Batra	C++
Jadunath Singh	CSS
Bibin Rawat	    Python Programming
Vikram Batra	HTML
*/

-- 05 list the teacher along with the course assinged

select  t.f_name, t.l_name ,c.name
from teacher t JOIN course c ON t.id= c.teacher_id
group by c.id;

-- output

/*
Jayanti	Bakshi	Java Programming
Jayanti	Bakshi	C++
kk Patel	    Python Programming
kk Patel	    HTML
Payal Mishra	CSS
*/

-- 06 list student and there enrollment date for specific course

select s.*, e.e_date
from students s 
JOIN enrollment e ON s.s_id=e.students_s_id
JOIN course c ON c.id=e.course_id
where c.name ='CSS';

-- output
/*
4	Jadunath	Singh	1965-12-08	jadunath@gmail	546732	2024-03-08
*/

-- 07 name students with no payments

select *
from students s LEFT JOIN payment p on s.s_id=p.students_s_id
where p.students_s_id is NULL;

-- output

/*
5	John	Doe	1995-08-15	doe@example.com	1234567890	NULL NULL NULL 	
*/

-- 08 identify course with no enrollment

select *
from course c LEFT JOIN enrollment e on c.id=e.course_id
where e.course_id is NULL;

-- output

/*
1	Java Programming	90	2  NULL  NULL  NULL  NULL 
*/

-- 09 identify studenst who are enrolled in more than one corse

-- 10 indentify the teachers who are not assinges with any course

select *
from teacher t LEFT JOIN course c ON c.teacher_id=t.id
where c.teacher_id IS NULL;

-- output

/*
1	Jaya	Rohatki 	rohatki@gmail.  NULL NULL NULL NULL
*/

-- task 04

-- 01 calculate average number of student enrolled in each course

select c.name , count(e.students_s_id)
from students s 
JOIN enrollment e ON s.s_id=e.students_s_id
JOIN course c ON c.id=e.course_id
group by c.id,c.name;

-- output
/*
C++	                1
CSS      	        1
Python Programming	1
HTML	            1
*/

-- 02 identify the student who made the higest payment

select s.f_name,p.amount
from students s LEFT JOIN payment p on s.s_id=p.students_s_id
order by p.amount asc
limit 1,1;

-- output
/*
Bibin	10000
*/

-- 03 list of courses with highest enrollment

select c.name, count(*) as no_of_course
from enrollment e
JOIN course c ON c.id=e.course_id
group by c.id
order by no_of_course desc
limit 1;

-- output
/*
Python Programming	1
*/

-- 04 total payment made to course taugth by each teacher

select t.f_name,t.l_name, sum(p.amount)
from payment p JOIN students s ON s.s_id=p.students_s_id
JOIN enrollment e ON s.s_id=e.students_s_id
JOIN course c ON c.id=e.course_id
JOIN teacher t ON c.teacher_id=t.id
group by t.id;

-- output
/*
kk	Patel	17000
Jayanti	Bakshi	7000
Payal	Mishra	5000
*/

-- 05 list student who enrolled in all course
select f_name
from students 
where s_id IN( select  e.students_s_id
              from students s JOIN enrollment e ON e.students_s_id=s.s_id)
              group by e.students_s_id
              having e.id in(select count(*)
              from course);
-- 6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments.
select *
from teacher t left JOIN course c on c.teacher_id=t.id
where c.id is null;

-- output
/*
1	Jaya	Rohatki	rohatki@gmail.com NULL NULL NULL NULL		
*/

-- 7. Calculate the average age of all students. Use subqueries to calculate the age of each student based on their date of birth.
select avg(dob)
from students 
group by s_id;

-- 8. Identify courses with no enrollments. Use subqueries to find courses without enrollment records.
select *
from course
where id not in(select course_id
                  from enrollment);
                  
-- output

/*
1	Java Programming	90	2
*/

-- 9. Calculate the total payments made by each student for each course they are enrolled in. 

select s.f_name,sum(amount)
from students s JOIN payment p ON s.s_id=p.students_s_id
group by s.f_name;

-- output

/*
Bibin	10000
Ajit	5000
Vikram	7000
Jadunath	5000
*/

-- 10. Identify students who have made more than one payment. 

select s.f_name,s.l_name,count(s.s_id) as 'student_payment'
from students s JOIN payment p ON s.s_id=p.students_s_id
group by s.s_id
having student_payment>1;

-- 11. Write an SQL query to calculate the total payments made by each student.
 
select s.f_name , sum(p.amount)
from students s JOIN payment p ON s.s_id=p.students_s_id
group by s.s_id;

-- output
/*
Bibin	10000
Ajit	5000
Vikram	7000
Jadunath	5000
*/


-- 12. Retrieve a list of course names along with the count of students enrolled in each course.

select c.name , count(e.students_s_id) as count_of_student_enrolled
from students s 
JOIN enrollment e ON s.s_id=e.students_s_id
JOIN course c ON c.id=e.course_id
group by c.id,c.name;

-- output

/*
C++	1
CSS	1
Python Programming	1
HTML	1
*/


-- 13. Calculate the average payment amount made by students. 
select s.f_name , avg(p.amount)
from students s JOIN payment p ON s.s_id=p.students_s_id
group by s.s_id;

-- output
/*
Bibin	10000
Ajit	5000
Vikram	7000
Jadunath	5000
*/











 
														

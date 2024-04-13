show databases;
use assignment_ticket;
show tables;
insert into venue(name,address) values
('mumbai', 'marol andheri(w)'),
('chennai', 'IT Park'),
('pondicherry ', 'state beach');

select*
from venue;

insert into customer(name,email,phone_number)
values
('harry potter','harry@gmail.com','45454545'),
('ronald weasley','ron@gmail.com','45454545'),
('hermione granger','her@gmail.com','45454545'),
('draco malfoy','drac@gmail.com','45454545'),
('ginni weasley','ginni@gmail.com','45454545');

select *
from customer;

insert into event(name,date,time,total_seats,available_seats,ticket_price,event_type,venue_id)
values
('Late Ms. Lata Mangeshkar Musical', '2021-09-12','20:00',320,270,600,'concert',3),
('CSK vs RCB', '2024-04-11','19:30',23000,3,3600,'sports',2),
('CSK vs RR', '2024-04-19','19:30',23000,10,3400,'sports',2),
('MI vs KKR', '2024-05-01','15:30',28000,100,8000,'sports',1);

select*
from event;

set foreign_key_checks=0;

INSERT INTO booking (event_id, customer_id, num_tickets, total_cost, booking_date)
VALUES
(1, 1, 2, 640, '2021-09-12'),
(1, 4, 3, 960, '2021-09-12'),
(2, 1, 3, 10800, '2024-04-11'),
(2, 3, 5, 18000, '2024-04-10'),
(3, 5, 10, 34000, '2024-04-15'),
(4, 2, 4, 32000, '2024-05-01');

-- task 1
-- 2). 
select * 
from event;

-- output
/*
1	Late Ms. Lata Mangeshkar Musical	2021-09-12	20:00:00	320	270	600	concert	3
2	CSK vs RCB	2024-04-11	19:30:00	23000	3	3600	sports	2
3	CSK vs RR	2024-04-19	19:30:00	23000	10	3400	sports	2
4	MI vs KKR	2024-05-01	15:30:00	28000	100	8000	sports	1
								
*/
-- 3). 
select *
 from event 
 where available_seats>0;

-- output 
/*
1	Late Ms. Lata Mangeshkar Musical	2021-09-12	20:00:00	320	270	600	concert	3
2	CSK vs RCB	2024-04-11	19:30:00	23000	3	3600	sports	2
3	CSK vs RR	2024-04-19	19:30:00	23000	10	3400	sports	2
4	MI vs KKR	2024-05-01	15:30:00	28000	100	8000	sports	1
*/
-- 4). 
    select *
    from event 
    where name LIKE '%cup%';
-- 5). 
select *
 from event
 where ticket_price between 1000 AND 2500;
-- 6). 
select * 
from event
 where event_date between '2021-09-01' AND '2023-12-12';
-- 7). 
select * 
from event 
where available_seats>0 AND name LIKE '%concert%';
-- 8). 
select * 
from customer 
limit 5,5;
-- 9). 
select * 
from booking 
where num_tickets>4;

-- output
/*
4	2	3	5	18000	2024-04-10
5	3	5	10	34000	2024-04-15
*/
-- 10).
 select * 
 from customer
 where phone_number LIKE '%000';
-- 11).
 select * 
 from event 
 where total_seats>15000 order by total_seats DESC;
 
 -- output
 /*
 4	MI vs KKR	2024-05-01	15:30:00	28000	100	8000	sports	1
2	CSK vs RCB	2024-04-11	19:30:00	23000	3	3600	sports	2
3	CSK vs RR	2024-04-19	19:30:00	23000	10	3400	sports	2
 */
-- 12).
 select name 
 from event 
 where name not like 'x%' AND name not like 'y%' and name not like 'z%';
 
 -- output
 /*
 Late Ms. Lata Mangeshkar Musical
CSK vs RCB
CSK vs RR
MI vs KKR
 */
 
 -- task 02
 
-- 1 )   
 select e.name, avg(b.total_cost)
 from event e JOIN booking b where e.id=b.event_id 
 group by e.name;
-- output
/*
Late Ms. Lata Mangeshkar Musical
CSK vs RCB
CSK vs RR
MI vs KKR
*/
     
-- 2).  
select e.name, sum(b.total_cost) 
from event e JOIN booking b ON e.id=b.event_id 
group by e.name;

-- output
/*
Late Ms. Lata Mangeshkar Musical	1600
CSK vs RCB	28800
CSK vs RR	34000
MI vs KKR	32000
*/
-- 3).
 select e.name, SUM(b.num_tickets) as total_tickets_sold 
 from event e JOIN booking b ON e.id=b.event_id 
 group by e.name 
 ORDER BY total_tickets_sold
 DESC limit 1;
 
 -- output CSK vs RR	10
 
-- 4). 
select e.name, SUM(num_tickets) 
from event e JOIN booking b ON e.id=b.event_id 
group by e.name;

-- output
/*
Late Ms. Lata Mangeshkar Musical	5
CSK vs RCB	8
CSK vs RR	10
MI vs KKR	4
*/
-- 5). 
 select *
 from event 
 where id NOT IN
 (select e.id
 from event e JOIN booking b ON e.id=b.event_id);
 
-- 6).
 select c.name, SUM(num_tickets) as tickets_bought 
 from customer c JOIN booking b ON c.id=b.customer_id 
 group by c.name 
 order by tickets_bought 
 DESC limit 1;
 
 -- output ginni weasley	10
 


-- 8).
select v.name, avg(ticket_price) as average_price 
from event e, venue v where v.id=e.venue_id 
group by v.name;

-- output
/*
mumbai	8000.0000
chennai	3500.0000
pondicherry 	600.0000
*/
-- 9). 
select e.event_type, SUM(num_tickets) 
from event e JOIN booking b ON e.id=b.event_id 
group by event_type;

-- output
/*
concert	5
sports	22
*/

-- 11). 
SELECT * 
FROM customer 
where id in 
(select customer_id 
from booking
 group by customer_id 
 having count(event_id)>1);
 
 -- output 1	harry potter	harry@gmail.com	45454545
-- 12). 
select c.name, SUM(b.total_cost)
 from customer c, booking b where c.id=b.customer_id 
 group by c.name;
 
 -- output
 /*
harry potter	    11440
ronald weasley	    32000
hermione granger	18000
draco malfoy	    960
ginni weasley	    34000
*/
-- 13). 
select e.event_type, v.name, AVG(e.ticket_price) 
from event e, venue v 
where e.venue_id=v.id 
group by e.event_type, v.name;

-- output
/*
sports	mumbai	8000.0000
sports	chennai	3500.0000
concert	pondicherry 	600.0000
*/

-- Task 04

-- 1). 
select v.name, AVG(e.ticket_price) 
from venue v, event e 
where e.venue_id=v.id 
group by v.name;

-- output
/*
mumbai	8000.0000
chennai	3500.0000
pondicherry 	600.0000
*/
-- 2). 
select *
 from event 
 WHERE total_seats-available_seats>total_seats/2;
 
 -- output
 /*
 2	CSK vs RCB	2024-04-11	19:30:00	23000	3	3600	sports	2
3	CSK vs RR	2024-04-19	19:30:00	23000	10	3400	sports	2
4	MI vs KKR	2024-05-01	15:30:00	28000	100	8000	sports	1
 */
-- 3). 
select name, SUM(total_seats-available_seats) as ticket_sold 
from event group by name;

-- output
/*
Late Ms. Lata Mangeshkar Musical	50
CSK vs RCB	22997
CSK vs RR	22990
MI vs KKR	27900
*/
-- 4). 
select *
 from customer 
 where id not in (select customer_id from booking);
 
-- 5). 
select * 
from event 
where id not in (select event_id from booking);

-- 6).
 select name, SUM(total_seats-available_seats) as total_tickets_sold 
 from event
 group by name;
 
 -- output
 /*
 Late Ms. Lata Mangeshkar Musical	50
CSK vs RCB	22997
CSK vs RR	22990
MI vs KKR	27900
 */
-- 7). 
select *
 from event 
 where ticket_price > 
 (select AVG(ticket_price) from event);
 
 -- output
 /*
 4	MI vs KKR	2024-05-01	15:30:00	28000	100	8000	sports	1
 */
-- 8). 
select c.name, SUM(b.total_cost) 
from customer c, booking b 
where c.id=b.customer_id 
group by c.name;

-- output
/*
harry potter	11440
ronald weasley	32000
hermione granger	18000
draco malfoy	960
ginni weasley	34000
*/

-- 9).
 select * 
 from customer
 where id in (select customer_id from booking 
               where event_id in (select id from event
               where venue_id in (select id from venue 
               where name='mumbai')));
               
               -- output 2	ronald weasley	ron@gmail.com	45454545
-- 10). 
select event_type, SUM(total_seats-available_seats) 
from event 
group by event_type;

-- output
/*
concert	50
sports	73887
*/

-- 12). 
select v.name, AVG(e.ticket_price) 
from venue v JOIN event e ON e.venue_id=v.id 
group by v.name;

-- output
/*
mumbai	8000.0000
chennai	3500.0000
pondicherry 	600.0000
*/


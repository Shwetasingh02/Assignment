show databases;
use bankingsystem;
insert into customer(f_name,l_name,dob) values 
('harry','potter','2002-03-21'),
('ronald','weasley','2001-02-10'),
('hermione','granger','2002-11-15');
select * from customer;

insert into account(account_type,balance,customer_id1) values 
('savings',50000,1) ,
('current',120000,2) ,
('zero_balance',100000,3),
('current',150000,1) ,
('savings',30000,3);

ALTER TABLE account
DROP COLUMN customer_id;

desc account;

select *
from account;

insert into transation(id,t_type,amount,t_date,account_id1) 
values 
(1,'deposit', 10000, '2024-02-01',1),
(2,'withdrawal', 5000, '2024-02-02',1),
(3,'deposit', 20000, '2024-02-02',2),
(4,'withdrawal', 8000, '2024-02-02',3),
(5,'transfer', 20000, '2024-02-01',4),
(6,'transfer', 7000, '2024-02-05',5);

select *
from transation;

-- task 02
-- 1. Write a SQL query to retrieve the name, account type and email of all customers. 
select *
from customer;

-- output

/*
1	harry	potter	2002-03-21
2	ronald	weasley	2001-02-10
3	hermione	granger	2002-11-15
*/
-- 2. Write a SQL query to list all transaction corresponding customer.

select c.*,t.*
from transation t JOIN account a ON t.account_id1=a.id
				  JOIN customer c ON a.customer_id1=c.id;
                  
-- output

/*
1	harry	potter	2002-03-21	1	deposit	10000	2024-02-01	1
1	harry	potter	2002-03-21	2	withdrawal	5000	2024-02-02	1
1	harry	potter	2002-03-21	5	transfer	20000	2024-02-01	4
2	ronald	weasley	2001-02-10	3	deposit	20000	2024-02-02	2
3	hermione	granger	2002-11-15	4	withdrawal	8000	2024-02-02	3
3	hermione	granger	2002-11-15	6	transfer	7000	2024-02-05	5
*/
                  
-- 3. Write a SQL query to increase the balance of a specific account by a certain amount.
select balance+30000
from account
where account_type='savings';

-- output

/*
80000
60000
*/
-- 04 Write a SQL query to Combine first and last names of customers as a full_name.
select concat(f_name ," ", l_name) as full_name
from customer;

-- output
/*
full_name
harry potter
ronald weasley
hermione granger
*/


-- 5 Write a SQL query to remove accounts with a balance of zero where the account type is savings.
select *
from account
where account_type='savings' and balance=0;

-- output will be NULL

-- 7. Write a SQL query to Get the account balance for a specific account.

select account_type, balance
from account 
where account_type='savings';

-- output
/*
savings	50000
savings	30000
*/

-- 8. Write a SQL query to List all current accounts with a balance greater than $1,000.
select account_type,balance
from account
where balance>1000;

-- output
/*
savings     	50000
current	        120000
zero_balance	100000
current	        150000
savings	         30000
*/

-- 9. Write a SQL query to Retrieve all transactions for a specific account.
select *
from transation
where account_id1 in(1,3,5);

-- output
/*
1	deposit	    10000	2024-02-01	1
2	withdrawal	5000	2024-02-02	1
4	withdrawal	8000	2024-02-02	3
6	transfer	7000	2024-02-05	5
*/
-- 10.Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate
-- 11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
-- 12.Write a SQL query to Find customers not living in a specific city.

-- task 03

-- 1. Write a SQL query to Find the average account balance for all customers. 

select c.f_name,avg(a.balance)
from customer c JOIN account a on c.id=a.customer_id1
group by c.f_name;

-- output
/*
harry	    100000
ronald	    120000
hermione	65000
*/

-- 2. Write a SQL query to Retrieve the top 10 highest account balances.
select account_type,balance
from account
order by balance desc
limit 10;

-- output

/*
current	        150000
current      	120000
zero_balance	100000
savings	        50000
savings	        30000
*/

-- 3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.

SELECT c.f_name, SUM(t.amount) AS total_deposits
FROM transation t
JOIN account a ON t.account_id1 = a.id
JOIN customer c ON c.id = a.customer_id1
WHERE t.t_type = 'deposit' AND DATE(t.t_date) = '2024-02-01'
GROUP BY c.f_name;

-- output
/*
harry	10000
*/

-- 4. Write a SQL query to Find the Oldest and Newest Customers.
select f_name, l_name, dob
from customer
order by dob ASC
limit 1;

select f_name, l_name,dob
from customer
order by dob DESC
limit 1;

-- . 5 Write a SQL query to Retrieve transaction details along with the account type.
select t.*,a.account_type
from transation t JOIN account a ON a.id=t.account_id1;

-- 6. Write a SQL query to Get a list of customers along with their account details.
select distinct c.*,  a.*
from customer c LEFT JOIN account a on c.id=a.customer_id1; 

-- output

/*
1	harry	potter	2002-03-21	1	savings	50000	1
1	harry	potter	2002-03-21	4	current	150000	1
2	ronald	weasley	2001-02-10	2	current	120000	2
3	hermione	granger	2002-11-15	3	zero_balance	100000	3
3	hermione	granger	2002-11-15	5	savings	30000	3
*/

-- 7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
select distinct c.*,  a.*
from customer c LEFT JOIN account a on c.id=a.customer_id1
where a.account_type='current';

-- output

/*
2	ronald	weasley	2001-02-10	2	current	120000	2
1	harry	potter	2002-03-21	4	current	150000	1
*/

-- 8. Write a SQL query to Identify customers who have more than one account.
select c.id, c.f_name, c.l_name
from customer c
join account a ON c.id = a.customer_id1
group by c.id, c.f_name, c.l_name
having COUNT(a.id) > 1;

-- output
/*
1	harry	    potter
3	hermione	granger
*/

-- 9. . Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.

select ((select sum(amount)
from transation 
where t_type ='deposit')- (select sum(amount)
                           from transation
                            where t_type='withdrawal')) as difference;
 -- output
 /*
 17000
 */

-- 10. Write a SQL query to Calculate the average daily balance for each account over a specified period.

select a.account_type,avg(a.balance)
from account a JOIN transation t ON a.id=t.account_id1
where DATE (t_date) between '2024-02-01' AND '2024-02-03'
group by a.account_type;

-- output
/*
savings	50000
current	135000
zero_balance	100000
*/

-- 11. Calculate the total balance for each account type.
select account_type ,sum(balance)
from account
group by account_type;

-- output

/*
savings     	80000
current	        270000
zero_balance	100000
*/

-- 12. Identify accounts with the highest number of transactions order by descending order.
select *
from transation
order by amount desc;

-- output
/*
3	deposit	    20000	2024-02-02	2
5	transfer	20000	2024-02-01	4
1	deposit	    10000	2024-02-01	1
4	withdrawal	8000	2024-02-02	3
6	transfer	7000	2024-02-05	5
2	withdrawal	5000	2024-02-02	1
*/

-- 13. List customers with high aggregate account balances, along with their account types.
select *
from transation
order by amount desc 
limit 1;

-- ouput
/*
3	deposit	20000	2024-02-02	2
*/

-- 14. Identify and list duplicate transactions based on transaction amount, date, and account

select a.account_type , t.t_date, t.t_type
from transation t JOIN account a ON t.account_id1= a.id
where count(*)>1; 



-- task 04

-- 1. Retrieve the customer(s) with the highest account balance.

select c.*,a.balance
from customer c JOIN account a ON c.id=a.customer_id1
order by a.balance desc
limit 1; 

-- output
/*
1	harry	potter	2002-03-21	150000
*/

-- 2. Calculate the average account balance for customers who have more than one account.

select c.*,avg(a.balance),count(a.customer_id1) as 'Number_of_account'
from customer c JOIN account a on c.id=a.customer_id1
group by c.id
having (Number_of_account) >1;

-- output

/*
1	harry potter	    2002-03-21	    100000	2
3	hermione granger	2002-11-15	    65000	2
*/

-- 3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
select *
from transation
where amount > 
(select avg(amount) from transation);

-- output

/*
3	deposit	    20000	2024-02-02	2
5	transfer	20000	2024-02-01	4
*/


-- 4. Identify customers who have no recorded transactions.

select id,f_name
from customer
where id NOT IN(select distinct customer_id1
                from account
                where customer_id1 NOT IN(
                select distinct account_id1
                from transation));
                
-- . 5 Calculate the total balance of accounts with no recorded transactions.

select sum(balance)
from account
where id NOT IN (select account_id1
                 from transation); 
                 
-- 6. Retrieve transactions for accounts with the lowest balance.
select t.*
from transation t JOIN account a ON a.id=t.account_id1
order by a.balance ASC
limit 1;

-- output
/*
6	transfer	7000	2024-02-05	5
*/

-- 7. Identify customers who have accounts of multiple types.

select *
from customer
where id IN (select customer_id1
            from account
            group by customer_id1
			having count(distinct account_type)>1);
            
-- output

/*
1	harry potter	    2002-03-21
3	hermione granger	2002-11-15
*/
		
-- 8. Calculate the percentage of each account type out of the total number of accounts.
-- 9. Retrieve all transactions for a customer with a given customer_id.
select t.*,c.id as customer__id
from transation t JOIN account a on t.account_id1=a.id
                  JOIN customer c on a.customer_id1=c.id;
                  
-- output
/*
1	deposit	10000	2024-02-01	1	1
2	withdrawal	5000	2024-02-02	1	1
5	transfer	20000	2024-02-01	4	1
3	deposit	20000	2024-02-02	2	2
4	withdrawal	8000	2024-02-02	3	3
6	transfer	7000	2024-02-05	5	3
*/
                  
                  
-- 10. Calculate the total balance for each account type, including a subquery within the SELECT clause.
           select account_type,sum(balance)
           from account
           group by account_type;
           
-- output

/*
savings	80000
current	270000
zero_balance	100000
*/

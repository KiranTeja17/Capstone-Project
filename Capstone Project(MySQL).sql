use project 


-- Q1) Write an SQL query to identify the age group which is taking more loan and then calculate the sum of all of the balances of it?
-- Ans:-

select Age_div, count(*) as 'Loan_Count', sum(Balance) as BalanceSum
from df
where Loan = 'yes' or Housing = 'yes'
group by Age_div;

# Mid Aged group has taken the most number of loans followd by Adults, Young and Old.

# The sum of balances of all age groups are shown in the below table. 


-- Q2) Write an SQL query to calculate for each record if a loan has been taken less than 100, then  calculate the fine of 15% of the current balance and create a temp table and then add the amount for each month from that temp table? 
-- Ans:-

# Creating a Temporary table "Temp" with the appropriate attributes
 
create temporary table Temp
select Loan,Housing as House_Loan,Month, Balance, Balance*15/100 as Fine 
from df
where  Loan = 'yes' or Housing = 'yes' and Balance < 100;

# As the temp table is created we proceed to the monthly balance calculation

select Month,sum(Balance) as Month_Balance
from Temp
group by Month 
order by Month_Balance desc;

# The month of May has the highest balance record out of all months followed by july and november where the loan amount taken is less than 100.

# December has the least recorded monthly balance out of all months.


-- Q3) Write an SQL query to calculate each age group along with each department's highest balance record? 
-- Ans:-

select  Job, Age_div as 'Age Group',max(Balance) as Maximum_Balance
from df
group by Job, Age_div
order by Maximum_Balance desc;

# The Mid Aged employees in the management department is the group having the maximum balance and the Young aged retired individuals have the least balance out of all.


-- Q4) Write an SQL query to find the secondary highest education, where duration is more than 150. 
--    The query should contain only married people, and then calculate the interest amount? (Formula interest => balance*15%). 
-- Ans:-

select Age_div as 'Age Group',Marital as 'Marital Status',Education,Duration,Balance,Balance*15/100 as Interest 
from df 
where Marital = 'married' and Education = 'secondary' and Duration > 150;


-- Q5)Write an SQL query to find which profession has taken more loan along with age?
-- Ans:-

select Job,Age_div as 'Age Group', count(*) as Loan_Count
from df
where Housing = 'yes' or Loan = 'yes'
group by Job, Age_div
order by Loan_Count desc;

# As we can see that the Mid Aged employees holding a Blue-collar job are the people who have taken the most number of loans.
# The old aged with an unknown job and the retired young individuals has only taken 1 loan each, which is the least out of all.

-- Q6)Write an SQL query to calculate each month's total balance and then calculate in which month the highest amount of transaction was performed? 
-- Ans:- 

select Month ,sum(Balance) as Total_Transactions
from df
group by Month
order by Total_Transactions desc;

# May is the month with the highest amount of transactions than any other month followed by November,August,June,etc.,
# As we already have divided months into weeks, we can also look at what week of a month had the highest amount of transactions.

select Month ,Day_div as Week,sum(Balance) as Total_Transactions
from df
group by Month, Day_div
order by Total_Transactions desc; 

# From this we can observe that the third week of November had the highest amount of transactions which is greater than the 2nd and 3rd weeks of may combined.
# Also the lowest transactions happened in the 1st and 3rd weeks of January i.e, starting of the year.



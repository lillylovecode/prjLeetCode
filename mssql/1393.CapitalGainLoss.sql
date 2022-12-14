--===========================

--===========================
Create Table #Stocks (stock_name varchar(15), operation varchar(50), operation_day int, price int)
--insert into #Stocks (stock_name, operation, operation_day, price) values ('Leetcode', 'Buy', '1', '1000')
--insert into #Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Buy', '2', '10')
--insert into #Stocks (stock_name, operation, operation_day, price) values ('Leetcode', 'Sell', '5', '9000')
--insert into #Stocks (stock_name, operation, operation_day, price) values ('Handbags', 'Buy', '17', '30000')
--insert into #Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Sell', '3', '1010')
--insert into #Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Buy', '4', '1000')
--insert into #Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Sell', '5', '500')
--insert into #Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Buy', '6', '1000')
--insert into #Stocks (stock_name, operation, operation_day, price) values ('Handbags', 'Sell', '29', '7000')
--insert into #Stocks (stock_name, operation, operation_day, price) values ('Corona Masks', 'Sell', '10', '10000')

select * from #Stocks

select stock_name,sum(price)as capital_gain_loss
from #Stocks
group by stock_name

select stock_name,operation,iif(operation='Buy',-sum(price),sum(price))
from #Stocks
group by stock_name,operation

select t.stock_name,sum(gain_loss) as capital_gain_loss
from (
	select stock_name,operation,iif(operation='Buy',-sum(price),sum(price)) as gain_loss
	from #Stocks
	group by stock_name,operation
	)t
group by stock_name
order by capital_gain_loss desc

----------------------------------------------------------------------------------
select stock_name,sum(
	case 
	when operation='Buy' 
	then -price 
	else price 
	end 
)as capital_gain_loss
from #Stocks
group by stock_name
order by capital_gain_loss desc
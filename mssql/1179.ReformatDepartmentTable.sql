Create table ##Department
(
	id int,
	revenue int,
	month varchar(20)
)

insert into ##Department (id, revenue, month) values (1, 8000, 'Jan')
insert into ##Department (id, revenue, month) values (2, 9000, 'Jan')
insert into ##Department (id, revenue, month) values (3, 10000,'Feb')
insert into ##Department (id, revenue, month) values (1, 7000, 'Feb')
insert into ##Department (id, revenue, month) values (1, 6000, 'Mar')

--¤g¬¶ªk
select 
ids.id,
Jan.revenue as 'Jan_Revenue',
Feb.revenue as 'Feb_Revenue',
Mar.revenue as 'Mar_Revenue'
from 
(
SELECT DISTINCT id
FROM ##Department
) AS ids
left join 
(select id,revenue
from  ##Department
where month = 'Jan')as Jan on ids.id = Jan.id
left join 
(select id,revenue
from  ##Department
where month = 'Feb')as Feb on ids.id = Feb.id
left join 
(select id,revenue
from  ##Department
where month = 'Mar')as Mar on ids.id = Mar.id


--¸Ñªk2
select id,
sum(iif(month='Jan',revenue,null))as'Jan_Revenue',
sum(iif(month='Feb',revenue,null))as'Feb_Revenue',
sum(iif(month='Mar',revenue,null))as'Mar_Revenue',
sum(iif(month='Apr',revenue,null))as'Apr_Revenue',
sum(iif(month='May',revenue,null))as'May_Revenue',
sum(iif(month='Jun',revenue,null))as'Jun_Revenue',
sum(iif(month='Jul',revenue,null))as'Jul_Revenue',
sum(iif(month='Aug',revenue,null))as'Aug_Revenue',
sum(iif(month='Sep',revenue,null))as'Sep_Revenue',
sum(iif(month='Oct',revenue,null))as'Oct_Revenue',
sum(iif(month='Nov',revenue,null))as'Nov_Revenue',
sum(iif(month='Dec',revenue,null))as'Dec_Revenue'
from ##Department
group by id

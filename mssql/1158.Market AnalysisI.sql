Create table #Users (user_id int, join_date date, favorite_brand varchar(10))
Create table #Orders(order_id int, order_date date, item_id int, buyer_id int, seller_id int)
Create table #Items (item_id int, item_brand varchar(10))
--insert into #Users (user_id, join_date, favorite_brand) values ('1', '2018-01-01', 'Lenovo')
--insert into #Users (user_id, join_date, favorite_brand) values ('2', '2018-02-09', 'Samsung')
--insert into #Users (user_id, join_date, favorite_brand) values ('3', '2018-01-19', 'LG')
--insert into #Users (user_id, join_date, favorite_brand) values ('4', '2018-05-21', 'HP')
--insert into #Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('1', '2019-08-01', '4', '1', '2')
--insert into #Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('2', '2018-08-02', '2', '1', '3')
--insert into #Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('3', '2019-08-03', '3', '2', '3')
--insert into #Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('4', '2018-08-04', '1', '4', '2')
--insert into #Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('5', '2018-08-04', '1', '3', '4')
--insert into #Orders (order_id, order_date, item_id, buyer_id, seller_id) values ('6', '2019-08-05', '2', '2', '4')
--insert into #Items (item_id, item_brand) values ('1', 'Samsung')
--insert into #Items (item_id, item_brand) values ('2', 'Lenovo')
--insert into #Items (item_id, item_brand) values ('3', 'LG')
--insert into #Items (item_id, item_brand) values ('4', 'HP')


--select u1.user_id as buyer_id,u1.join_date,isnull(t.orders_in_2019,0) as orders_in_2019
--from #Users u1
--left join
--(
--	select u.user_id,count(o.order_id) as orders_in_2019
--	from #Users u
--	join #Orders o on u.user_id = o.buyer_id
--	join #Items i on i.item_id = o.item_id
--	where o.order_date between '2019-01-01' and '2019-12-31'
--	group by u.user_id
--)t
--on u1.user_id = t.user_id



--select u1.user_id as buyer_id,u1.join_date,isnull(t.orders_in_2019,0) as orders_in_2019
--from #Users u1
--left join
--(
--	select buyer_id,count(o.order_id) as orders_in_2019
--	from #Orders o 
--	where year(o.order_date)='2019'
--	group by o.buyer_id
--)t
--on u1.user_id = t.buyer_id


select u1.user_id as buyer_id,u1.join_date,isnull(count(o.order_id),0) as orders_in_2019
from #Users u1
left join #Orders o on u1.user_id = o.buyer_id and YEAR(o.order_date)='2019'
group by u1.user_id,u1.join_date
order by 1

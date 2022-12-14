--===========================
--欄位轉置
--===========================
Create table #Products (product_id int, store1 int, store2 int, store3 int)
insert into #Products (product_id, store1, store2, store3) values ('0', '95', '100', '105')
insert into #Products (product_id, store1, store2, store3) values ('1', '70', null, '80')


select * from #Products


------------------------------------------------------
--SubQuery(效能差)

--select product_id,store,price
--from(
--select product_id,'store1' as store,store1 as price
--from #Products
--union all
--select product_id,'store2' as store,store2 as price
--from #Products
--union all
--select product_id,'store3' as store,store3 as price
--from #Products
--)t
--where price is not null
--order by product_id,store

------------------------------------------------------
--union

select product_id,'store1' as store,store1 as price
from #Products where store1 is not null
union all
select product_id,'store2' as store,store2 as price
from #Products where store2 is not null
union all
select product_id,'store3' as store,store3 as price
from #Products where store3 is not null
order by product_id,store

------------------------------------------------------
--unpivot

create table #temp
(product_id int, store varchar(10), price int)

insert #temp
select product_id, store, price
from #Products
unpivot( 
	price 
	for store in([store1], [store2], [store3]) 
) as test_unpivot
order by product_id 

select * from #Products
------------------------------------------------------
--pivot

select product_id,store1,store2,store3
from 
(
	select product_id,store,price from #temp
)as sorceTable
pivot
( 
	sum(price) --這裡一定要是總匯函式(avg, sum, count, etc.)
	for store in ([store1],[store2],[store3]) 
)as pivotTable


--select * from #temp
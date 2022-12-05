Create table #Product (product_id int, product_name varchar(10), unit_price int)
Create table #Sales (seller_id int, product_id int, buyer_id int, sale_date date, quantity int, price int)

--insert into #Product (product_id, product_name, unit_price) values ('1', 'S8', '1000')
--insert into #Product (product_id, product_name, unit_price) values ('2', 'G4', '800')
--insert into #Product (product_id, product_name, unit_price) values ('3', 'iPhone', '1400')

--insert into #Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '1', '1', '2019-01-21', '2', '2000')
--insert into #Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('1', '2', '2', '2019-02-17', '1', '800')
--insert into #Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('2', '2', '3', '2019-06-02', '1', '800')
--insert into #Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) values ('3', '3', '4', '2019-05-13', '2', '2800')



select p.product_id,p.product_name
from #Product p
join #Sales s on s.product_id = p.product_id
where s.sale_date between '2019-01-01' and '2019-03-31'
and p.product_id not in 
(
	select s2.product_id
	from #Sales s2
	where s2.sale_date<'2019-01-01' or s2.sale_date>'2019-03-31'
)


--accepted
select S.product_id, p.product_name
from #Sales as s
left join #Product as p on s.product_id=p.product_id
group by S.product_id, p.product_name
having (max(sale_date) between '2019-01-01' and '2019-03-31'
        and min(sale_date) between '2019-01-01' and '2019-03-31'
        )


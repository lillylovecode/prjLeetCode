Create table ##Trips (id int, client_id int, driver_id int, city_id int, status varchar(100), request_at varchar(50))
Create table ##Users (users_id int, banned varchar(50), role varchar(100))

--truncate table ##Trips
--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'cancelled_by_client', '2013-10-04')

--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01')
--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01')
--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01')
--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01')
--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02')
--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02')
--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02')
--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03')
--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03')
--insert into ##Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03')

--truncate table ##Users
--insert into ##Users (users_id, banned, role) values ('1', 'No', 'client')
--insert into ##Users (users_id, banned, role) values ('10', 'No', 'driver')

--insert into ##Users (users_id, banned, role) values ('1', 'No', 'client')
--insert into ##Users (users_id, banned, role) values ('2', 'Yes', 'client')
--insert into ##Users (users_id, banned, role) values ('3', 'No', 'client')
--insert into ##Users (users_id, banned, role) values ('4', 'No', 'client')
--insert into ##Users (users_id, banned, role) values ('10', 'No', 'driver')
--insert into ##Users (users_id, banned, role) values ('11', 'No', 'driver')
--insert into ##Users (users_id, banned, role) values ('12', 'No', 'driver')
--insert into ##Users (users_id, banned, role) values ('13', 'No', 'driver')

--題目:歸納取消率
--取消率定義:當日取消的旅程 / 當日總旅程 (必須是沒有被ban)


--未排除被ban名單
--select a.request_at as 'Day',ROUND(CONVERT(float, a.[canceled day trips])/b.[day trips],2) as 'Cancellation Rate'
select b.request_at,b.[day trips],ISNULL(a.[canceled day trips],0) as 'canceled day trips'
from
(
select request_at,count(1) as 'day trips'
from ##Trips t
left join ##Users s on s.users_id = t.client_id and s.role='client'
left join ##Users s2 on s.users_id = t.driver_id and s.role = 'driver'
group by request_at
)b 
left join
(
select request_at,count(1) as 'canceled day trips'
from ##Trips
where status != 'completed'
group by request_at
) as a on a.request_at = b.request_at

--====================================================================================================================

--排除被ban名單
--select w.request_at,y.cancel,w.[day trips]
select w.request_at as 'Day',isnull(round(convert(float,y.cancel)/w.[day trips],2),0) as 'Cancellation Rate'
from 
(
select j.request_at,count(1) as 'day trips' from 
	(
		select * from ##Trips t left join ##Users s on s.users_id = t.client_id where banned = 'NO'  --乘客
	) j
	join 
	(
		select * from ##Trips t left join ##Users s on s.users_id = t.driver_id where banned = 'NO'  --司機
	) k on j.id = k.id --司機或乘客都沒有被ban的總旅程
	group by j.request_at
) w
left join
	(
	select j.request_at,count(1) as 'cancel' from 
	(
		select * from ##Trips t left join ##Users s on s.users_id = t.client_id where banned = 'NO' and status != 'completed' --乘客
	) j
	join 
	(
		select * from ##Trips t left join ##Users s on s.users_id = t.driver_id where banned = 'NO' and status != 'completed' --司機
	) k on j.id = k.id --司機或乘客都沒有被ban的被取消旅程
	group by j.request_at
	)y 
on w.request_at = y.request_at
where w.request_at between '2013-10-01' and '2013-10-03'



--====================================================================================================================
--別人的解法
SELECT T.request_at AS Day,
      CASE WHEN COUNT(0) = 0 THEN 0
      ELSE
        ROUND(CAST(COUNT(CASE WHEN T.status in('cancelled_by_driver', 'cancelled_by_client') THEN t.id ELSE NULL END) AS DECIMAL(12,2)) / CAST(COUNT(0)  AS DECIMAL(12,2)),2) END 'Cancellation Rate'
  FROM ##Trips AS T 
  INNER JOIN ##Users AS U ON T.client_id = U.users_id
  INNER JOIN ##Users AS DU ON T.driver_id = DU.users_id
WHERE u.banned = 'No' and DU.banned = 'No'
  and T.request_at between '2013-10-01' and '2013-10-03'
GROUP BY T.request_at





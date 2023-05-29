Create table ##Activity (player_id int, device_id int, event_date date, games_played int)
--drop table ##Activity
insert into ##Activity (player_id, device_id, event_date, games_played) values (1, 2, '2016-03-01', 5)
insert into ##Activity (player_id, device_id, event_date, games_played) values (1, 2, '2016-03-02', 6)
insert into ##Activity (player_id, device_id, event_date, games_played) values (2, 3, '2017-06-25', 1)
insert into ##Activity (player_id, device_id, event_date, games_played) values (3, 1, '2016-03-02', 0)
insert into ##Activity (player_id, device_id, event_date, games_played) values (3, 4, '2018-07-03', 5)

select * from ##Activity

--=======================方法1 普通函數==========================================

--1.第一次登入日期
select a1.player_id,min(a1.event_date)as first_login
from ##Activity a1
group by a1.player_id

--2.找出第一次登入後隔天有登入
select COUNT(1)
from ##Activity a2
join 
(
	select a1.player_id,min(a1.event_date)as first_login
	from ##Activity a1
	group by a1.player_id
) as b on a2.player_id = b.player_id
where a2.event_date = DATEADD(day,1, b.first_login)


--3.有登入這些人數除以總人數
select ROUND(CONVERT(float,COUNT(1))/(select COUNT(distinct player_id) from ##Activity) ,2) as fraction
from ##Activity a2
join 
(
	select a1.player_id,MIN(a1.event_date)as first_login
	from ##Activity a1
	group by a1.player_id
) as b on a2.player_id = b.player_id
where a2.event_date = DATEADD(DAY,1, b.first_login)

--=======================方法2 視窗函數==========================================

--LAG 函數，例如 LAG(order)，就會利用 PARTITION BY 和 ORDER BY 進行分割跟排序後，排列好的資料集，列出前一筆 order 的數量
--LEAD 函數，例如 LAG(order)，就會利用 PARTITION BY 和 ORDER BY 進行分割跟排序後，排列好的資料集，列出後一筆 order 的數量

--LEAD() 找出第一次登入後一筆登入日期
select LEAD(event_date) over(partition by player_id order by event_date)
from ##Activity


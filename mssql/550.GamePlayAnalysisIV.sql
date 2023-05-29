Create table ##Activity (player_id int, device_id int, event_date date, games_played int)
--drop table ##Activity
insert into ##Activity (player_id, device_id, event_date, games_played) values (1, 2, '2016-03-01', 5)
insert into ##Activity (player_id, device_id, event_date, games_played) values (1, 2, '2016-03-02', 6)
insert into ##Activity (player_id, device_id, event_date, games_played) values (2, 3, '2017-06-25', 1)
insert into ##Activity (player_id, device_id, event_date, games_played) values (3, 1, '2016-03-02', 0)
insert into ##Activity (player_id, device_id, event_date, games_played) values (3, 4, '2018-07-03', 5)

select * from ##Activity

--=======================��k1 ���q���==========================================

--1.�Ĥ@���n�J���
select a1.player_id,min(a1.event_date)as first_login
from ##Activity a1
group by a1.player_id

--2.��X�Ĥ@���n�J��j�Ѧ��n�J
select COUNT(1)
from ##Activity a2
join 
(
	select a1.player_id,min(a1.event_date)as first_login
	from ##Activity a1
	group by a1.player_id
) as b on a2.player_id = b.player_id
where a2.event_date = DATEADD(day,1, b.first_login)


--3.���n�J�o�ǤH�ư��H�`�H��
select ROUND(CONVERT(float,COUNT(1))/(select COUNT(distinct player_id) from ##Activity) ,2) as fraction
from ##Activity a2
join 
(
	select a1.player_id,MIN(a1.event_date)as first_login
	from ##Activity a1
	group by a1.player_id
) as b on a2.player_id = b.player_id
where a2.event_date = DATEADD(DAY,1, b.first_login)

--=======================��k2 �������==========================================

--LAG ��ơA�Ҧp LAG(order)�A�N�|�Q�� PARTITION BY �M ORDER BY �i����θ�Ƨǫ�A�ƦC�n����ƶ��A�C�X�e�@�� order ���ƶq
--LEAD ��ơA�Ҧp LAG(order)�A�N�|�Q�� PARTITION BY �M ORDER BY �i����θ�Ƨǫ�A�ƦC�n����ƶ��A�C�X��@�� order ���ƶq

--LEAD() ��X�Ĥ@���n�J��@���n�J���
select LEAD(event_date) over(partition by player_id order by event_date)
from ##Activity


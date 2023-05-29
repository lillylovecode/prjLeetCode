Create table ##Trips (id int, client_id int, driver_id int, city_id int, status varchar(100), request_at varchar(50))
Create table ##Users (users_id int, banned varchar(50), role varchar(100))

--drop table ##Trips
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

--drop table ##Users
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

select * from ##Users where banned = 'NO'



select * from ##Trips t
join ##Users u on t.client_id = u.users_id and u.banned = 'NO'
where status != 'completed'

select * from ##Trips t
join ##Users s on t.driver_id = s.users_id and s.banned = 'NO'
where status != 'completed'
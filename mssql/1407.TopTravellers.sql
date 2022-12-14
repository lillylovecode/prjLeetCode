Create Table #Users (id int, name varchar(30))
Create Table #Rides (id int, user_id int, distance int)
--insert into #Users (id, name) values ('1', 'Alice')
--insert into #Users (id, name) values ('2', 'Bob')
--insert into #Users (id, name) values ('3', 'Alex')
--insert into #Users (id, name) values ('4', 'Donald')
--insert into #Users (id, name) values ('7', 'Lee')
--insert into #Users (id, name) values ('13', 'Jonathan')
--insert into #Users (id, name) values ('19', 'Elvis')
--insert into #Rides (id, user_id, distance) values ('1', '1', '120')
--insert into #Rides (id, user_id, distance) values ('2', '2', '317')
--insert into #Rides (id, user_id, distance) values ('3', '3', '222')
--insert into #Rides (id, user_id, distance) values ('4', '7', '100')
--insert into #Rides (id, user_id, distance) values ('5', '13', '312')
--insert into #Rides (id, user_id, distance) values ('6', '19', '50')
--insert into #Rides (id, user_id, distance) values ('7', '7', '120')
--insert into #Rides (id, user_id, distance) values ('8', '19', '400')
--insert into #Rides (id, user_id, distance) values ('9', '7', '230')


select u.name,isnull(sum(r.distance),0) as travelled_distance
from #Users u
left join #Rides r on r.user_id = u.id
group by u.id,u.name
order by travelled_distance desc

select u.name,isnull(sum(r.distance),0) as travelled_distance
from #Users u
left join #Rides r on r.user_id = u.id
group by u.id,u.name
order by sum(r.distance) desc,u.name
--drop table ##Employee
--Create table ##Employee (id varchar(100), name varchar(255), department varchar(255), managerId varchar(100))

--insert into ##Employee (id, name, department, managerId) values ('101', 'John', 'A', 'None')
--insert into ##Employee (id, name, department, managerId) values ('102', 'Dan', 'A', '101')
--insert into ##Employee (id, name, department, managerId) values ('103', 'James', 'A', '101')
--insert into ##Employee (id, name, department, managerId) values ('104', 'Amy', 'A', '101')
--insert into ##Employee (id, name, department, managerId) values ('105', 'Anne', 'A', '101')
--insert into ##Employee (id, name, department, managerId) values ('106', 'Ron', 'B', '101')


select name
from ##Employee
where id in
(
select managerId
from  ##Employee
group by managerId
having count(1)>=5
)
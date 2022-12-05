select d.name as Department, e.name as Employee, e.salary as Salary
from Employee e 
join Department d on e.departmentId = d.id
join 
(
	select d.id,MAX(e.salary) as Salary
	from Employee e join Department d
	on e.departmentId = d.id
	group by d.id
) as m on m.id = d.id and m.Salary = e.salary



--d.name as Department,e.name as Employee, 


--create table Department 
--(	
--	id int, 
--	name varchar(10)
--)

--insert into Department values 
--(1,'IT'),
--(2,'Sales')


--create table Employee
--(
--	id int,
--	name varchar(10),
--	salary int,
--	departmentId int
--)

--insert into Employee values
--(1,'Joe',7000,1),
--(2,'Jim',9000,1),
--(3,'Henry',8000,2),
--(4,'Sam',6000,2),
--(5,'Max',9000,1)
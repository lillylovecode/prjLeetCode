Create table #Employee (id int, name varchar(255), salary int, departmentId int)
Create table #Department (id int, name varchar(255))
--insert into #Employee (id, name, salary, departmentId) values ('1', 'Joe', '85000', '1')
--insert into #Employee (id, name, salary, departmentId) values ('2', 'Henry', '80000', '2')
--insert into #Employee (id, name, salary, departmentId) values ('3', 'Sam', '60000', '2')
--insert into #Employee (id, name, salary, departmentId) values ('4', 'Max', '90000', '1')
--insert into #Employee (id, name, salary, departmentId) values ('5', 'Janet', '69000', '1')
--insert into #Employee (id, name, salary, departmentId) values ('6', 'Randy', '85000', '1')
--insert into #Employee (id, name, salary, departmentId) values ('7', 'Will', '70000', '1')
--insert into #Department (id, name) values ('1', 'IT')
--insert into #Department (id, name) values ('2', 'Sales')

select * from #Employee
select * from #Department

select d.name as Department,e.name as Employee,e.salary as Salary
from #Employee e
join #Department d on e.departmentId = d.id
where e.salary in (
	select salary
	from #Employee
	order by salary desc
)
order by Department,Salary desc


--with as 用法
with cte as(
select *, DENSE_RANK() over (partition by departmentId order by salary desc) as 'num' from Employee)
select d.name as 'Department', c.name as 'Employee', c.salary from cte c join Department d on c.departmentId = d.id where c.num<4


--subQuery用法
select d.name as 'Department', c.name as 'Employee', c.salary 
from (
	select *, DENSE_RANK() over (partition by departmentId order by salary desc) as 'num' from Employee --各部門排名 dense_rank()同分同排名
) c 
join Department d on c.departmentId = d.id where c.num < 4 --取前三名
order by c.id

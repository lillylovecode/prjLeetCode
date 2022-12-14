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

select d.name as Department,e1.name as Employee,e1.salary as Salary
from #Employee e1
join #Department d on e1.departmentId = d.id
where 3 >
(
    select count(distinct e2.Salary)
    from #Employee e2
    where e2.Salary > e1.Salary
)
order by Department,Salary desc


select *
from #Employee 

select e1.Name as 'Employee', e1.Salary
from #Employee e1
where 3 >
(
    select count(distinct e2.Salary)
    from #Employee e2
    where e2.Salary > e1.Salary
)


SELECT
    d.Name AS 'Department', e1.Name AS 'Employee', e1.Salary
FROM
    #Employee e1 JOIN #Department d ON e1.DepartmentId = d.Id
WHERE
    (
	SELECT COUNT(DISTINCT e2.Salary)
    FROM #Employee e2
    WHERE e2.Salary > e1.Salary
    AND e1.DepartmentId = e2.DepartmentId
)<3

--ROW_NUMBER()------------------------------------------------------------------------------------------

--with as 用法
with cte as(
select *, ROW_NUMBER() over (partition by departmentId order by salary desc) as 'num' from Employee)
select d.name as 'Department', c.name as 'Employee', c.salary from cte c join Department d on c.departmentId = d.id where c.num<4


--subQuery用法
select d.name as 'Department', c.name as 'Employee', c.salary 
from (
	select *, ROW_NUMBER() over (partition by departmentId order by salary desc) as 'num' from Employee
) c 
join Department d on c.departmentId = d.id where c.num<4
order by salary

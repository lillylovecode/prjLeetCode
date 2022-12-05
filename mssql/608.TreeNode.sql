--create table Tree
--(
--	id int,
--	p_id int
--)

--insert into Tree values
--(1,null),
--(2,1),
--(3,1),
--(4,2),
--(5,2)


--select * 
--from Tree t1 left join Tree t2 on t1.p_id = t2.id 

--select id from tree where id in (select p_id from Tree)

--¦Û¸Ñ
select id,
case 
	when (p_id is null) then 'Root' --no parent node
	when id in (select distinct p_id from Tree where p_id is not null) then 'Inner' --have parent node
	when id not in (select distinct p_id from Tree where p_id is not null) then 'Leaf' end --no child node
as type 
from Tree

--¸Ñµª
select id,'Root' as type
from Tree
where p_id is null
union
select id,'Leaf' as type
from Tree
where id not in(
	select distinct p_id 
	from Tree 
	where p_id is not null
	)
and p_id is not null
union
select id,'Inner' as type
from Tree
where id in(
	select distinct p_id 
	from Tree 
	where p_id is not null)
and p_id is not null

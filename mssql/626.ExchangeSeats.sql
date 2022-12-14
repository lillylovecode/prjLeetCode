select * from Department


declare @lastId int
select top 1 @lastId = id from Department order by id desc

select id = case when id%2 = 0 and id != @lastId then id-1 
				 when id%2 = 1 and id != @lastId then id+1 
				 when id%2 = 0 and id = @lastId then id-1 
				 when id%2 = 1 and id = @lastId then id end,name
from Department
order by id


--insert Department values
--(6,'Test')


--³Ì«áµª®×
--declare @lastId int
--select top 1 @lastId = id from Seat order by id desc

--select id = case when id%2 = 0 and id != @lastId then id-1 
--				   when id%2 = 1 and id != @lastId then id+1 
--				   when id%2 = 0 and id = @lastId then id-1 
--				   when id%2 = 1 and id = @lastId then id end,student 
--from Seat
--order by id
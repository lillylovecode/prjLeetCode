Create table #MyNumbers (num int)
Truncate table #MyNumbers

insert into #MyNumbers (num) values ('8')
insert into #MyNumbers (num) values ('8')
insert into #MyNumbers (num) values ('3')
insert into #MyNumbers (num) values ('3')
insert into #MyNumbers (num) values ('1')
insert into #MyNumbers (num) values ('4')
insert into #MyNumbers (num) values ('5')
insert into #MyNumbers (num) values ('6')

select coalesce(
(select top 1 num from #MyNumbers group by num having count(1)=1 order by num desc),
null) as num

--coalesce(null,null,'123') �i�H��J�h�ӰѼ�  �^�ǲĤ@�ӫDnull�Ѽ�
select coalesce(null,null,'123')

select isnull(
(select top 1 num from #MyNumbers group by num having count(1)=1 order by num desc),
null) as num

--isnull �u���J��ӰѼ�

--=================================

DECLARE @NUM INT;

Select top 1 @NUM = num from #MyNumbers 
group by num
having count(num) = 1
order by num desc
SELECT @NUM  num

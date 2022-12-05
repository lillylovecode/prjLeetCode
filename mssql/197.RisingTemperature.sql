use myTest

create table Weather(
	id int,
	recordDate date,
	temperature int
)

insert into Weather
values(1,'2015-01-01',10),
(2,'2015-01-02',25),
(3,'2015-01-03',20),
(4,'2015-01-04',30)

--v1
select b.id
from Weather a,Weather b
where DATEDIFF(DAY,a.recordDate, b.recordDate)=1 and a.temperature < b.temperature

--v2
select a.id
from Weather a join Weather b on a.recordDate = DATEADD( DAY,1,b.recordDate )
where a.temperature > b.temperature

Create Table #Insurance (pid int, tiv_2015 float, tiv_2016 float, lat float, lon float)
Truncate table #Insurance
insert into #Insurance (pid, tiv_2015, tiv_2016, lat, lon) values (1, 10, 5,  10, 10)
insert into #Insurance (pid, tiv_2015, tiv_2016, lat, lon) values (2, 20, 20, 20, 20)
insert into #Insurance (pid, tiv_2015, tiv_2016, lat, lon) values (3, 10, 30, 20, 20)
insert into #Insurance (pid, tiv_2015, tiv_2016, lat, lon) values (4, 10, 40, 40, 40)

--找tiv_2015有重複的
select tiv_2015
from #Insurance
group by tiv_2015
having COUNT(1)>1

SELECT COUNT(tiv_2015) OVER(PARTITION BY tiv_2015)
FROM #Insurance

--找經緯度is unique的
select lat,lon 
from #Insurance
group by lat,lon
having COUNT(1)<2

SELECT COUNT(lat) OVER(PARTITION BY lat,lon)
FROM #Insurance

--================================結果=================================
--法1 錯誤
SELECT ROUND(SUM(tiv_2016),2) AS tiv_2016
FROM #Insurance
WHERE lat IN (SELECT lat FROM #Insurance GROUP BY lat,lon HAVING COUNT(1)<2)
AND lon IN (SELECT lon FROM #Insurance GROUP BY lat,lon HAVING COUNT(1)<2)
AND tiv_2015 IN(SELECT tiv_2015 from #Insurance GROUP BY tiv_2015 HAVING COUNT(1)>1)

--法2 正確
select * --round(sum(TIV_2016),2) TIV_2016
from #Insurance a
where (select count(*) from #Insurance b where a.LAT=b.LAT and a.LON=b.LON) = 1
  and (select count(*) from #Insurance c where a.TIV_2015=c.TIV_2015) > 1

--法3 視窗函式 正確
SELECT ROUND(SUM(tiv_2016),2) AS tiv_2016
FROM
(SELECT *,
COUNT(tiv_2015) OVER(PARTITION BY tiv_2015) AS CNT1,
COUNT(lat) OVER(PARTITION BY lat,lon) AS CNT2
FROM #Insurance
) T
WHERE CNT1 >1 AND CNT2 =1


--Create table  #Activity (user_id int, session_id int, activity_date date, activity_type varchar(50))
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'open_session')
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'scroll_down')
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'end_session')
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-20', 'open_session')
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-21', 'send_message')
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-21', 'end_session')
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'open_session')
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'send_message')
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'end_session')
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('4', '3', '2019-06-25', 'open_session')
--insert into #Activity (user_id, session_id, activity_date, activity_type) values ('4', '3', '2019-06-25', 'end_session')



--select t.day,count(userCount) as active_users
--from 
--(
--    select activity_date as day,count(user_id) as userCount
--    from #Activity
--    where activity_date <= '2019-07-27' and activity_date > '2019-06-28'
--    group by activity_date,user_id
--)t
--group by t.day


select t.day,count(user_id) as active_users
from 
(
    select activity_date as day,user_id
    from #Activity
    where activity_date <= '2019-07-27' and activity_date >= '2019-06-28'
    group by activity_date,user_id
)t
group by t.day
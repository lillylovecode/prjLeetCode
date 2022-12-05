declare @Patients table (patient_id int,patient_name varchar(10),conditions  varchar(100))

insert @Patients values
(1,'Daniel','YFEV COUGH'),
(2,'Alice',''),
(3,'Bob','DIAB100 MYOP'),
(4,'Gerge','ACNE DIAB100'),
(5,'Alain','DIAB201')

--select * from @Patients


select * from @Patients
where conditions like '% DIAB1%'
or conditions like 'DIAB1%'
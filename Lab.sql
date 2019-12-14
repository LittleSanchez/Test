--create database RickHospital
--use RickHospital

--create table Departments(
--	DepartmentId int primary key identity,
--	Building int not null,
--	Financing money not null default 0,
--	[DepartmentName] nvarchar(100) not null unique, 
	
	
--	check(building between 1 and 5 and Financing >= 0)

--)

--create table Diseases(
--	DiseaseId int primary key identity,
--	[DiseaseName] nvarchar(100) not null unique
--)

--create table Doctors(
--	DoctorId int primary key identity ,
--	[DoctorName] nvarchar(max) not null,
--	Salary money not null ,
--	DoctorSurname nvarchar(max) not null,

--	check(Salary > 0)

--)

--create table Examinations(
--	ExamId int primary key identity,
--	ExamName nvarchar(100) not null unique
--)

--create table Inters(
--	InterId int primary key identity,
--	DoctorId int not null foreign key references Doctors(DoctorId),
--)

--create table Professors(
--	ProfessorId int primary key identity,
--	DoctorId int not null foreign key references Doctors(DoctorId)
--)
--create table Wards(
--	WardId int primary key identity,
--	WardName nvarchar(20) not null unique,
--	Places int,
--)

--create table DoctorsExaminations(
--	DoctorExamId int primary key identity,
--	[Date] date not null default Getdate(),
--	DiseaseId int foreign key references Diseases(DiseaseId),
--	DoctorId int foreign key references Doctors(DoctorId),
--	ExamId int foreign key references Examinations(ExamId),
--	WardId int foreign key references Wards(WardId),
--	check ([Date] <= Getdate())
--)

--insert into Doctors values
--('Doctor Stephen', 100000, 'Strange'),
--('Doctor', 10000, 'House'),
--('Doctor', 12000, 'Who'),
--('Doctor', 19000, 'Web')
--('Andriy', 5000, 'Bykov'),
--('Semen', 3000, 'Lobanov')
--('Professor', 5, 'X')

--insert into Inters values
--(5), (6)

--insert into Professors values
--(1),
--(7)

--insert into Departments values
--(1, 15000, 'London'),
--(1, 15000, 'Paris'),
--(2, 0, 'Kiev')

--insert into Diseases values
--('Ischemic heart disease'),
--('Stroke'),
--('Lower respiratory infections'),
--('Chronic obstructive pulmonary disease'),
--('Trachea, bronchus, and lung cancers'),
--('Diabetes mellitus')

--insert into Examinations values
--('General'),
--('Resp or "Chest"'),
--('CV or "Heart"'),
--('Abd'),
--('Ext'),
--('Neuro')

--insert into Wards values
--('VIP-ward', 1),
--('non-VIP-ward', 2),
--('Simple', 3),
--('Luxe', 4),
--('Business', 5),
--('Personal only', 6)

--insert into DoctorsExaminations values
--(Getdate(), 3, 7, 1, 3),
--('1989-12-11', 2, 1, 3, 6),
--('2019-07-08', 4, 6, 6, 4)

--alter table Wards
--add DepartmentId int foreign key references Departments(DepartmentId)

select w.[WardName], w.[Places] 
from Wards as w
where w.DepartmentId = 2 and w.Places >= 5 and 15 < ANY(select Places 
														from Wards 
														where DepartmentId = 2
)

select d.DepartmentName 
from Departments as d 
join Wards as w on d.DepartmentId = w.DepartmentId 
join DoctorsExaminations as de on w.WardId = de.WardId
where DATEADD(DD, -7, GETDATE()) < ANY(	select [date] 
										from DoctorsExaminations as de2 
										where de2.WardId = w.WardId and w.DepartmentId = d.DepartmentId)

select dis.DiseaseName
from Diseases as dis left join DoctorsExaminations as de
on dis.DiseaseId = de.DiseaseId
where dis.DiseaseId not in (select DiseaseId from DoctorsExaminations)

select doc.DoctorName + ' ' + doc.DoctorSurname as 'Full Name'
from Doctors as doc left join DoctorsExaminations as de
on doc.DoctorId = de.DoctorId
where doc.DoctorId not in (	select DoctorId 
							from DoctorsExaminations)

select d.DepartmentName
from Departments as d left join Wards as w 
on d.DepartmentId = w.DepartmentId
left join DoctorsExaminations as de on de.WardId = w.WardId
where d.DepartmentId not in (select w.DepartmentId 
							from Wards as w 
							join DoctorsExaminations as de
							on de.WardId = w.WardId)


select doc.DoctorSurname
from Doctors as doc join Inters as i 
on doc.DoctorId = i.DoctorId

select doc.DoctorSurname
from Doctors as doc join Inters as i
on doc.DoctorId = i.DoctorId
where doc.Salary > ANY(	select Salary 
						from Doctors
						where DoctorId not in (select DoctorID from Inters)
)
select *
from Wards
go
select w.WardName
from Wards as w join Departments as d on w.DepartmentId = d.DepartmentId
where w.Places > ALL(select Places from Wards where DepartmentId = 1)



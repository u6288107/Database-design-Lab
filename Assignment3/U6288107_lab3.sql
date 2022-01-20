/* Assignment 1 Solutions */
 
IF EXISTS
( select * from sys.databases where name='ICTTutorial'
)
 BEGIN
   PRINT 'Database ICTTutorial already exists.';
   Use Master;					-- Swap database in order to drop myFriends
   DROP DATABASE ICTTutorial;
   PRINT 'Then, it was firstly deleted.';
 END;
  
-- Create Database 
CREATE Database ICTTutorial; 
GO
Use ICTTutorial;
GO

CREATE TABLE Student
(
StudentID NCHAR(8) NOT NULL,
FirstName NVARCHAR(50) ,
LastName NVARCHAR(50),
[Address] NVARCHAR(100),
Birthdate date,
EMail NVARCHAR(50),
Phone NVARCHAR(20),
UserID NVARCHAR(50),
[Password] NVARCHAR(50),
Primary Key (StudentID)
);

CREATE TABLE Instructor
(
InstructorID NCHAR(5)NOT NULL,
FirstName NVARCHAR(50) ,
LastName NVARCHAR(50),
[Address] NVARCHAR(100),
Birthdate date,
EMail NVARCHAR(50),
Phone NVARCHAR(50),
UserID NVARCHAR(50),
[Password] NVARCHAR(50),
Primary Key (InstructorID)
);

CREATE TABLE Course
(
CourseID NCHAR(5) NOT NULL,
InstructorID NCHAR(5),
CourseName NVARCHAR(50),
CourseAmount Money,
Primary Key (CourseID),
FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID),
);

CREATE TABLE EnrollCourse
(
StudentID NCHAR(8),
CourseID NCHAR(5),
FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


CREATE TABLE [Transaction]
(
TransactionID NCHAR(5) Not null Primary Key,
Amount Money
);

CREATE TABLE Payment
(
StudentID NCHAR(8),
TransactionID NCHAR(5),
PRIMARY KEY (StudentID),
FOREIGN KEY (TransactionID) REFERENCES [Transaction](TransactionID),
FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);
 

CREATE TABLE ExamScore
(
ExamID NCHAR(5) Not Null,
Score Int,
Primary Key (ExamID)
);

CREATE TABLE PracticeExam
(
StudentID NCHAR(8),
ExamID NCHAR(5),
FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
FOREIGN KEY (ExamID) REFERENCES ExamScore(ExamID)
);

CREATE TABLE ELearningVDO
(
CourseID NCHAR(5),
Lesson NVARCHAR(50),
Details NVARCHAR(50),
FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE BookStocking
(
BookID NCHAR(5) Not Null,
CourseID NCHAR(5),
BookName NVARCHAR(50),
Author NVARCHAR(50),
Remaining Int, 
Price MOney,
Primary Key (BookID),
FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

use ICTTutorial;

insert into student values('u0001','Sukit','Lertsuk','154/2 Soi Rang-nam', '1997-08-04','sukit@hotmail.com','mobile:0932133484','sukit.ler','sk9dkc');
insert into student values('u0002','Chatree','Meekerd','254 Salaya', '2001-01-14','chatree@gmail.com','mobile:0852354821','chatree','28dc8ds');
insert into student values('u0003','Chujai','Sae-Tung','124/225 Klongluang', '1999-06-21','chujai@gmail.com','mobile:0825212410','chujai','15d8ds5');
  

insert into instructor values('i1001','Nikorn','Sawanglap','1125 Bangkae', '1975-08-29','nikorn@hotmail.com','mobile:0932322343;office:023932323','nikorn','285d8d2');
insert into instructor values('i1002','Nongkran','Poonpol','45/4523 Lamlookka', '1971-02-19','nongkran@hotmail.com','mobile:0852314043;office:021872421','nongkran','45d28ds');
insert into instructor values('i1003','Chokchai','Sakooldee','515 Moo2 Bangkontee', '1984-09-09','chokchai@hotmail.com','mobile:0959323353;office:023251582','chokchai','d3dd8da2');
  
insert into course values('ICT01','i1001','Introduction to Database', 50000);
insert into course values('ICT02','i1002','Expert System', 75000);
insert into course values('ICT03','i1003','Computational Thinking', 35000);
 
insert into elearningvdo values('ICT01','Background','All about database');
insert into elearningvdo values('ICT01','Business Environment','Introduction to current business environment');
insert into elearningvdo values('ICT02','Artificial Intelligence in Real world','Introduction to AI in real world');

insert into enrollcourse values ('u0001','ICT01');
insert into enrollcourse values ('u0001','ICT02');
insert into enrollcourse values ('u0002','ICT01');
insert into enrollcourse values ('u0003','ICT02');

insert into examscore values ('es001',85);
insert into examscore values ('es002',95);
insert into examscore values ('es003',65);
insert into examscore values ('es004',85);

insert into practiceexam values('u0001','es001');
insert into practiceexam values('u0001','es002');
insert into practiceexam values('u0002','es003');
insert into practiceexam values('u0003','es003');

insert into [transaction] values ('t0001',50000);
insert into [transaction] values ('t0002',65000);
insert into [transaction] values ('t0003',80000);


insert into payment values ('u0001','t0001');
insert into payment values ('u0002','t0002');
insert into payment values ('u0003','t0003');
 
 
insert into bookstocking values ('B001','ICT01','DBMS in action','M.J.Fox',39,1240);
insert into bookstocking values ('B002','ICT01','Database Design','Peter Gilbert',78, 1850);
insert into bookstocking values ('B003','ICT02','Expert System Design','J.Joe',64, 950); 

--Inclass Assignment
--1
Use ICTTutorial;
SELECT StudentID, FirstName, LastName, UserID, Year(getdate())-Year(Birthdate) as age
from Student
where Email Like '%hotmail%'
--2
Use ICTTutorial;
SELECT FirstName + ' ' + LastName as [Name], Year(getdate())-Year(Birthdate) as age
from Student
where Year(getdate())-Year(Birthdate) > 20
go
--3
Use ICTTutorial;
SELECT s.FirstName + ' ' + s.LastName as [Name], s.Email, s.Phone
From Student s LEFT JOIN Payment p
on s.StudentID = p.StudentID
where p.TransactionID = NULL
--4
Use ICTTutorial;
SELECT s.StudentID, p.ExamID, s.FirstName + ' ' + s.LastName as [Name], e.Score
From Student s LEFT JOIN PracticeExam p
on s.StudentID = p.StudentID
LEFT JOIN ExamScore e
on p.ExamID = e.ExamID
--5
Use ICTTutorial;
SELECT s.FirstName + ' ' + s.LastName as [Name], e.Score
From Student s LEFT JOIN PracticeExam p
on s.StudentID = p.StudentID
LEFT JOIN ExamScore e
on p.ExamID = e.ExamID
where e.Score = (Select Max(Score) as Max_Score From ExamScore)
--6
Use ICTTutorial;
SELECT i.FirstName + ' ' + i.LastName as [Name]
From Instructor i LEFT JOIN Course c
on i.InstructorID = c.InstructorID
where c.CourseAmount = (Select Max(CourseAmount) From Course)
--7
Use ICTTutorial;
SELECT TOP 5 s.FirstName + ' ' + s.LastName as [Name]
From Student s LEFT JOIN EnrollCourse e
on s.StudentID = e.StudentID
LEFT JOIN Course c
on c.CourseID = e.CourseID
Order by CourseAmount DESC
--8
Use ICTTutorial;
SELECT *
From Course c LEFT JOIN ELearningVDO e
on c.CourseID = e.CourseID
where e.CourseID is NULL
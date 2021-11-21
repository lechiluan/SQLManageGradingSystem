--Create database
create database Student_Grading_System

use Student_Grading_System

--Create table
Create table Major
(
	MajorID Char(10) Primary key,
	MajorName Varchar(50) not null
)

Create table Class
(
	ClassID Char(10) Primary key,
	ClassName Varchar(50) not null,
	MajorID Char(10) Foreign key references Major(MajorId) NOT NULL
)

Create table Student
(
	StudentID Char(10) primary key,
	FullName Varchar(50) not null,
	ClassID Char(10) Foreign key references Class(ClassID) not null,
	DateOfBirth Date Not null,
	Gender Varchar(10) NOT NULL check(Gender='Female' or Gender='Male'),
	Address Varchar(150),
	Email Varchar(50) unique,
	Phone varchar(10) unique
)

Create table Teacher
(
	TeacherID Char(10) primary key,
	TeacherName Varchar(50) not null,
	Email Varchar(50) Unique,
	Phone varchar(10) unique
)

Create table Subject 
(
	SubjectID char(10) primary key,
	SubjectName Varchar(50) NOT NULL,
	Theory int check(Theory > 0),
	Lab int check(Lab > 0)
)

create table Exammarks 
(
	StudentID Char(10) Foreign key references Student(StudentID),
	SubjectID Char(10) Foreign key references Subject(SubjectID),
	TeacherID Char(10) Foreign key references Teacher(TeacherID) NOT NULL,
	ExamDate Date Not Null,
	Mark float check (Mark >=0 and Mark <= 10) default 0,
	Primary key (StudentID, SubjectID, ExamDate)
)


--Insert data into database
--Insert data into Major table
insert into Major values ('IT01','Information Technology')
insert into Major values ('GD01','Graphic Design')
insert into Major values ('BA01','Business Administration')
insert into Major values ('EA01','Event Administration')

--Insert data into Class table
insert into Class values ('C01','Class IT','IT01')
insert into Class values ('C02','Class GD','GD01')
insert into Class values ('C03','Class BA','BA01')
insert into Class values ('C04','Class EA','EA01')


--Insert data into Student table
insert into Student values ('SV01','Le Chi Luan','C01','06/06/2001','Male','Cai Lay, Tien Giang','luanlcgcc19023@fpt.edu.vn','0386363677')
insert into Student values ('SV02','Nguyen Ngoc Nhan','C01','09/12/2001','Female','Cai Rang, Can Tho City','ngocnngcc19209@fpt.edu.vn','0325632896')
insert into Student values ('SV03','Le Trung Kien','C02','12/01/2001','Male','Phu My, Hau Giang','kienltgcc19056@fpt.edu.vn','0921365232')
insert into Student values ('SV04','Tran Nhat Khanh','C03','06/05/2001','Male','Ninh Kieu, Can Tho City','khanhtngcc19085@fpt.edu.vn','0999523632')
insert into Student values ('SV05','Luu Hoai Phong','C04','12/27/2001','Male','Tan Binh, HCM City','phonglhgcc19022@fpt.edu.vn','0836523363')
insert into Student values ('SV06','Nguyen Huynh Khang','C01','01/29/2001','Male','Thu Duc, HCM City','khangnhgcc19089@fpt.edu.vn','0352632133')
insert into Student values ('SV07','Nguyen Ngoc Tien','C02','01/19/2001','Female','My Tho, Tien Giang','tiennngcc19078@fpt.edu.vn','0365363698')
insert into Student values ('SV08','Tran Minh Thien','C03','03/05/2001','Male','Ninh Kieu, Can Tho City','thientmgcc19020@fpt.edu.vn','0966653131')
insert into Student values ('SV09','Luu Huu Phuoc','C01','04/30/2001','Male','Quan 1, HCM City','phuoclhgcc19001@fpt.edu.vn','0385695522')
insert into Student values ('SV10','Ly Trong Thang','C04','05/01/2001','Male','Cai Lay, Tien Giang','thangltcgcc19046@fpt.edu.vn','0888855565')

--Insert data into Teacher table
insert into Teacher values ('TC01','Nguyen Hung Dung','dungnh01@fpt.edu.vn','0901020304')
insert into Teacher values ('TC02','Vo Hoang Yen','yenvh02@fpt.edu.vn','0355558522')
insert into Teacher values ('TC03','Nguyen Thi Lan','lannt03@fpt.edu.vn','0389636444')
insert into Teacher values ('TC04','Le Quang Trung','trunglq04@fpt.edu.vn','0318398552')

--Insert data into Subject table
insert into Subject values ('1618','Programming','20','20')
insert into Subject values ('1619','Networking','30','10')
insert into Subject values ('1620','Professional Practice','15','25')
insert into Subject values ('1621','Business and Business Environment','20','20')
insert into Subject values ('1622','Database Design & Development','30','10')

--Insert data into Exammark table
insert into Exammarks values ('SV01','1622','TC01','02/08/2020','10')
insert into Exammarks values ('SV01','1619','TC02','01/20/2021','9')
insert into Exammarks values ('SV02','1618','TC03','10/17/2020','8')
insert into Exammarks values ('SV03','1620','TC04','12/16/2020','0')
insert into Exammarks values ('SV04','1621','TC01','02/12/2021','5')
insert into Exammarks values ('SV05','1619','TC02','12/06/2020','4')
insert into Exammarks values ('SV06','1618','TC03','11/07/2020','9')
insert into Exammarks values ('SV10','1621','TC01','03/09/2021','7')
insert into Exammarks values ('SV08','1620','TC04','03/23/2021','6')
insert into Exammarks values ('SV09','1622','TC01','03/08/2021','2')


--LOGIN
Create PROC Login
    (@Email VARCHAR(50),
    @Password VARCHAR(50))
AS
BEGIN
	Declare @ReturnValue INT
    IF EXISTS (Select * From Teacher Where Email=@Email and Phone = @Password)
        BEGIN
            SET @ReturnValue = 1
        END
    ELSE IF EXISTS (Select * From Student Where Email=@Email and Phone = @Password)
        BEGIN
            SET @ReturnValue = 2
        END
    ELSE IF (@Email ='' or @Email is null or @Password ='' or @Password is Null)
		BEGIN
            SET @ReturnValue = 3
        END
	ELSE IF NOT EXISTS (Select * From Teacher Where Email=@Email or Phone=@Password)
        BEGIN
            SET @ReturnValue = 4
        END
	ELSE IF NOT EXISTS (Select * From Student Where Email=@Email or Phone=@Password)
		 BEGIN
            SET @ReturnValue = 5
        END
	IF (@ReturnValue=1)
		begin
			Print 'Login is successfully. You are teacher'
		end
	ELSE IF (@ReturnValue=2)
		begin
			Print 'Login is successfully. You are student'
		end
	ELSE IF (@ReturnValue = 4 or @ReturnValue = 5 )
		begin
			Print 'Username or password is incorrect. Please, Enter again'
		end
	ELSE 
		begin
			Print 'Username or password is not null or space. Please, Enter again'
		end
END

exec login 'luanlcgcc19023@fpt.edu.vn','0386363677'
exec login 'dungnh01@fpt.edu.vn','0901020304'
exec login 'abc','abc'
exec login '',''


--Search Mark for Student.
create PROC Search_Mark
(@StudentID CHAR(10), @SubjectID CHAR(10), @Examdate DATE)
AS		
BEGIN
	SELECT S.StudentID, S.FullName, S.ClassID, E.SubjectID, Su.SubjectName, E.TeacherID, ExamDate, E.Mark
	from Exammarks as E,Student as S, Subject as Su
	Where E.StudentID=S.StudentID and E.SubjectID=Su.SubjectID and E.StudentID = @StudentID and E.SubjectID = @SubjectID and Examdate = @Examdate 
	IF (@@ROWCOUNT = 0 or @@ERROR <>0)
		BEGIN
			PRINT 'No data found. Please enter correct information'
		END
END

--TEST CASE
EXEC Search_Mark 'SV01','1622','2020-02-08'
EXEC Search_Mark 'SV50','1652','2020-02-08'
EXEC Search_Mark '','',''


--Tab Student
--Button Search Student
CREATE PROC Search_Student(@Data_search nvarchar(100))
AS
BEGIN
IF(@Data_search='' or @Data_search is null)
	BEGIN
		PRINT 'Data is not null or space'
	END
ELSE
	BEGIN
	SELECT * FROM Student WHERE StudentID like '%'+@Data_search+'%' 
	or Fullname like '%'+@Data_search+'%' 
	or ClassID like '%'+@Data_search+'%' 
	or DateOfBirth like '%'+@Data_search+'%' 
	or Gender like '%'+@Data_search+'%' 
	or Address like '%'+@Data_search+'%' 
	or Email like '%'+@Data_search+'%' 
	or Phone like '%'+@Data_search+'%'
	END
IF @@ROWCOUNT = 0 or @@ERROR <> 0
	BEGIN
		PRINT 'No data found. Please enter correct information'
	END
END

EXEC Search_Student 'HCM'
EXEC Search_Student 'SV50'
EXEC Search_Student ''
EXEC Search_Student ' '


--Button Save ( Insert data into Student table)
Create proc Insert_Into_Student
(@StudentID Char(10),
@FullName Varchar(50),
@ClassID Char(10),
@DateOfBirth Date,
@Gender Varchar(10),
@Address Varchar(150),
@Email Varchar(50),
@Phone varchar(10))
AS
BEGIN
IF EXISTS(Select * from Student where @StudentID=StudentID or @Phone=Phone or @Email=Email) 
	begin
		Print'Data is already exists. Please enter other data' 
	end
Else if (@StudentID ='' or @StudentID is null or @FullName ='' or @FullName is null or @ClassID ='' or @ClassID is null or @Gender ='' or @Gender is null
or @DateOfBirth ='' or @DateOfBirth is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF (@DateOfBirth > GETDATE())
	begin
		Print'Date of Brith must be less than current day'
	end
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Insert into Student(StudentID,FullName,ClassID,DateOfBirth,Gender,Address,Email,Phone)
		values (@StudentID,@FullName,@ClassID,@DateOfBirth,@Gender,@Address,@Email,@Phone)
	end	
END

--TEST CASE

exec Insert_Into_Student 'SV11','Lam Chi','C04','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'

exec Insert_Into_Student 'SV10','Lam Chi','C04','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Insert_Into_Student 'SV11','Lam Chi','C04','01/01/2001','Male','Cai Lay, Tien Giang','luanlcgcc19023@fpt.edu.vn','0362525880'
exec Insert_Into_Student 'SV11','Lam Chi Khang','C09','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Insert_Into_Student 'SV11','Lam Chi','C04','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0386363677'
exec Insert_Into_Student 'SV11','Lam Chi','C04','09/09/2021','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Insert_Into_Student '','Lam Chi','C04','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Insert_Into_Student 'SV11','','C04','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Insert_Into_Student 'SV11','Lam Chi','','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Insert_Into_Student 'SV11','Lam Chi','C04','','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Insert_Into_Student 'SV11','Lam Chi','C04','01/01/2001','','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'



--Button Edit(Update) Student
Create proc Update_Student 
(@StudentID Char(10),
@FullName Varchar(50),
@ClassID Char(10),
@DateOfBirth Date,
@Gender Varchar(10),
@Address Varchar(150),
@Email Varchar(50),
@Phone varchar(10))
AS
BEGIN
IF NOT EXISTS(Select * from Student where @StudentID=StudentID)
	begin
		Print'Data is  not already exists. Please enter other data' 
	end
ELSE IF EXISTS(Select * from Student where @StudentID<>StudentID and (@Email = Email or @Phone=Phone))
	begin
		Print'Date is already exists. Please enter other data' 
	end
ELSE IF (@StudentID ='' or @StudentID is null or @FullName ='' or @FullName is null or @ClassID ='' or @ClassID is null or @Gender ='' or @Gender is null
or @DateOfBirth ='' or @DateOfBirth is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF (@DateOfBirth > GETDATE())
	begin
		Print'Date of Brith must be less than current day'
	end
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Update Student 
		Set 
			FullName = @FullName,
			ClassID = @ClassID,
			DateOfBirth = @DateOfBirth,
			Gender = @Gender,
			Address = @Address,
			Email = @Email,
			Phone = @Phone
		Where StudentID = @StudentID
	end	
END


exec Update_Student 'SV11','Lam Chi Khang','C04','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Update_Student 'SV20','Lam Chi Khang','C04','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'

exec Update_Student 'SV11','Lam Chi Khang','C09','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Update_Student 'SV11','Lam Chi Khang','C04','09/09/2021','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Update_Student 'SV11','Lam Chi Khang','C04','01/01/2001','Male','Cai Lay, Tien Giang','luanlcgcc19023@fpt.edu.vn','0362525880'
exec Update_Student 'SV11','Lam Chi Khang','C04','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0386363677'
exec Update_Student '','Lam Chi Khang','C04','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Update_Student 'SV11','','C04','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Update_Student 'SV11','Lam Chi Khang','','01/01/2001','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Update_Student 'SV11','Lam Chi Khang','C04','','Male','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'
exec Update_Student 'SV11','Lam Chi Khang','C04','01/01/2001','','Cai Lay, Tien Giang','khanglcgcc19553@fpt.edu.vn','0362525880'


--Button Delete Student
Create TRIGGER Delete_Student
ON Student
INSTEAD OF DELETE
AS
Begin
	delete from Exammarks where StudentID in (select StudentID from deleted)
	delete from Student where StudentID in (select StudentID from deleted)	
End

Delete from Student where StudentID= 'SV11' 


--Statistical Male 
create proc Male_Student
@return int output
AS
Select * From Student Where Gender='Male'
select @return = count(*) From Student Where Gender='Male'

declare @return int
exec Male_Student @return output
print 'Number of student:' + convert(varchar(5),@return)

--Statistical Female 
Create proc Female_Student
@return int output
AS
Select * From Student Where Gender='Female'
select @return = count(*) From Student Where Gender='Female'

declare @return int
exec Female_Student @return output
print 'Number of student:' + convert(varchar(5),@return)






--Tab Teacher
--Button Search Teacher
CREATE PROC Search_Teacher(@Data_search nvarchar(100))
AS
IF(@Data_search='' or @Data_search is null)
	BEGIN
		PRINT 'Data is not null or space'
	END
ELSE
BEGIN
SELECT * FROM Teacher WHERE TeacherID like '%'+@Data_search+'%' 
or TeacherName like '%'+@Data_search+'%' 
or Email like '%'+@Data_search+'%' 
or Phone like '%'+@Data_search+'%'
END
IF (@@ROWCOUNT = 0 or @@ERROR <> 0)
	BEGIN
		PRINT 'No data found. Please enter correct information'
	END

EXEC Search_Teacher 'TC01'
EXEC Search_Teacher 'TC10'
EXEC Search_Teacher ''
EXEC Search_Teacher '    ' 

--Button Save Insert Teacher
select * from Teacher
Create proc Insert_Into_Teacher
(@TeacherID char(10),
@TeacherName Varchar(50),
@Email Varchar(50),
@Phone varchar(10))
AS
BEGIN
IF EXISTS(Select * from Teacher where @TeacherID=TeacherID or @Phone=Phone or @Email=Email) 
	begin
		Print'Data is already exists. Please enter other data' 
	end
Else if (@TeacherID ='' or @TeacherID is null or @TeacherName ='' or @TeacherName is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Insert into Teacher(TeacherID,TeacherName,Email,Phone)
		values (@TeacherID,@TeacherName,@Email,@Phone)
	end	
END

select * from Teacher where TeacherID='TC05'
--TEST CASE
EXEC Insert_Into_Teacher 'TC05','Nguyen Hung Manh','manhnh@fpt.edu.vn','0325698365'
EXEC Insert_Into_Teacher 'TC04','Nguyen Hung Manh','manhnh@fpt.edu.vn','0325698365'
EXEC Insert_Into_Teacher 'TC05','Nguyen Hung Manh','dungnh01@fpt.edu.vn','0325698365'
EXEC Insert_Into_Teacher 'TC05','Nguyen Hung Manh','manhnh@fpt.edu.vn','0901020304'
EXEC Insert_Into_Teacher '','Nguyen Hung Manh','manhnh@fpt.edu.vn','0325698365'
EXEC Insert_Into_Teacher 'TC05','','manhnh@fpt.edu.vn','0325698365'

--Update teacher
Create proc Update_Teacher
(@TeacherID char(10),
@TeacherName Varchar(50),
@Email Varchar(50),
@Phone varchar(10))
AS
BEGIN
IF NOT EXISTS(Select * from Teacher where @TeacherID=TeacherID)
	begin
		Print'Teacher ID is not already exists. Please enter other data' 
	end
ELSE IF EXISTS(Select * from Teacher where @TeacherID <> TeacherID and (@Email = Email or @Phone = Phone))
	begin
		Print'Data is already exists. Please enter other data' 
	end
Else if (@TeacherID ='' or @TeacherID is null or @TeacherName ='' or @TeacherName is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Update Teacher 
		Set 
		TeacherName = @TeacherName,
		Email = @Email,
		Phone = @Phone
		Where TeacherID=@TeacherID		
	end	
END

--TEST CASE
EXEC Update_Teacher 'TC05','Le Hung Manh','manhnh@fpt.edu.vn','0325698365'

EXEC Update_Teacher 'TC09','Le Hung Manh','manhnh@fpt.edu.vn','0325698365'
EXEC Update_Teacher 'TC05','Le Hung Manh','dungnh01@fpt.edu.vn','0325698365'
EXEC Update_Teacher 'TC05','Le Hung Manh','manhnh@fpt.edu.vn','0901020304'
EXEC Update_Teacher '','Nguyen Hung Manh','manhnh@fpt.edu.vn','0325698365'
EXEC Update_Teacher 'TC05','','manhnh@fpt.edu.vn','0325698365'

--Delete Teacher table
Create TRIGGER Delete_Teacher
ON Teacher
INSTEAD OF DELETE
AS
Begin
		delete from Exammarks where TeacherID in (select TeacherID from deleted)
		delete from Teacher where TeacherID in (select TeacherID from deleted)	
end

Delete from Teacher where TeacherID= 'TC05'


--Tab Class
--Button Search Class
CREATE PROC Search_Class(@Data_search nvarchar(100))
AS
IF(@Data_search='' or @Data_search is null)
	BEGIN
		PRINT 'Data is not null or space'
	END
ELSE
BEGIN
SELECT * FROM Class WHERE ClassID like '%'+@Data_search+'%' 
or ClassName like '%'+@Data_search+'%' 
or MajorID like '%'+@Data_search+'%' 
END
IF @@ROWCOUNT = 0 or @@ERROR =1
BEGIN
	PRINT 'No data found. Please enter correct information'
END

--TEST CASE
EXEC Search_Class 'C01'
EXEC Search_Class 'abc'
EXEC Search_Class ''
EXEC Search_Class '    '

--button save insert Class
Create proc Insert_Into_Class
(@ClassID Char(10),
@ClassName Varchar(50),
@MarjorID Char(10))
AS
BEGIN
IF EXISTS(Select * from Class where @ClassID=ClassID) 
	begin
		Print'Data is already exists. Please enter other data' 
	end
Else if (@ClassID ='' or @ClassID is null or @ClassName ='' or @ClassName is null or @MarjorID ='' or @MarjorID is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Insert into Class(ClassID,ClassName,MajorID)
		values (@ClassID,@ClassName,@MarjorID)
	end	
END

--TEST CASE
EXEC Insert_Into_Class 'C05','Class ABC','IT01'
EXEC Insert_Into_Class 'C05','Class ABC','IT11'
EXEC Insert_Into_Class 'C04','Class ABC','IT01'
EXEC Insert_Into_Class '','Class ABC','IT01'
EXEC Insert_Into_Class 'C05','','IT01'
EXEC Insert_Into_Class 'C05','Class ABC',''

--Update Class
Create proc Update_Class
(@ClassID Char(10),
@ClassName Varchar(50),
@MarjorID Char(10))
AS
BEGIN
IF NOT EXISTS(Select * from Class where @ClassID=ClassID)
	begin
		Print'Class ID is not already exists. Please enter other data' 
	end
Else if (@ClassID ='' or @ClassID is null or @ClassName ='' or @ClassName is null or @MarjorID ='' or @MarjorID is null )
	Begin
		print'Data is not null or space'
	end
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Update Class
		Set 
		ClassName = @ClassName,
		MajorID=@MarjorID
		Where ClassID=@ClassID
	end	
END

--TEST CASE
EXEC Update_Class 'C05','Class IT-1','IT01'
EXEC Update_Class 'C05','Class ABC','IT11'
EXEC Update_Class 'C08','Class IT-1','IT01'
EXEC Update_Class '','Class IT-1','IT01'
EXEC Update_Class 'C05','','IT01'
EXEC Update_Class 'C05','Class IT-1',''

--Delete Class table
Create TRIGGER Delete_Class
ON Class
INSTEAD OF DELETE
AS
Begin
	delete from Student where ClassID in (select ClassID from deleted)
	delete from Class where ClassID in (select ClassID from deleted)	
END

Delete from Class where ClassID= 'C05'

--Tab Major
--Button Search Major
CREATE PROC Search_Major (@Data_search nvarchar(100))
AS
IF(@Data_search='' or @Data_search is null)
	BEGIN
		PRINT 'Data is not null or space'
	END
ELSE
BEGIN
SELECT * FROM Major WHERE MajorID like '%'+@Data_search+'%' 
or MajorName like '%'+@Data_search+'%' 
END
IF @@ROWCOUNT = 0 or @@ERROR <>0
	BEGIN
		PRINT 'No data found. Please enter correct information'
	END

--TEST CASE
EXEC Search_Major 'IT01'
EXEC Search_Major 'abc'
EXEC Search_Major ''
EXEC Search_Major '     '

--button Save Insert major
Create proc Insert_Into_Major
(@MajorID Char(10),
@MajorName Varchar(50))
AS
BEGIN
IF EXISTS(Select * from Major where @MajorID=MajorID) 
	begin
		Print'Data is already exists. Please enter other data' 
	end
Else if (@MajorID ='' or @MajorID is null or @MajorName ='' or @MajorName is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Insert into Major(MajorID,MajorName)
		values (@MajorID,@MajorName)
	end	
END

--TEST CASE
EXEC Insert_Into_Major 'MA01','Marketing Administration'
EXEC Insert_Into_Major 'IT01','Information Technology'
EXEC Insert_Into_Major '','Marketing Administration'
EXEC Insert_Into_Major 'MA01',''


--Update Major
Create proc Update_Major
(@MarjorID Char(10),
@MajorName Varchar(50))
AS
BEGIN
IF NOT EXISTS(Select * from Major where @MarjorID=MajorID)
	begin
		Print'Major ID is not already exists. Please enter other data' 
	end
Else if (@MarjorID ='' or @MarjorID is null or @MajorName ='' or @MajorName is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Update Major
		Set 
		MajorName = @MajorName
		Where MajorID=@MarjorID
	end	
END

--TEST CASE
EXEC Update_Major 'MA01','Marketing Admin'
EXEC Update_Major 'MA02','Marketing Admin'
EXEC Update_Major '','Marketing Admin'
EXEC Update_Major 'MA01',''


--Delete Major
Create TRIGGER Delete_Major
ON Major
INSTEAD OF DELETE
AS
	Begin
		delete from Class where MajorID in (select MajorID from deleted)
		delete from Major where MajorID in (select MajorID from deleted)	
	end

Delete from Major where MajorID= 'MA01'








--Tab Subject
--Button Search Subject
CREATE PROC Search_Subject (@Data_search nvarchar(100))
AS
IF(@Data_search='' or @Data_search is null)
	BEGIN
		PRINT 'Data is not null or space'
	END
ELSE
BEGIN
SELECT * FROM Subject WHERE SubjectID like '%'+@Data_search+'%' 
or SubjectName like '%'+@Data_search+'%' 
or Theory like '%'+@Data_search+'%' 
or Lab like '%'+@Data_search+'%' 
END
IF @@ROWCOUNT = 0 or @@ERROR <>0
	BEGIN
		PRINT 'No data found. Please enter correct information'
	END

--TEST CASE
EXEC Search_Subject 'Programming'
EXEC Search_Subject 'abc'
EXEC Search_Subject ''
EXEC Search_Subject '   '

--Insert Subject
Create proc Insert_Into_Subject
(@SubjectID Char(10),
@SubjectName Varchar(50),
@Theory int,
@Lab int)
AS
BEGIN
IF EXISTS(Select * from Subject where @SubjectID=SubjectID) 
	begin
		Print'Subject ID is already exists. Please enter other data' 
	End
Else if (@SubjectID ='' or @SubjectID is null or @SubjectName ='' or @SubjectName is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF (@Theory < 0 or @Lab < 0)
	Begin
		print 'Theory or Lab must be greater than 0'
	End
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Insert into Subject(SubjectID,SubjectName,Theory,Lab)
		values (@SubjectID,@SubjectName,@Theory,@Lab)
	end	
END


--TEST CASE
EXEC Insert_Into_Subject '1623','Hacking','20','20'
EXEC Insert_Into_Subject '1623','Hacking','abc','10'
EXEC Insert_Into_Subject '1623','Hacking','30','abc'
EXEC Insert_Into_Subject '1622','Hacking','0.5','20'
EXEC Insert_Into_Subject '1622','Hacking','20','0.5'
EXEC Insert_Into_Subject '1622','Hacking','20','20'
EXEC Insert_Into_Subject '','Hacking','20','20'
EXEC Insert_Into_Subject '1623','','20','20'
EXEC Insert_Into_Subject '1623','Hacking','-5','20'
EXEC Insert_Into_Subject '1623','hacking','20','-5'


--Update Subject
Create proc Update_Subject
(@SubjectID Char(10),
@SubjectName Varchar(50),
@Theory int,
@Lab int)
AS
BEGIN
IF NOT EXISTS(Select * from Subject where @SubjectID=SubjectID)
	begin
		Print'Subject ID is not already exists. Please enter other data' 
	end
Else if (@SubjectID ='' or @SubjectID is null or @SubjectName ='' or @SubjectName is null or
@Theory ='' or @Theory is null or @Lab ='' or @Lab is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF (@Theory < 0 or @Lab < 0)
	Begin
		print 'Theory or Lab must be greater than 0'
	End
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Update Subject
		Set 
			SubjectName=@SubjectName,
			Theory=@Theory,
			Lab=@lab
		Where @SubjectID=SubjectID
	end	
END

--TEST CASE
EXEC Update_Subject '1623','Hacking','30','10'
EXEC Update_Subject '1623','Hacking','abc','10'
EXEC Update_Subject '1623','Hacking','30','abc'
EXEC Update_Subject '1622','Hacking','0.5','20'
EXEC Update_Subject '1622','Hacking','20','0.5'
EXEC Update_Subject '1625','Hacking','30','10'
EXEC Update_Subject '','Hacking','30','10'
EXEC Update_Subject '1623','','30','10'
EXEC Update_Subject '1623','Hacking','-10','30'
EXEC Update_Subject '1623','hacking','10','-30'

--Delete Subject table
Create TRIGGER Delete_Subject
ON Subject
INSTEAD OF DELETE
AS
Begin
	delete from Exammarks where SubjectID in (select SubjectID from deleted)
	delete from Subject where SubjectID in (select SubjectID from deleted)	
end

Delete from Subject where SubjectID= '1623'







--Tab Exammarks
--Button Search Exammarks
CREATE PROC Search_Exammarks (@Data_search nvarchar(100))
AS
IF(@Data_search='' or @Data_search is null)
	BEGIN
		PRINT 'Data is not null or space'
	END
ELSE
BEGIN
SELECT * FROM Exammarks WHERE StudentID like '%'+@Data_search+'%' 
or SubjectID like '%'+@Data_search+'%' 
or TeacherID like '%'+@Data_search+'%' 
or ExamDate like '%'+@Data_search+'%'
or Mark like '%'+@Data_search+'%'
END
IF @@ROWCOUNT = 0 or @@ERROR <> 0
	BEGIN
		PRINT 'No data found. Please enter correct information'
	END

--TEST CASE
EXEC Search_Exammarks '1619'
EXEC Search_Exammarks 'SVabc'
EXEC Search_Exammarks ''
EXEC Search_Exammarks '     '

--Button Save ( Insert data into Exammarks table)
Create proc Insert_Into_Exammarks
(@StudentID Char(10),
@SubjectID Char(10),
@TeacherID Char(10),
@ExamDate date,
@Mark float)
AS
BEGIN
IF EXISTS(Select * from Exammarks where @StudentID=StudentID and @SubjectID=SubjectID and @ExamDate=ExamDate) 
	begin
		Print'Data is already exists. Please enter other data' 
	end
Else if (@StudentID ='' or @StudentID is null or @SubjectID ='' or @StudentID is null 
or @TeacherID ='' or @TeacherID is null or @ExamDate ='' or @ExamDate is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF (@Mark < 0  or @Mark > 10 )
	begin
		Print'Mark must from 0 to 10'
	end
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Insert into Exammarks(StudentID,SubjectID,TeacherID,ExamDate,Mark)
		values (@StudentID,@SubjectID,@TeacherID,@ExamDate,@Mark)
	end	
END
Delete from Exammarks where StudentID= 'SV10' and SubjectID='1619' and ExamDate='03/15/2021'

--TEST CASE

exec Insert_Into_Exammarks 'SV10','1619','TC04','03/15/2021','10'
exec Insert_Into_Exammarks 'SV10','1619','TC09','03/15/2021','10'
exec Insert_Into_Exammarks 'SV10','1621','TC04','03/09/2021','10'
exec Insert_Into_Exammarks 'SV10','1621','TC04','03/09/2021','abc'

exec Insert_Into_Exammarks 'SV10','1619','TC04','03/15/2021','-1'
exec Insert_Into_Exammarks 'SV10','1619','TC04','03/15/2021','0'
exec Insert_Into_Exammarks 'SV10','1619','TC04','03/15/2021','10'
exec Insert_Into_Exammarks 'SV10','1619','TC04','03/15/2021','11'

exec Insert_Into_Exammarks '','1619','TC04','03/15/2021','10'
exec Insert_Into_Exammarks 'SV10','','TC04','03/15/2021','10'
exec Insert_Into_Exammarks 'SV10','1619','','03/15/2021','10'
exec Insert_Into_Exammarks 'SV10','1619','TC04','','10'



--Button Edit(Update) Exammarks
Create proc Update_Exammarks
(@StudentID Char(10),
@SubjectID Char(10),
@TeacherID Char(10),
@ExamDate date,
@Mark float)
AS
BEGIN
IF NOT EXISTS (Select * from Exammarks where @StudentID=StudentID and @SubjectID=SubjectID and @ExamDate=ExamDate)
	begin
		Print'Data is not already exists. Please enter other data' 
	end
Else if (@StudentID ='' or @StudentID is null or @SubjectID ='' or @StudentID is null 
or @TeacherID ='' or @TeacherID is null or @ExamDate ='' or @ExamDate is null)
	Begin
		print'Data is not null or space'
	end
ELSE IF (@Mark < 0  or @Mark > 10 )
	begin
		Print'Mark must from 0 to 10'
	end
ELSE IF @@Error <> 0
	begin
		Print'Data is invalid.Please, Enter data is corret' 
	end
ELSE
	begin
		Update Exammarks 
		Set 
			TeacherID=@TeacherID,
			Mark=@Mark
		Where StudentID = @StudentID and SubjectID=@SubjectID and ExamDate=@ExamDate
	end	
END

--TEST CASE
exec Update_Exammarks 'SV10','1619','TC04','03/15/2021','7'
exec Update_Exammarks 'SV12','1622','TC04','03/15/2021','7'
exec Update_Exammarks 'SV10','1619','TC09','03/15/2021','7'
exec Update_Exammarks 'SV10','1621','TC04','03/09/2021','abc'

exec Update_Exammarks 'SV10','1619','TC04','03/15/2021','11'
exec Update_Exammarks 'SV10','1619','TC04','03/15/2021','-1'

exec Update_Exammarks '','1619','TC04','03/15/2021','10'
exec Update_Exammarks 'SV10','','TC04','03/15/2021','10'
exec Update_Exammarks 'SV10','1619','','03/15/2021','10'
exec Update_Exammarks 'SV10','1619','TC04','','10'

--Button Delete Exammarks
Create TRIGGER Delete_Exammarks
ON Exammarks
INSTEAD OF DELETE
AS
Begin
	delete from Exammarks 
	where StudentID in (select StudentID from deleted) 
	and SubjectID in (select SubjectID from deleted) 
	and ExamDate in (select ExamDate from deleted)
End

Delete from Exammarks where StudentID= 'SV10' and SubjectID='1619' and ExamDate='03/15/2021'

--Top 10 students have mark hishest
Create PROC Top10_mark_highest
AS
SELECT TOP(10) with ties S.StudentID, S.FullName,S.ClassID,E.SubjectID,Su.SubjectName,TeacherID,ExamDate,E.Mark
from Exammarks as E,Student as S,Subject as Su
where E.StudentID=S.StudentID and E.SubjectID=Su.SubjectID
ORDER BY Mark DESC

exec Top10_mark_highest

--Top 10 students have mark lowest
create PROC Top10_mark_lowest
AS
SELECT TOP(10) with ties S.StudentID, S.FullName,S.ClassID,E.SubjectID,Su.SubjectName,TeacherID,ExamDate,E.Mark
from Exammarks as E,Student as S,Subject as Su
where E.StudentID=S.StudentID and E.SubjectID=Su.SubjectID
ORDER BY Mark

exec Top10_mark_lowest

--List of students has mark below 6.5
Create Proc Student_Mark_below_6_5
AS
SELECT S.StudentID, S.FullName,S.ClassID,E.SubjectID,Su.SubjectName,TeacherID,ExamDate,E.Mark
from Exammarks as E,Student as S,Subject as Su
where E.StudentID=S.StudentID and E.SubjectID=Su.SubjectID and Mark < 6.5


exec Student_Mark_below_6_5

--List of students has mark above 6.5
Create Proc Student_Mark_above_6_5
AS
SELECT S.StudentID, S.FullName,S.ClassID,E.SubjectID,Su.SubjectName,TeacherID,ExamDate,E.Mark
from Exammarks as E,Student as S,Subject as Su
where E.StudentID=S.StudentID and E.SubjectID=Su.SubjectID and Mark >= 6.5

EXEC Student_Mark_above_6_5

--List of students has mark above 8
Create Proc Student_Mark_above_8
AS
SELECT S.StudentID, S.FullName,S.ClassID,E.SubjectID,Su.SubjectName,TeacherID,ExamDate,E.Mark
from Exammarks as E,Student as S,Subject as Su
where E.StudentID=S.StudentID and E.SubjectID=Su.SubjectID and Mark >= 8

EXEC Student_Mark_above_8



--Security for database
Create  trigger ProhibitDelete
ON database
for drop_table
as
begin
	print 'You are not allowed to delete tables in this database.'
	Rollback tran
end

drop table Exammarks

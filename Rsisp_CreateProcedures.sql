use Rsisp
go

select [name],create_date,modify_date
from sys.all_objects
where type_desc = 'SQL_STORED_PROCEDURE'
and substring([name],1,3) not in ('sp_','dt_','xp_') 
order by 1 desc
go

--select all Users
create procedure dbo.getUsers
as
	select *
	from dbo.Users
go
	--test
		exec dbo.getUsers
		go

--insert User
create procedure dbo.addUser
	@UserName nvarchar(20),
	@ID_Role nvarchar(20),
	@UserAccount nvarchar(50),
	@UserPassword nvarchar(50)
with recompile
as
	--找出目前最大的使用者編號並+1
		declare @ID_User nvarchar(20),
				@ID varchar(20),
				@i int             
		
		select top 1 @ID=ID_User
		from dbo.Users
		order by ID_User desc

		if @@ROWCOUNT = 0	--如果是第一筆紀錄
			set @ID_User = 'U0001'
		else
		begin
			set @i = CAST(RIGHT(@ID, 4) as int) + 1
			set @ID = CAST(@i AS varchar)
			set @ID_User = 'U' + REPLICATE('0',4-LEN(@ID)) + @ID
		end

	insert into dbo.Users(ID_User, UserName, ID_Role, UserAccount, UserPassword)
	values (@ID_User, @UserName, @ID_Role, @UserAccount, @UserPassword)
go
	--test
		exec dbo.addUser 'testMan', 'R3', 'test', '123'
		select * from Users
		go

--delect User
create procedure dbo.deleteUserByID
	@ID_User	nvarchar(20)
with recompile
as
	delete from dbo.Users
	where ID_User = @ID_User
go
	--test
		exec dbo.deleteUserByID 'U1131'
		select * from Users
		go

--update User
create procedure dbo.updateUserByID
	@ID_User	nvarchar(20),
	@UserName nvarchar(20),
	@ID_Role nvarchar(20),
	@UserAccount nvarchar(50),
	@UserPassword nvarchar(50)
with recompile
as
	update dbo.Users
	set UserName = @UserName,
		ID_Role = @ID_Role,
		UserAccount = @UserAccount,
		UserPassword = @UserPassword
	where ID_User = @ID_User
go
	--test
		exec dbo.updateUserByID 'U1131', 'tester', 'R5', 'test123', '123456'
		select * from Users
		go

--select all Roles
create procedure dbo.getRoles
as
	select *
	from dbo.Roles
go
	--test
		exec dbo.getRoles
		go

--insert Role
create procedure dbo.addRole
	@ID_Role  nvarchar(20),
	@RoleName nvarchar(20)	
with recompile
as
	insert into dbo.Roles(ID_Role, RoleName)
	values (@ID_Role, @RoleName)
go
	--test
		exec dbo.addRole 'R9', 'Saber'
		select * from Roles
		go

--delect Role
create procedure dbo.deleteRoleByID
	@ID_Role	nvarchar(20)
with recompile
as
	delete from dbo.Roles
	where ID_Role = @ID_Role
go
	--test
		exec dbo.deleteRoleByID 'R9'
		select * from Roles
		go

--update Role
create procedure dbo.updateRoleByID
	@ID_Role	nvarchar(20),
	@RoleName nvarchar(20)
with recompile
as
	update dbo.Roles
	set RoleName = @RoleName
	where ID_Role = @ID_Role
go
	--test
		exec dbo.updateRoleByID 'R9', 'Archer'
		select * from Roles
		go

--select all Patients
create procedure dbo.getPatients
as
	select *
	from dbo.Patients
go
	--test
		exec dbo.getPatients
		go

--insert Patient
create procedure dbo.addPatient	
	@PatientName		nvarchar(20),
	@PatientIDCard		nvarchar(20),
	@PatientBirthday	date,
	@PatientPhotoPath	nvarchar(100)
with recompile
as
	--找出目前最大的使用者編號並+1
		declare @ID_Patient nvarchar(20),
				@ID varchar(20),
				@i int             
		
		select top 1 @ID=ID_Patient
		from dbo.Patients
		order by ID_Patient desc

		if @@ROWCOUNT = 0	--如果是第一筆紀錄
			set @ID_Patient = 'P000001'
		else
		begin
			set @i = CAST(RIGHT(@ID, 6) as int) + 1
			set @ID = CAST(@i AS varchar)
			set @ID_Patient = 'P' + REPLICATE('0',6-LEN(@ID)) + @ID
		end
	insert into dbo.Patients(ID_Patient, PatientName, PatientIDCard, PatientBirthday, PatientPhotoPath)
	values (@ID_Patient, @PatientName, @PatientIDCard, @PatientBirthday, @PatientPhotoPath)
go
	--test
		exec dbo.addPatient 'Marco', 'S123456789', '1990/10/10', './pics/pic.png'
		select * from Patients
		go

--delect Patient
create procedure dbo.deletePatientByID
	@ID_Patient	nvarchar(20)
with recompile
as
	delete from dbo.Patients
	where ID_Patient = @ID_Patient
go
	--test
		exec dbo.deletePatientByID 'P100124'
		select * from Patients
		go

--update Patient
create procedure dbo.updatePatientByID
	@ID_Patient			nvarchar(20),
	@PatientName		nvarchar(20),
	@PatientIDCard		nvarchar(20),
	@PatientBirthday	date,
	@PatientPhotoPath	nvarchar(100)
with recompile
as
	update dbo.Patients
	set PatientName = @PatientName,
		PatientIDCard = @PatientIDCard,
		PatientBirthday = @PatientBirthday,
		PatientPhotoPath = @PatientPhotoPath
	where ID_Patient = @ID_Patient
go
	--test
		exec dbo.updatePatientByID 'P100124', 'Mary', 'S87654321', '1980/08/01', './pics/pic2.png'
		select * from Patients
		go

--select all Schedules
create procedure dbo.getSchedules
as
	select *
	from dbo.Schedules
go
	--test
		exec dbo.getSchedules
		go

--update schedule state to finished
create procedure dbo.setScheduleIsFinished
	@ID_Schedule int
as
	update dbo.Schedules
	set isFinished = 1
	where ID_Schedule = @ID_Schedule
go
	--test
		exec dbo.setScheduleIsFinished 1
		exec dbo.getSchedules
		go
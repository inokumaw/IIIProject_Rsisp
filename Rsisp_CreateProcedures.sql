use Rsisp
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
    
		set @i = CAST(RIGHT(@ID, 4) as int) + 1
		set @ID = CAST(@i AS varchar)
		set @ID_User = 'U' + REPLICATE('0',4-LEN(@ID)) + @ID

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
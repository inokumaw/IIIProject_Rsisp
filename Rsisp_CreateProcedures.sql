use Rsisp
go

--select all
create procedure dbo.getUsers
as
	select *
	from dbo.Users
go
--test
exec dbo.getUsers
go

--insert user
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
delete from dbo.Users where UserAccount = 'test'
go
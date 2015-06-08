use Rsisp
go

--select all AssessStyle
create procedure dbo.getAssessStyles
as
	select *
	from dbo.AssessStyle
go
	--test
		exec dbo.getAssessStyles
		go

--select an assess's AssessItemStyle
create procedure dbo.getAssessItemStyle
	@ID_Assess int
as
	select *
	from dbo.AssessItemStyle
	where ID_Assess = @ID_Assess
go
	--test
		exec dbo.getAssessItemStyle '1'
		go

--select an item's AssessItemGroupStyles
create procedure dbo.getAssessItemGroupStyle
	@ID_Group int
as
	select *
	from dbo.AssessItemGroupStyle
	where ID_Group = @ID_Group
go
	--test
		exec dbo.getAssessItemGroupStyle '10'
		go

--select an item's AssessItemContentStyle
create procedure dbo.getAssessItemContentStyle
	@ID_Item int
as
	select *
	from dbo.AssessItemContentStyle
	where ID_Item = @ID_Item
go
	--test
		exec dbo.getAssessItemContentStyle '1001'
		go

--insert an assessStyle
create procedure dbo.addAssessStyle
	@AssessName nvarchar(50)
as
	--找出目前最大的TableName並+1
		declare @TableName nvarchar(20),
				@number varchar(20),
				@i int             
		
		select top 1 @number=TableName
		from dbo.AssessStyle
		order by TableName desc

		if @@ROWCOUNT = 0	--如果是第一筆紀錄
			set @TableName = 'Assess1'
		else
		begin
			set @i = CAST(RIGHT(@number, 1) as int) + 1
			set @number = CAST(@i AS varchar)
			set @TableName = 'Assess' + @number
		end

	insert into dbo.AssessStyle(AssessName, TableName)
	values (@AssessName, @TableName)
go
	--test
		exec dbo.addAssessStyle '測試用評估表'
		select * from AssessStyle

--insert an assessItemGroupStyle
create procedure dbo.addAssessItemGroupStyle
	@GroupName nvarchar(50)
as
	insert into dbo.AssessItemGroupStyle(GroupName)
	values (@GroupName)
go
	--test
		exec dbo.addAssessItemGroupStyle '測試用群組'
		select * from AssessItemGroupStyle
		go

--insert an assessItemStyle
create procedure dbo.addAssessItemStyle
	@ID_Assess int,
	@ID_Group int,
    @ItemName nvarchar(50),
	@SchemeNameType nvarchar(20)   
as
	--找出ID_Assess中目前最大的SchemeName並+1
		declare @SchemeName nvarchar(20),
				@number varchar(20),
				@i int

		select top 1 @number=SchemeName
		from dbo.AssessItemStyle
		where (ID_Assess = @ID_Assess) and (SchemeName like '%'+@SchemeNameType+'%')
		order by SchemeName desc

		if @@ROWCOUNT = 0	--如果是第一筆紀錄
			set @SchemeName = @SchemeNameType + '1'
		else
		begin
			set @i = CAST(RIGHT(@number, 1) as int) + 1
			if @i = 10
				set @i = CAST(RIGHT(@number, 2) as int) + 1
			set @number = CAST(@i AS varchar)
			set @SchemeName = @SchemeNameType + @number
		end

	insert into dbo.AssessItemStyle(ID_Assess, ID_Group, ItemName, SchemeName)
	values (@ID_Assess, @ID_Group, @ItemName, @SchemeName)
go
	--test
		exec dbo.addAssessItemStyle '3', '20', '測試項目2', 'ItemScore'
		select * from AssessItemStyle
		go

--insert an assessItemContentStyle
create procedure dbo.addAssessItemContentStyle
	@ID_Item int,
    @Score int,
	@Content nvarchar(100)  
as
	insert into dbo.AssessItemContentStyle(ID_Item, Score, Content)
	values (@ID_Item, @Score, @Content)
go
	--test
		exec dbo.addAssessItemContentStyle '1048', '0', '否'
		select * from AssessItemContentStyle
		go
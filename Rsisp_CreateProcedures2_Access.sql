use Rsisp
go

--select all AssessStyles
create procedure dbo.getAssessStyles
as
	select *
	from dbo.AssessStyle
go
	--test
		exec dbo.getAssessStyles		
		go
		delete from AssessStyle where ID_Assess > 11

--select all AssessItemStyles
create procedure dbo.getAssessItemStyles
as
	select *
	from dbo.AssessItemStyle
go
	--test
		exec dbo.getAssessItemStyles
		go

--select all AssessItemGroupStyles
create procedure dbo.getAssessItemGroupStyles
as
	select *
	from dbo.AssessItemGroupStyle
go
	--test
		exec dbo.getAssessItemGroupStyles
		go
		delete from AssessItemGroupStyle where ID_Group > 32

--select all AssessItemContentStyles
create procedure dbo.getAssessItemContentStyles
as
	select *
	from dbo.AssessItemContentStyle
go
	--test
		exec dbo.getAssessItemContentStyles
		go
		delete from AssessItemContentStyle where ID_Content >100087

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
			set @TableName = 'Assess001'
		else
		begin
			set @i = CAST(RIGHT(@number, 3) as int) + 1
			set @number = CAST(@i AS varchar)
			set @TableName = 'Assess' + REPLICATE('0',3-LEN(@number)) + @number			 
		end

	insert into dbo.AssessStyle(AssessName, TableName)
	values (@AssessName, @TableName)
go
	--test
		exec dbo.addAssessStyle '測試用評估表'
		select * from AssessStyle
		go
		delete from AssessStyle where ID_Assess = 12

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
		delete from AssessItemGroupStyle where ID_Group = 30

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
			set @SchemeName = @SchemeNameType + '01'
		else
		begin
			set @i = CAST(RIGHT(@number, 2) as int) + 1	
			set @number = CAST(@i AS varchar)
			set @SchemeName = @SchemeNameType + REPLICATE('0',2-LEN(@number)) + @number
		end

	insert into dbo.AssessItemStyle(ID_Assess, ID_Group, ItemName, SchemeName)
	values (@ID_Assess, @ID_Group, @ItemName, @SchemeName)
go
	--test
		exec dbo.addAssessItemStyle '2', null, '測試項目2', 'ItemScore'
		select * from AssessItemStyle
		go
		delete from AssessItemStyle where ID_Item = 1116

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
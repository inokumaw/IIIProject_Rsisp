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
use Rsisp
go

create procedure dbo.getUsers
as
select *
from dbo.Users
go

exec dbo.getUsers
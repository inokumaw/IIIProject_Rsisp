use Rsisp
go

create table Roles
(
	ID_Role			nvarchar(20),
    RoleName		nvarchar(20) not null,    

    primary key (ID_Role)
)

create table Users
(
	ID_User			nvarchar(20),
    UserName		nvarchar(20) not null,
    ID_Role			nvarchar(20),
	UserAccount		nvarchar(50) not null unique,
	UserPassword	nvarchar(50) not null,

    primary key (ID_User),
	foreign key (ID_Role) references Roles(ID_Role)
)

create table Patients
(
	ID_Patient		nvarchar(20),
    PatientName		nvarchar(20) not null,
	PatientIDCard	nvarchar(20) not null unique,
	PatientBirthday	date,

    primary key (ID_Patient)
)

create table AssessStyle
(
	ID_Assess		int identity(1, 1), 
    AssessName		nvarchar(50) not null,
	TableName		nvarchar(20) not null,    

    primary key (ID_Assess)
)

create table AssessItemStyle
(
	ID_Item			int identity(1001, 1), 
	ID_Assess		int,
    ItemName		nvarchar(50) not null,
	SchemeName		nvarchar(20) not null,    

    primary key (ID_Item),
	foreign key (ID_Assess) references AssessStyle(ID_Assess) on delete cascade
)

create table AssessItemContentStyle
(
	ID_Content		int identity(100001, 1), 
	ID_Item			int,
    Score			int not null,
	Content			nvarchar(100),    

    primary key (ID_Content),
	foreign key (ID_Item) references AssessItemStyle(ID_Item) on delete cascade
)

create table Assess1
(
	ID_Assess1		int identity(10000001, 1), 
	ID_User			nvarchar(20),
    ItemScore1		int not null,
	ItemScore2		int not null,
	ItemScore3		int not null,
	ItemScore4		int not null,
	ItemScore5		int not null,
	ItemScore6		int not null,
	ItemScore7		int not null,

    primary key (ID_Assess1),
	foreign key (ID_User) references Users(ID_User)
)

create table Assess2
(
	ID_Assess2		int identity(20000001, 1), 
	ID_User			nvarchar(20),
    ItemScore1		int not null,
	ItemScore2		int not null,

    primary key (ID_Assess2),
	foreign key (ID_User) references Users(ID_User)
)

create table Assess3
(
	ID_Assess3		int identity(30000001, 1), 
	ID_User			nvarchar(20),
    ItemScore1		int not null,
	ItemScore2		int not null,

    primary key (ID_Assess3),
	foreign key (ID_User) references Users(ID_User)
)

create table Assess4
(
	ID_Assess4		int identity(40000001, 1), 
	ID_User			nvarchar(20),
    ItemScore1		int not null,
	ItemScore2		int not null,

    primary key (ID_Assess4),
	foreign key (ID_User) references Users(ID_User)
)

create table Assess5
(
	ID_Assess5		int identity(50000001, 1), 
	ID_User			nvarchar(20),
    ItemScore1		int not null,
	ItemScore2		int not null,

    primary key (ID_Assess5),
	foreign key (ID_User) references Users(ID_User)
)

create table Assess6
(
	ID_Assess6		int identity(60000001, 1), 
	ID_User			nvarchar(20),
    ItemScore1		int not null,
	ItemScore2		int not null,

    primary key (ID_Assess6),
	foreign key (ID_User) references Users(ID_User)
)

create table Assess7
(
	ID_Assess7		int identity(70000001, 1), 
	ID_User			nvarchar(20),
    ItemScore1		int not null,
	ItemScore2		int not null,

    primary key (ID_Assess7),
	foreign key (ID_User) references Users(ID_User)
)

create table Assess8
(
	ID_Assess8		int identity(80000001, 1), 
	ID_User			nvarchar(20),
    ItemScore1		int not null,
	ItemScore2		int not null,

    primary key (ID_Assess8),
	foreign key (ID_User) references Users(ID_User)
)

create table AssessRecords
(
	ID_Record		int identity(1, 1), 
	RecordTime		datetime,
    ID_Patient		nvarchar(20),
	ID_Assess1		int,
	ID_Assess2		int,

    primary key (ID_Record),
	foreign key (ID_Patient) references Patients(ID_Patient),
	foreign key (ID_Assess1) references Assess1(ID_Assess1),
	foreign key (ID_Assess2) references Assess2(ID_Assess2),
)

select * from Roles
select * from Users
select * from Patients
select * from AssessStyle
select * from AssessItemStyle
select * from AssessItemContentStyle
select * from Assess1
select * from Assess2
select * from AssessRecords
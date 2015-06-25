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
	ID_Patient			nvarchar(20),
    PatientName			nvarchar(20) not null,
	PatientIDCard		nvarchar(20) not null unique,
	PatientBirthday		date,
	PatientPhotoPath	nvarchar(100)

    primary key (ID_Patient)
)

create table AssessStyle
(
	ID_Assess		int identity(1, 1), 
    AssessName		nvarchar(50) not null,
	TableName		nvarchar(20) not null,    

    primary key (ID_Assess)
)

create table AssessItemGroupStyle
(
	ID_Group		int identity(10, 1),
	GroupName		nvarchar(50) not null,

	primary key (ID_Group)
)

create table AssessItemStyle
(
	ID_Item			int identity(1001, 1), 
	ID_Assess		int,
	ID_Group		int,
    ItemName		nvarchar(50) not null,
	SchemeName		nvarchar(20) not null,    

    primary key (ID_Item),
	foreign key (ID_Assess) references AssessStyle(ID_Assess) on delete cascade,
	foreign key (ID_Group) references AssessItemGroupStyle(ID_Group) on delete cascade
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

create table Assess001
(
	ID_Assess001		int identity(10000001, 1), 
	ID_User			nvarchar(20) not null,
	ID_Patient		nvarchar(20) not null,
	recordDate		date not null,
    ItemScore1		int not null,
	ItemScore2		int not null,
	ItemScore3		int not null,
	ItemScore4		int not null,
	ItemScore5		int not null,
	ItemScore6		int not null,
	ItemScore7		int not null,
	ItemScore8		int not null,
	ItemScore9		int not null,
	ItemScore10		int not null,
	ItemScore11		int not null,
	ItemScore12		int not null,
	ItemScore13		int not null,
	ItemScore14		int not null,
	ItemScore15		int not null,
	ItemText1		nvarchar(100)

    primary key (ID_Assess001),
	foreign key (ID_User) references Users(ID_User),
	foreign key (ID_Patient) references Patients(ID_Patient)	
)

create table Schedules
(
	ID_Schedule		int identity(10000001, 1), 
	ID_User			nvarchar(20),
	ID_Patient		nvarchar(20),
	ID_Assess		int,
	deadLine		date,

	ID_Schedule		int identity(1, 1), 
	ID_User			nvarchar(20) not null,
	ID_Patient		nvarchar(20) not null,
	ID_Assess		int not null,
	deadLine		date not null,
	isFinished		bit not null

	primary key (ID_Schedule),
	foreign key (ID_User) references Users(ID_User),
	foreign key (ID_Patient) references Patients(ID_Patient),
	foreign key (ID_Assess) references AssessStyle(ID_Assess)
)
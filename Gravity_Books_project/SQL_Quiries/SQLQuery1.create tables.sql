

CREATE DATABASE [DWH_Gravity_books]



CREATE TABLE [dbo].[Dim Author](
	[Author_id_SK] [int] IDENTITY(1,1) NOT NULL,
	[Author_id_BK] [int] NULL,
	[Author_name] [varchar](400) NULL,
	[Source_system_code] [tinyint] NULL,
	[Start_date] [datetime] NULL,
	[End_date] [datetime] NULL,
	[Is_current] [tinyint] NULL,
 CONSTRAINT [PK_Dim_author] PRIMARY KEY CLUSTERED 



CREATE TABLE [dbo].[Dim Book](
	[Book_Id_SK] [int] IDENTITY(1,1) NOT NULL,
	[Book_Bk] [int] NULL,
	[Title] [varchar](400) NULL,
	[ISBN] [varchar](13) NULL,
	[Language_BK] [int] NULL,
	[Language_Code] [varchar](8) NULL,
	[Language_Name] [varchar](50) NULL,
	[Num_pages] [int] NULL,
	[Publication_Date] [date] NULL,
	[Publisher_BK] [int] NULL,
	[Publisher_Name] [nvarchar](1000) NULL,
	[StartDate] [datetime] NULL,
	[End_Date] [datetime] NULL,
	[Is_Current] [int] NULL,
	[Source_sytem_code] [tinyint] NULL,
 CONSTRAINT [PK__Dim_Book__9503B3E72F413C8D] PRIMARY KEY CLUSTERED 




CREATE TABLE [dbo].[Dim Book_Author](
	[book_author_Sk] [int] IDENTITY(1,1) NOT NULL,
	[Book_Id_FK] [int] NOT NULL,
	[Author_id_FK] [int] NOT NULL,
	[Source_system_code] [tinyint] NULL,
 CONSTRAINT [PK_Dim Book_Author] PRIMARY KEY CLUSTERED 



CREATE TABLE [dbo].[Dim Customer](
	[Customer_Id_SK] [int] IDENTITY(1,1) NOT NULL,
	[Customer_Id_BK] [int] NULL,
	[First_Name] [varchar](200) NULL,
	[Last_Name] [varchar](200) NULL,
	[Email] [varchar](350) NULL,
	[Source_system_code] [tinyint] NULL,
	[Start_date] [datetime] NULL,
	[End_date] [datetime] NULL,
	[Is_current] [int] NULL,
 CONSTRAINT [PK_Dim_Customer] PRIMARY KEY CLUSTERED 



CREATE TABLE [dbo].[Dim Customer_Address](
	[Customer_Id_FK] [int] NULL,
	[Address_Id_FK] [int] NULL,
	[Status_Id_BK] [int] NULL,
	[Address_Status] [varchar](30) NULL,
	[Source_system_code] [tinyint] NULL
) ON [PRIMARY]



CREATE TABLE [dbo].[Dim shipping_Method](
	[Method_Id_SK] [int] IDENTITY(1,1) NOT NULL,
	[Method_Id_BK] [int] NULL,
	[Method_Name] [varchar](100) NULL,
	[Cost] [decimal](6, 2) NULL,
	[Source_system_code] [tinyint] NULL,
	[Start_Date] [datetime] NULL,
	[End_Date] [datetime] NULL,
	[Is_Current] [tinyint] NULL,
 CONSTRAINT [PK_Dim shipping_Method] PRIMARY KEY CLUSTERED 




CREATE TABLE [dbo].[Dim_Address](
	[Address_Id_SK] [int] IDENTITY(1,1) NOT NULL,
	[Address_Id_BK] [int] NULL,
	[Street_Num] [varchar](10) NULL,
	[Street_Name] [varchar](200) NULL,
	[City] [varchar](100) NULL,
	[Country_Id_BK] [int] NULL,
	[Country_Name] [varchar](200) NULL,
	[Source_system_code] [tinyint] NULL,
	[Start_Date] [datetime] NULL,
	[End_Date] [datetime] NULL,
	[Is_Current] [int] NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 



CREATE TABLE [dbo].[Dim_Status](
	[Status_Id_SK] [int] IDENTITY(1,1) NOT NULL,
	[Status_Id_BK] [int] NULL,
	[Status_Value] [varchar](20) NULL,
	[Source_system_code] [tinyint] NULL,
	[Start_Date] [date] NULL,
	[End_Date] [date] NULL,
	[Is_Current] [tinyint] NULL,
 CONSTRAINT [PK_Dim_Status] PRIMARY KEY CLUSTERED 



CREATE TABLE [dbo].[DimDate](
	[DateSK] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Day] [char](2) NOT NULL,
	[DaySuffix] [varchar](4) NOT NULL,
	[DayOfWeek] [varchar](9) NOT NULL,
	[DOWInMonth] [tinyint] NOT NULL,
	[DayOfYear] [int] NOT NULL,
	[WeekOfYear] [tinyint] NOT NULL,
	[WeekOfMonth] [tinyint] NOT NULL,
	[Month] [char](2) NOT NULL,
	[MonthName] [varchar](9) NOT NULL,
	[Quarter] [tinyint] NOT NULL,
	[QuarterName] [varchar](6) NOT NULL,
	[Year] [char](4) NOT NULL,
	[StandardDate] [varchar](10) NULL,
	[HolidayText] [varchar](50) NULL,
	[FiscalDay] [char](2) NULL,
	[FiscalMonth] [char](2) NULL,
	[FiscalMonthName] [varchar](9) NULL,
	[FiscalQuarter] [tinyint] NULL,
	[FiscalQuarterName] [varchar](6) NULL,
	[FiscalYear] [char](4) NULL,
 CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED 



CREATE TABLE [dbo].[Fact_Orderline](
	[Orderline_SK] [int] IDENTITY(1,1) NOT NULL,
	[Orderline_BK] [int] NULL,
	[Order_Id_BK] [int] NULL,
	[Customer_Id_FK] [int] NULL,
	[Book_Id_FK] [int] NULL,
	[Date_FK] [int] NULL,
	[Method_Id_FK] [int] NULL,
	[price] [decimal](5, 2) NULL,
	[Created_at] [datetime] NULL,
	[Source_system_code] [tinyint] NULL,
 CONSTRAINT [PK_Fact_Orderline] PRIMARY KEY CLUSTERED 
  



CREATE TABLE [dbo].[Meta_Control_Fact_orderline_load](
	[id] [int] NULL,
	[SalesOrderLine] [varchar](200) NULL,
	[Last_load_date] [datetime] NULL,
	[last_load_orderdate_BK] [int] NULL
) ON [PRIMARY]


create table Fact_History (
Fact_history_SK int primary key identity(1,1),
History_Id_BK int,Status_Id_FK int foreign key references Dim_status(Status_Id_SK),
Received_at int foreign key references DimDate(DateSK),
Pending_Dleivery_at int foreign key references DimDate(DateSK),
Dleivery_in_progress_at int foreign key references DimDate(DateSK),
Delivered_at int foreign key references DimDate(DateSK),
Cancelled_at int foreign key references DimDate(DateSK),
Returned_at int foreign key references DimDate(DateSK),
Created_at Datetime default GETDATE(),
Order_id_BK int)




create or alter view All_History as(
select 
max (iif(status_value = 'Order Received' , status_date,Null)) as Received_at,
max (iif(status_value = 'Pending Delivery' , status_date,Null)) as Pending_Dleivery_at,
max (iif(status_value = 'Delivery In Progress' , status_date,Null)) as Dleivery_in_progress_at,
max (iif(status_value = 'Delivered' , status_date,Null)) as Delivered_at,
max (iif(status_value = 'Cancelled' , status_date,Null)) as Cancelled_att,
max (iif(status_value = 'Returned' , status_date,Null)) as Returned_at,
order_id
from order_history oh,order_status os
where oh.status_id = os.status_id
group by order_id
)

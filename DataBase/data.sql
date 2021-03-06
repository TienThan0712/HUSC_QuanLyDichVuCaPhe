USE [master]
GO
/****** Object:  Database [QuanLyQuanCafe]    Script Date: 12/22/2021 9:49:33 PM ******/
CREATE DATABASE [QuanLyQuanCafe]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuanLyQuanCafe', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QuanLyQuanCafe.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuanLyQuanCafe_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QuanLyQuanCafe_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuanLyQuanCafe] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuanLyQuanCafe].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuanLyQuanCafe] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QuanLyQuanCafe] SET  MULTI_USER 
GO
ALTER DATABASE [QuanLyQuanCafe] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuanLyQuanCafe] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuanLyQuanCafe] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuanLyQuanCafe] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QuanLyQuanCafe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 8/6/2021 10:39:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END

GO
/****** Object:  Table [dbo].[Account]    Script Date: 8/6/2021 10:39:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL DEFAULT (N'Kter'),
	[PassWord] [nvarchar](1000) NOT NULL DEFAULT ((0)),
	[Type] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Bill]    Script Date: 8/6/2021 10:39:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL DEFAULT (getdate()),
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status] [int] NOT NULL DEFAULT ((0)),
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 8/6/2021 10:39:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Food]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL DEFAULT (N'Chưa đặt tên'),
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL DEFAULT (N'Chưa đặt tên'),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL DEFAULT (N'Bàn chưa có tên'),
	[status] [nvarchar](100) NOT NULL DEFAULT (N'Trống'),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'Admin', N'TienThan', N'1', 1)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'Khach', N'Khach', N'1', 0)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'staff', N'staff', N'1962026656160185351301320480154111117132155', 0)
INSERT [dbo].[Account] ([UserName], [DisplayName], [PassWord], [Type]) VALUES (N'Tien', N'Tien', N'tien', 1)
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (1, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 3, 1, 0, 60000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (2, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 7, 1, 0, 60)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (3, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 7, 1, 0, 0)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (4, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 9, 1, 0, 120)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (5, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 8, 1, 0, 240)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (6, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 11, 1, 0, 360)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (7, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 3, 1, 0, 120000)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (8, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 4, 1, 0, 360)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (9, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 1, 1, 0, 240)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (10, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 2, 1, 0, 375)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (11, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 3, 1, 0, 360)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (12, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 7, 1, 0, 480)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (13, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 10, 1, 0, 480)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (14, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 6, 1, 0, 480)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (15, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 1, 1, 0, 480)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (16, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 5, 1, 0, 600)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (17, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 2, 1, 0, 240)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (18, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 3, 1, 0, 24)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (19, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 6, 1, 0, 24)
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status], [discount], [totalPrice]) VALUES (20, CAST(N'2021-12-22' AS Date), CAST(N'2021-12-22' AS Date), 10, 1, 0, 24)
SET IDENTITY_INSERT [dbo].[Bill] OFF
SET IDENTITY_INSERT [dbo].[BillInfo] ON 

INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (1, 1, 3, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (2, 2, 3, 2)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (3, 4, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (4, 10, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (5, 8, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (6, 10, 6, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (7, 7, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (8, 6, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (9, 5, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (10, 9, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (11, 11, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (12, 12, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (13, 13, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (14, 14, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (15, 15, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (16, 16, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (17, 17, 1, 3)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (18, 15, 10, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (19, 16, 11, 1)
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count]) VALUES (20, 18, 8, 2)
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
SET IDENTITY_INSERT [dbo].[Food] ON 

INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (1, N'Cafe đen', 1, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (2, N'Cafe sữa', 1, 16000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (3, N'Bạc xỉu', 1, 22000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (5, N'Cafe muối', 1, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (6, N'Americano', 1, 27000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (8, N'Latte', 1, 27000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (9, N'Sinh tố dâu', 2, 32000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (10, N'Sinh tố bơ', 2, 30000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (11, N'Sinh tố xoài', 2, 32000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (14, N'Sinh tố cà chua', 2, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (15, N'Sinh tố dưa hấu ', 1, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (16, N'Trà sữa truyền thống', 3, 22000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (17, N'Trà đào', 3, 24000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (18, N'Trà trái cây nhiệt đới', 3, 24000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (19, N'Sữa tươi chân trâu đường đen', 3, 25000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (20, N'Trà sữa chocolate', 3, 27000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (21, N'Trà sữa bạc hà', 3, 27000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (22, N'Nước suối', 4, 10000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (23, N'Sting', 4, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (24, N'Coca Cola', 4, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (25, N'Pepsi', 4, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (26, N'7up', 4, 12000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (27, N'Bò húc', 4, 15000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (28, N'Nước ép cam', 5, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (29, N'Nước ép xoài', 5, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (30, N'Nước ép dưa hấu', 5, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (31, N'Nước ép chanh leo', 5, 20000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (32, N'Nước ép cóc', 5, 18000)
INSERT [dbo].[Food] ([id], [name], [idCategory], [price]) VALUES (33, N'Nước ép chanh', 5, 15000)
SET IDENTITY_INSERT [dbo].[Food] OFF
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 

INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (1, N'Cà phê')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (2, N'Sinh tố')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (3, N'Trà sữa')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (4, N'Nước uống đóng chai ')
INSERT [dbo].[FoodCategory] ([id], [name]) VALUES (5, N'Nước ép')
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
SET IDENTITY_INSERT [dbo].[TableFood] ON 

INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (1, N'Bàn 0', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (2, N'Bàn 1', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (3, N'Bàn 2', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (4, N'Bàn 3', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (5, N'Bàn 4', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (6, N'Bàn 5', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (7, N'Bàn 6', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (8, N'Bàn 7', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (9, N'Bàn 8', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (10, N'Bàn 9', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (11, N'Bàn 10', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (12, N'Bàn 11', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (13, N'Bàn 12', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (14, N'Bàn 13', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (15, N'Bàn 14', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (16, N'Bàn 15', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (17, N'Bàn 16', N'Trống')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (18, N'Bàn 17', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (19, N'Bàn 18', N'Có người')
INSERT [dbo].[TableFood] ([id], [name], [status]) VALUES (20, N'Bàn 19 ', N'Có người')
SET IDENTITY_INSERT [dbo].[TableFood] OFF
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateAndPage]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDateAndPage]
@checkIn date, @checkOut date, @page int
AS 
BEGIN
	DECLARE @pageRows INT = 10
	DECLARE @selectRows INT = @pageRows
	DECLARE @exceptRows INT = (@page - 1) * @pageRows
	
	;WITH BillShow AS( SELECT b.ID, t.name AS [Tên bàn], b.totalPrice AS [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable)
	
	SELECT TOP (@selectRows) * FROM BillShow WHERE id NOT IN (SELECT TOP (@exceptRows) id FROM BillShow)
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDateForReport]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByDateForReport]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT t.name, b.totalPrice, DateCheckIn, DateCheckOut, discount
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByMonth]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetListBillByMonth]
@year INT
AS
	BEGIN
		DECLARE @month INT = 1
		DECLARE @tblSummary TABLE(Month INT)
		WHILE(@month <= 12)
			BEGIN
				INSERT @tblSummary ( Month )
				VALUES  ( @month )
				SET @month += 1
			END
		
		SELECT t1.Month as N'Tháng', CASE
							WHEN t2.RevenueByMonth IS NULL THEN 0
							ELSE t2.RevenueByMonth
						END AS [Doanh thu]
		FROM @tblSummary AS t1 
		LEFT JOIN (	SELECT MONTH(b.DateCheckIn) AS Month, SUM(b.totalPrice) AS RevenueByMonth
					FROM Bill as b inner join BillInfo as bi on b.id=bi.idBill
					WHERE YEAR(b.DateCheckIn) = @year
					GROUP BY MONTH(b.DateCheckIn)) AS t2 ON t2.Month = t1.Month

	END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetNumBillByDate]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetNumBillByDate]
@checkIn date, @checkOut date
AS 
BEGIN
	SELECT COUNT(*)
	FROM dbo.Bill AS b,dbo.TableFood AS t
	WHERE DateCheckIn >= @checkIn AND DateCheckOut <= @checkOut AND b.status = 1
	AND t.id = b.idTable
END

GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_GetTableList]
AS SELECT * FROM dbo.TableFood

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBill]
@idTable INT
AS
BEGIN
	INSERT dbo.Bill 
	        ( DateCheckIn ,
	          DateCheckOut ,
	          idTable ,
	          status,
	          discount
	        )
	VALUES  ( GETDATE() , -- DateCheckIn - date
	          NULL , -- DateCheckOut - date
	          @idTable , -- idTable - int
	          0,  -- status - int
	          0
	        )
END

GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertBillInfo]
@idBill INT, @idFood INT, @count INT
AS
BEGIN

	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1
	
	SELECT @isExitsBillInfo = id, @foodCount = b.count 
	FROM dbo.BillInfo AS b 
	WHERE idBill = @idBill AND idFood = @idFood

	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF (@newCount > 0)
			UPDATE dbo.BillInfo	SET count = @foodCount + @count WHERE idFood = @idFood
		ELSE
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood
	END
	ELSE
	BEGIN
		INSERT	dbo.BillInfo
        ( idBill, idFood, count )
		VALUES  ( @idBill, -- idBill - int
          @idFood, -- idFood - int
          @count  -- count - int
          )
	END
END

GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END

GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTabel]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SwitchTabel]
@idTable1 INT, @idTable2 int
AS BEGIN

	DECLARE @idBill1 int
	DECLARE @idBill2 int

	SELECT @idBill1 = id FROM dbo.Bill WHERE dbo.Bill.idTable = @idTable1 AND STATUS = 0
	SELECT @idBill2 = id FROM dbo.Bill WHERE dbo.Bill.idTable = @idTable2 AND STATUS = 0

	UPDATE dbo.Bill SET dbo.Bill.idTable = @idTable2 WHERE id = @idBill1
	UPDATE dbo.Bill SET dbo.Bill.idTable = @idTable1 WHERE id = @idBill2
END

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 8/6/2021 10:39:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateAccount]
@userName NVARCHAR(100), @displayName NVARCHAR(100), @password NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE USERName = @userName AND PassWord = @password
	
	IF (@isRightPass = 1)
	BEGIN
		IF (@newPassword = NULL OR @newPassword = '')
		BEGIN
			UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END		
		ELSE
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	end
END

GO
USE [master]
GO
ALTER DATABASE [QuanLyQuanCafe] SET  READ_WRITE 
GO

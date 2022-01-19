/*Author name: Rahul Barthwal*/
/*Objective: Creation of User table*/

USE [TaskManagement]
GO
/****** Object:  Table [dbo].[tbl_Users]    Script Date: 1/20/2022 12:49:11 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_Users]
GO
/****** Object:  Table [dbo].[tbl_Users]    Script Date: 1/20/2022 12:49:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](30) NOT NULL,
	[MiddleName] [nvarchar](30) NULL,
	[LastName] [nvarchar](30) NOT NULL,
	[ProfileImage] [nvarchar](max) NULL,
	[EmailAddress] [nvarchar](38) NOT NULL,
	[Password] [nvarchar](16) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tbl_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_Users] ON 
GO
INSERT [dbo].[tbl_Users] ([UserId], [FirstName], [MiddleName], [LastName], [ProfileImage], [EmailAddress], [Password], [CreatedDate]) VALUES (4, N'Rahul', N'', N'Barthwal', N'~/UserImages/39241483.png', N'rahul.barthwal@buck.com', N'Rahul123', CAST(N'2022-01-18T21:03:43.627' AS DateTime))
GO
INSERT [dbo].[tbl_Users] ([UserId], [FirstName], [MiddleName], [LastName], [ProfileImage], [EmailAddress], [Password], [CreatedDate]) VALUES (7, N'Simran', N'', N'Kaur', N'~/UserImages/231-2318671_businesswoman-blank-profile-picture-female.png', N'SimranKaur@gmail.com', N'Simran123', CAST(N'2022-01-19T20:15:31.760' AS DateTime))
GO
INSERT [dbo].[tbl_Users] ([UserId], [FirstName], [MiddleName], [LastName], [ProfileImage], [EmailAddress], [Password], [CreatedDate]) VALUES (10, N'Rajveer', N'', N'Kumar', N'~/UserImages/170046959839241483.png', N'Rajveer@gmail.com', N'Rajveer123', CAST(N'2022-01-20T00:37:27.543' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tbl_Users] OFF
GO

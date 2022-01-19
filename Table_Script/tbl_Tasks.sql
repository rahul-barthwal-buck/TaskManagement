/*Author name: Rahul Barthwal*/
/*Objective: Creation of Task table*/

USE [TaskManagement]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tbl_Tasks]') AND type in (N'U'))
ALTER TABLE [dbo].[tbl_Tasks] DROP CONSTRAINT IF EXISTS [FK_tbl_User]
GO
/****** Object:  Table [dbo].[tbl_Tasks]    Script Date: 1/20/2022 12:48:06 AM ******/
DROP TABLE IF EXISTS [dbo].[tbl_Tasks]
GO
/****** Object:  Table [dbo].[tbl_Tasks]    Script Date: 1/20/2022 12:48:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Tasks](
	[TaskId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED 
(
	[TaskId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_Tasks] ON 
GO
INSERT [dbo].[tbl_Tasks] ([TaskId], [Name], [CreatedDate], [UserId]) VALUES (7, N'Study', CAST(N'2022-01-19T15:09:11.657' AS DateTime), 4)
GO
INSERT [dbo].[tbl_Tasks] ([TaskId], [Name], [CreatedDate], [UserId]) VALUES (8, N'TaskManagement Assignment', CAST(N'2022-01-19T15:14:11.320' AS DateTime), 4)
GO
INSERT [dbo].[tbl_Tasks] ([TaskId], [Name], [CreatedDate], [UserId]) VALUES (12, N'Study NodeJS', CAST(N'2022-01-19T22:00:44.283' AS DateTime), 7)
GO
INSERT [dbo].[tbl_Tasks] ([TaskId], [Name], [CreatedDate], [UserId]) VALUES (14, N'Study Angular', CAST(N'2022-01-19T23:12:59.753' AS DateTime), 4)
GO
SET IDENTITY_INSERT [dbo].[tbl_Tasks] OFF
GO
ALTER TABLE [dbo].[tbl_Tasks]  WITH CHECK ADD  CONSTRAINT [FK_tbl_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[tbl_Users] ([UserId])
GO
ALTER TABLE [dbo].[tbl_Tasks] CHECK CONSTRAINT [FK_tbl_User]
GO

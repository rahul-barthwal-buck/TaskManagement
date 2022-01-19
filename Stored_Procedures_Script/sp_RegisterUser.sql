/*Author name: Rahul Barthwal*/
/*Objective: Creation of sp_RegisterUser Stored Procedure*/
USE [TaskManagement]
GO

/****** Object:  StoredProcedure [dbo].[sp_RegisterUser]    Script Date: 1/20/2022 12:54:32 AM ******/
DROP PROCEDURE [dbo].[sp_RegisterUser]
GO

/****** Object:  StoredProcedure [dbo].[sp_RegisterUser]    Script Date: 1/20/2022 12:54:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_RegisterUser]
@FirstName NVARCHAR(30),
@MiddleName NVARCHAR(30) = NULL,
@LastName NVARCHAR(30),
@ProfileImage NVARCHAR(MAX) = NULL,
@Email NVARCHAR(38),
@Password NVARCHAR(16)
AS 
BEGIN
	BEGIN TRY
		INSERT INTO tbl_Users(FirstName,MiddleName,LastName,ProfileImage,EmailAddress,Password,CreatedDate) VALUES(@FirstName,@MiddleName,@LastName,@ProfileImage,@Email,@Password,GETDATE())
	END TRY
	BEGIN CATCH
		DECLARE @ErrorNumber    INT          = ERROR_NUMBER()
		DECLARE @ErrorMessage   NVARCHAR(50) = ERROR_MESSAGE()
		DECLARE @ErrorProcedure NVARCHAR(50) = ERROR_PROCEDURE()
		DECLARE @ErrorState     INT          = ERROR_STATE()
		DECLARE @ErrorSeverity  INT          = ERROR_SEVERITY()
		DECLARE @ErrorLine      INT          = ERROR_LINE()
		RAISERROR ('Error Details: ErrorNumber: %d, ErrorMessage: %s, ErrorProcedure: %s, ErrorState: %d, ErrorSeverity: %d,ErrorLine: %d,',16,1,@Errornumber,@ErrorMessage,@ErrorProcedure,@ErrorState,@ErrorSeverity,@ErrorLine)
	END CATCH
END
GO



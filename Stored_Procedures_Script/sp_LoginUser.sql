/*Author name: Rahul Barthwal*/
/*Objective: Creation of sp_LoginUser Stored Procedure*/
USE [TaskManagement]
GO

/****** Object:  StoredProcedure [dbo].[sp_LoginUser]    Script Date: 1/20/2022 12:54:09 AM ******/
DROP PROCEDURE [dbo].[sp_LoginUser]
GO

/****** Object:  StoredProcedure [dbo].[sp_LoginUser]    Script Date: 1/20/2022 12:54:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_LoginUser]
@Email NVARCHAR(38),
@Password NVARCHAR(16) = NULL,
@Event NVARCHAR(15)
AS
BEGIN
	BEGIN TRY
	 IF(@Event='CheckEmail')
	 BEGIN
		SELECT COUNT(*) FROM tbl_Users WHERE EmailAddress = @Email
	 END
	 IF(@Event='CheckPassword')
	 BEGIN
		SELECT * FROM tbl_Users WHERE EmailAddress = @Email AND Password = @Password
	 END
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



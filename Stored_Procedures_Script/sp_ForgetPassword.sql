/*Author name: Rahul Barthwal*/
/*Objective: Creation of sp_ForgetPassword Stored Procedure*/
USE [TaskManagement]
GO

/****** Object:  StoredProcedure [dbo].[sp_ForgetPassword]    Script Date: 1/20/2022 12:53:23 AM ******/
DROP PROCEDURE [dbo].[sp_ForgetPassword]
GO

/****** Object:  StoredProcedure [dbo].[sp_ForgetPassword]    Script Date: 1/20/2022 12:53:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ForgetPassword]
@Email NVARCHAR(38) = NULL,
@NewPassword NVARCHAR(16) = NULL,
@UserId INT = 0,
@Event NVARCHAR(15)
AS
BEGIN
	BEGIN TRY
     IF(@Event='CheckEmail')
	 BEGIN
		SELECT * FROM tbl_Users WHERE EmailAddress = @Email
	 END
	 IF(@Event='ChangePassword')
	 BEGIN
		UPDATE tbl_Users SET Password = @NewPassword WHERE UserId = @UserId
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



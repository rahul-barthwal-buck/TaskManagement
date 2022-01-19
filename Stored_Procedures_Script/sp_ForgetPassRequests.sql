/*Author name: Rahul Barthwal*/
/*Objective: Creation of sp_ForgetPassRequests Stored Procedure*/
USE [TaskManagement]
GO

/****** Object:  StoredProcedure [dbo].[sp_ForgetPassRequests]    Script Date: 1/20/2022 12:52:54 AM ******/
DROP PROCEDURE [dbo].[sp_ForgetPassRequests]
GO

/****** Object:  StoredProcedure [dbo].[sp_ForgetPassRequests]    Script Date: 1/20/2022 12:52:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ForgetPassRequests]
@MyGUID NVARCHAR(50) = NULL,
@UserId INT = 0,
@Event NVARCHAR(25)
AS 
BEGIN
	BEGIN TRY
	IF(@Event='InsertForgetPassRequest')
	 BEGIN
		INSERT INTO tbl_ForgetPasswordRequests(Id,UserId,RequestDateTime) VALUES(@MyGUID,@UserId,GETDATE())
	 END
	IF(@Event='CheckForgetPassRequestId')
	 BEGIN
		SELECT * FROM tbl_ForgetPasswordRequests WHERE Id = @MyGUID
	END	
	IF(@Event='DeleteForgetPassRequest')
	 BEGIN
		DELETE FROM tbl_ForgetPasswordRequests WHERE UserId = @UserId
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



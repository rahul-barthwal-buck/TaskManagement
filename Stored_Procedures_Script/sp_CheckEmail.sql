/*Author name: Rahul Barthwal*/
/*Objective: Creation of CheckEmail Stored Procedure*/

USE [TaskManagement]
GO

/****** Object:  StoredProcedure [dbo].[sp_CheckEmail]    Script Date: 1/20/2022 12:50:48 AM ******/
DROP PROCEDURE [dbo].[sp_CheckEmail]
GO

/****** Object:  StoredProcedure [dbo].[sp_CheckEmail]    Script Date: 1/20/2022 12:50:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_CheckEmail]
@Email NVARCHAR(38) = NULL
AS
BEGIN
	BEGIN TRY
	 SELECT COUNT(*) FROM tbl_Users WHERE EmailAddress = @Email
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



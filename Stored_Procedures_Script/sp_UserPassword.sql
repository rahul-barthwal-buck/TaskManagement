/*Author name: Rahul Barthwal*/
/*Objective: Creation of sp_UserPassword Stored Procedure*/
USE [TaskManagement]
GO

/****** Object:  StoredProcedure [dbo].[sp_UserPassword]    Script Date: 1/20/2022 12:55:40 AM ******/
DROP PROCEDURE [dbo].[sp_UserPassword]
GO

/****** Object:  StoredProcedure [dbo].[sp_UserPassword]    Script Date: 1/20/2022 12:55:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UserPassword]
				@UserId INT              = 0
              , @OldPassword                      NVARCHAR ( 16 ) = NULL
              , @NewPassword                       NVARCHAR ( 16 ) = NULL
              , @Event                         VARCHAR ( 15 ) AS BEGIN
BEGIN TRY
    if(@Event='CheckPassword')
    BEGIN
        SELECT COUNT(*) FROM tbl_Users WHERE Password = @OldPassword AND UserId = @UserId
    END
     if(@Event='ChangePassword')
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



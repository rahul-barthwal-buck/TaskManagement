/*Author name: Rahul Barthwal*/
/*Objective: Creation of sp_UserProfile Stored Procedure*/
USE [TaskManagement]
GO

/****** Object:  StoredProcedure [dbo].[sp_UserProfile]    Script Date: 1/20/2022 12:56:04 AM ******/
DROP PROCEDURE [dbo].[sp_UserProfile]
GO

/****** Object:  StoredProcedure [dbo].[sp_UserProfile]    Script Date: 1/20/2022 12:56:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_UserProfile]
				@UserId INT              = 0
              , @FirstName                      NVARCHAR ( 30 ) = NULL
              , @MiddleName                       NVARCHAR ( 30 ) = NULL
			                , @LastName                       NVARCHAR ( 30 ) = NULL
							              , @ProfileImage                       NVARCHAR ( MAX ) = NULL
              , @Event                         VARCHAR ( 18 ) AS BEGIN
BEGIN TRY
    if(@Event='FetchUserDetails')
    BEGIN
        SELECT FirstName, MiddleName, LastName,ProfileImage FROM tbl_Users WHERE UserId = @UserId
    END
     if(@Event='UpdateUserDetails')
    BEGIN
        UPDATE tbl_Users SET FirstName = @FirstName, MiddleName= @MiddleName, LastName=@LastName, ProfileImage=@ProfileImage WHERE UserId = @UserId
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



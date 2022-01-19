/*Author name: Rahul Barthwal*/
/*Objective: Creation of sp_TaskDetails Stored Procedure*/
USE [TaskManagement]
GO

/****** Object:  StoredProcedure [dbo].[sp_TaskDetails]    Script Date: 1/20/2022 12:55:04 AM ******/
DROP PROCEDURE [dbo].[sp_TaskDetails]
GO

/****** Object:  StoredProcedure [dbo].[sp_TaskDetails]    Script Date: 1/20/2022 12:55:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_TaskDetails] @TaskId INT              = 0
              , @TaskName                      NVARCHAR ( 100 ) = NULL
              , @UserId                        INT              = 0
              , @Event                         VARCHAR ( 10 ) AS BEGIN
BEGIN TRY
    if(@Event='Select')
    BEGIN
        SELECT
                   Tasks.TaskId
                 , Tasks.Name
        FROM
                   tbl_Tasks AS Tasks
                   INNER JOIN
                              tbl_Users AS Users
                              ON
                                         Tasks.UserId = Users.UserId
        WHERE
                   Users.UserId = @UserId
    END
    else
    if(@Event='Add')
    BEGIN
        INSERT INTO tbl_Tasks
               (Name
                    , CreatedDate
                    , UserId
               )
               VALUES
               (@TaskName
                    , GETDATE()
                    , @UserId
               )
           END
           else
           if(@Event='Update')
           BEGIN
               UPDATE
                          tbl_Tasks
               SET        Name= @TaskName
               FROM
                          tbl_Tasks AS Task
                          INNER JOIN
                                     tbl_Users AS Users
                                     ON
                                                Task.UserId = Users.UserId
               WHERE
                          Users.UserId    = @UserId
                          AND Task.TaskId = @TaskId
           END
           else
           if(@Event='Search')
           BEGIN
               SELECT *
               FROM
                      tbl_Tasks
               WHERE
                      UserId      = @UserId
                      AND Name LIKE '%' + @TaskName + '%'
           END
		   else
           if(@Event='CheckTask')
           BEGIN
               SELECT COUNT(*)
               FROM
                      tbl_Tasks
               WHERE
                      UserId      = @UserId
                      AND Name = @TaskName
           END
           else
           BEGIN
               DELETE
               FROM
                      tbl_Tasks
               WHERE
                      TaskId     = @TaskId
                      AND UserId = @UserId
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



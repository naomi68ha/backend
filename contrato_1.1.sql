
ALTER PROCEDURE [dbo].[contrato1]
 @gender_id INT 
,@job_id	INT
,@name		VARCHAR(250)
,@last_name VARCHAR(250)
,@birthdate DATETIME 

AS

BEGIN

	DECLARE @success AS BIT
	DECLARE @edad	 AS INT =  DATEDIFF(YEAR,@birthdate,GETDATE()) - (CASE WHEN DATEADD(YY,DATEDIFF(YEAR,@birthdate,GETDATE()),@birthdate)>GETDATE() THEN 1 ELSE 0 END)
	
	IF (SELECT COUNT(*) FROM dbo.employees WHERE [name] = @name AND [last_name] = @last_name ) < 0 AND (@edad >= 18 )  AND (SELECT COUNT(*) FROM [jobs] WHERE id = @job_id) > 0
	BEGIN 
		SET @success = 1
	
		INSERT INTO [dbo].[employees]([gender_id],[job_id],[name],[last_name],[birthdate])
		VALUES (@gender_id ,@job_id ,@name ,@last_name ,@birthdate ) 

		SELECT id = MAX(id) , @success
		FROM [dbo].[employees]

	END
	ELSE
	BEGIN

		SET @success = 0

		SELECT id = NULL, success = @success
	END

END

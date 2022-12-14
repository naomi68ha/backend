
ALTER PROCEDURE [dbo].[contrato2]
  @job_id	INT
AS

BEGIN

	DECLARE @success AS BIT
	
	IF (SELECT COUNT(*) FROM dbo.employees WHERE job_id = @job_id ) > 0  
	BEGIN 
		SET @success = 1
	
		SELECT
			employees.id,
			employees.[name],
			employees.[last_name],
			employees.[birthdate],
			job.id,
			job.[name],
			job.salary,
			gender.id,
			gender.[name],
			success = @success
		FROM	[dbo].employees	employees										INNER JOIN
				[dbo].[jobs]	job			ON employees.job_id		= job.id	INNER JOIN
				[dbo].[genders] gender		ON employees.gender_id	= gender.id
		WHERE employees.job_id = @job_id
		FOR JSON PATH

	END
	ELSE
	BEGIN

		SET @success = 0

		SELECT employees = NULL, success = @success

	END

END

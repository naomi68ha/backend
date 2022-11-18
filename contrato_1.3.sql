
ALTER PROCEDURE [dbo].[contrato3]
  @employee_id	VARCHAR(MAX)  
, @start_date	DATETIME		= '2022-10-07'
, @end_date		DATETIME		= '2022-10-07'
AS

BEGIN

	DECLARE @success AS BIT
	
	IF (SELECT COUNT(*) FROM dbo.employees WHERE id IN (SELECT VALUE FROM STRING_SPLIT(@employee_id,',')) ) > 0  
	BEGIN 
		SET @success = 1
	
		SELECT
			employees.gender_id,
			employees.job_id,
			employees.[name],
			employees.[last_name],
			employees.[birthdate],
			success = @success
		FROM dbo.employees employees
		WHERE id IN (SELECT VALUE FROM STRING_SPLIT(@employee_id,',') )
		FOR JSON PATH

	END
	ELSE
	BEGIN

		SET @success = 0

		SELECT employees = NULL, success = @success

	END

END

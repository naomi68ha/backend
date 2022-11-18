
ALTER PROCEDURE [dbo].[contrato5]
  @employee_id	INT  
, @start_date	DATETIME		= '2022-10-07'
, @end_date		DATETIME		= '2022-10-07'
AS

BEGIN

	DECLARE @success AS BIT
	
	IF (SELECT COUNT(*) FROM dbo.employees WHERE id = @employee_id ) > 0 AND (@start_date < @end_date )
	BEGIN 
		SET @success = 1
	
		SELECT payment = ISNULL((WH.[worked_hour] * JB.salary), 0),  success = @success
		FROM [dbo].[employee_worked_hours]	WH								INNER JOIN
			 [dbo].[employees]				EM  ON WH.employee_id	= EM.id	INNER JOIN
			 [dbo].[jobs]					JB	ON JB.id			= EM.job_id
		WHERE WH.[worked_date] >= @start_date AND WH.[worked_date] <= @end_date
		AND WH.employee_id = @employee_id 

	END
	ELSE
	BEGIN

		SET @success = 0

		SELECT payment = NULL, success = @success
	END

END

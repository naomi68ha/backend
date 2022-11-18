
CREATE PROCEDURE [dbo].[contrato4]
  @employee_id	INT  
, @start_date	DATETIME		= '2022-10-07'
, @end_date		DATETIME		= '2022-10-07'
AS

BEGIN

	DECLARE @success AS BIT
	
	IF (SELECT COUNT(*) FROM dbo.employees WHERE id = @employee_id ) > 0 AND (@start_date < @end_date )
	BEGIN 
		SET @success = 1
	
		SELECT total_worked_hours = SUM([worked_hour]),  success = @success
		FROM [dbo].[employee_worked_hours]
		WHERE [worked_date] >= @start_date AND [worked_date] <= @end_date
		AND employee_id = @employee_id 

	END
	ELSE
	BEGIN

		SET @success = 0

		SELECT total_worked_hours = NULL, success = @success
	END

END

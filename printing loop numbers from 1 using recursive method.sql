
/* different methods for printing 1 to 100 */

-- declare
declare @num_loop table (number int);
declare @max_loop int = 100;

-- recursive method using common table expression
WITH CTE AS
(
	SELECT COUNT=1
	UNION ALL
	SELECT COUNT=COUNT+1
	FROM CTE WHERE COUNT<=@max_loop
) 
insert into @num_loop(number)
SELECT COUNT FROM CTE
option (maxrecursion 10000);


select * from @num_loop

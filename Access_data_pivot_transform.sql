/* The following script gets the rank number by master id and meter no, and do a crosstab query to transform the data table. 
 source: https://stackoverflow.com/questions/736317/sql-to-transpose-row-pairs-to-columns-in-ms-access-database
 source: http://allenbrowne.com/ser-67.html
*/

TRANSFORM First(tbl3.GBIMMETERNO) as MeterNo
select tbl3.MASTERID
from
(
	select 
	tbl.MASTERID,
	tbl.GBIMMETERNO,
	iif(len(count(*)) = 2 , trim(str(count(*))) , '0' & trim(str(count(*))) ) as rank
	from
	(
		SELECT distinct cd.MASTERID,  	cd.GBIMMETERNO FROM [0 Consumption Data] cd
	) tbl
	inner join
	(
		SELECT distinct cd.MASTERID,  	cd.GBIMMETERNO FROM [0 Consumption Data] cd
	) tbl2
	on tbl2.masterid = tbl.masterid and tbl.gbimmeterno >= tbl2.gbimmeterno
	group by
	tbl.masterid, tbl.gbimmeterno
) tbl3
group by tbl3.masterid
PIVOT  'Meter_' & tbl3.rank
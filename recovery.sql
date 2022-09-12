----------------------- ALL About VACUMM -----------------------
/* 
  Vacuuming helps mark outdated rows as available for reuse, so if VACUUMs are not running regularly,
  then newly added data will use additional disk space, instead of reusing the disk space taken up by dead rows.
*/

-- Run Vacumm on a table
VACUUMM FULL acom_provision
VACUUM [FULL] [FREEZE] [VERBOSE] ANALYZE table_name [ (col1, col2, ... col_n) ];

-- Dead rows: PostgreSQL offers a pg_stat_user_tables view that provides a breakdown of each table (relname) and how many dead rows (n_dead_tup) are in that table:
SELECT relname, n_dead_tup FROM pg_stat_user_tables;

-- Query to check table that is using the most disk space in your database:
SELECT
       relname AS "table_name",
       pg_size_pretty(pg_table_size(C.oid)) AS "table_size"
FROM
       pg_class C
LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
WHERE nspname NOT IN ('pg_catalog', 'information_schema') AND nspname !~ '^pg_toast' AND relkind IN ('r')
ORDER BY pg_table_size(C.oid)
DESC LIMIT 1;

-- Query to check last time a vacuuming or autovacuuming process successfully ran on each of your tables:
SELECT relname, last_vacuum, last_autovacuum FROM pg_stat_user_tables;

-- Query to check if autovacuuming is enabled in our PostgreSQL settings.
SELECT name, setting FROM pg_settings WHERE name='autovacuum';

-- Query to check if autovacuum is enabled on this table
SELECT reloptions FROM pg_class WHERE relname='my_table';

-- Query to enable autovacuum on this table
ALTER TABLE my_table SET (autovacuum_enabled = true);



----------------------- ALL About RE-INDEX -----------------------

-- Rebuild indexes < REINDEX { INDEX | TABLE | DATABASE | SYSTEM } name > For Example:
REINDEX INDEX index_name
REINDEX TABLE table_name
REINDEX DATABASE xyz_db

-- Find out the indexname
SELECT * FROM pg_indexes where "indexname" ilike '%555015_474982_clientcfghistory_pkey%'



----------------------- Fix Error Like Below -----------------------

-- Eexecute this if you hit this error: "cache lookup failed for relation 3467547070"
DELETE FROM pg_depend WHERE objid = 3467547070

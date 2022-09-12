----------------------- ALL About pg_stat_activity -----------------------
-- 1. Visit here for more details for (activity/monitoring) https://www.postgresql.org/docs/current/monitoring-stats.html
-- 2. More help for activity: https://sleeplessbeastie.eu/2014/07/23/how-to-terminate-postgresql-sessions/

-- Query to lisk all active activity for a given application name 
SELECT * FROM pg_stat_activity WHERE state = 'active'
AND "application_name" = 'User-Defined Action [1303]'
order by "backend_start" asc

-- Show MAX allowed connections
show max_connections; 

-- Show total used connections
SELECT COUNT(*) from pg_stat_activity;

-- Find out max/active parallel workers
SELECT current_setting('max_parallel_workers')::integer AS max_workers,
count(*) AS active_workers FROM pg_stat_activity
WHERE backend_type = 'parallel worker';


----------------------- ALL About pg-terminate -----------------------

-- terminate connection
SELECT pg_terminate_backend(procpid) FROM pg_stat_activity WHERE
 datname = 'db_name' -- terminate connections to the specified database
 usename = 'user_x'  -- terminate connections initiated by a specific user.
 procpid <> pg_backend_pid() -- terminate all connections but not my own

-- cancel a running query
SELECT pg_cancel_backend(procpid) FROM pg_stat_activity WHERE usename = 'postgres';

-- prevent users from connecting to the database
REVOKE CONNECT ON DATABASE test_db FROM wiki

-- Allow users for connecting to the database
GRANT CONNECT ON DATABASE test_db TO wiki
----------------------- ALL About JOBs -----------------------

-- Check the JOB stats
SELECT * FROM timescaledb_information.job_stats;

-- List all Jobs
SELECT * FROM timescaledb_information.jobs

-- Run the JOB_id 100 every 2 days
SELECT alter_job(1000, schedule_interval => INTERVAL '2 days');

-- Pause(false)/Start(true) a running JOB
SELECT alter_job(1006, scheduled => false);

-- Change next start time
SELECT alter_job(1007, next_start => '2022-06-24 16:50:00+00');

-- Chnage retry_period
SELECT alter_job(1007, retry_period => '1 hr');

-- Delete a Given JOB_id
SELECT delete_job(1000);
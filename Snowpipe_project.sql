use role accountadmin;


create or replace database snowpipe_project;


create or replace table orders_data_lz(
    order_id int,
    product varchar(20),
    quantity int,
    order_status varchar(30),
    order_date date
);


-- Create a Cloud Storage Integration in Snowflake
-- Integration means creating config based secure access
create or replace storage integration gcs_bucket_read_int
 type = external_stage
 storage_provider = gcs
 enabled = true
 storage_allowed_locations = ('gcs://snowpipe_raw_data_gcp_bucket/');



 -- Retrieve the Cloud Storage Service Account for your snowflake account
desc storage integration gcs_bucket_read_int;

-- Service account info for storage integration
-- k6gf00000@gcpuscentral1-1dfa.iam.gserviceaccount.com



-- Stage means reference to a specific external location where data will arrive
create or replace stage snowpipe_stage
  url = 'gcs://snowpipe_raw_data_gcp_bucket/'
  storage_integration = gcs_bucket_read_int;

  -- Show stages
show stages;

list @snowpipe_stage;

 

-- Create PUB-SUB Topic and Subscription in gcp
-- gsutil notification create -t snowpipe_pubsub_topic -f json gs://snowpipe_raw_data/

-- create notification integration
create or replace notification integration notification_from_pubsub_int
 type = queue
 notification_provider = gcp_pubsub
 enabled = true
 gcp_pubsub_subscription_name = 'projects/neat-episode-426503-d2/subscriptions/snowpipe_pubsub_topic-sub';

-- Describe integration
desc integration notification_from_pubsub_int;

-- Service account for PUB-SUB
-- kagf00000@gcpuscentral1-1dfa.iam.gserviceaccount.com


Create or replace pipe gcs_to_snowflake_pipe
auto_ingest = true
integration = notification_from_pubsub_int
as
copy into orders_data_lz
from @snowpipe_stage
file_format = (type = 'CSV');

show pipes;


-- Check the status of pipe
select system$pipe_status('gcs_to_snowflake_pipe');

-- Check the history of ingestion
Select * 
from table(information_schema.copy_history(table_name=>'orders_data_lz', start_time=> dateadd(hours, -1, current_timestamp())));


select * from orders_data_lz;

-- Terminate a pipe
drop pipe gcs_to_snowflake_pipe;
# Event-driven-data-ingestion-pipeline-using-SnowPipe

## <ins>Overview</ins>
This project involves developing an event-driven data ingestion pipeline using Snowpipe for seamless data transfer. It utilizes GCP services (GCP Bucket, Pub/Sub) and Snowflake features (Snowpipe, storage integration, notification integration) to automate data ingestion from cloud storage to Snowflake. The process includes creating necessary infrastructure, setting up integration roles and notifications, and testing the pipeline by placing files into the GCP bucket.

## <ins>Architectural Diagram:</ins>
![Architectural_diagram](https://github.com/KiranParihar/Event-driven-data-ingestion-pipeline-using-SnowPipe/blob/main/SnowPipe_architectural_diagram.png)


## <ins>Tools and Technologies used:</ins>
- GCP Bucket
- GCP Pub-Sub Topic
- Snowflake

  ## <ins>Steps performed </ins>

  **1. Create a GCP Bucket:**      
This bucket is where your data files will be stored before they are ingested into Snowflake.    
   
**2. Create Database and Table in Snowflake Worksheet:**   
This involves setting up the structure in Snowflake where your data will be stored after ingestion.   

**3. Create Storage Integration in Snowflake:**   
This creates a secure link between Snowflake and your GCP bucket, allowing Snowflake to access data in the bucket.    


**4. Create Custom Role for GCS Bucket Integration with Snowflake and Grant Permission to Service Account:**   
Ensures that Snowflake has the necessary permissions to access and read files from the GCP bucket.    


**5. Create SnowPipe Stage:**   
Defines an external reference in Snowflake pointing to the GCS bucket, facilitating automated data loading.  



**6. Create Pub/Sub Topic in GCP and Set Up Notification for Any New File Arrival at GCS Bucket:**   
Enables automatic notifications to inform Snowflake of new files in the GCS bucket.  


**7. Create Notification Integration in Snowflake:**    
Links Snowflake with the Pub/Sub topic to receive notifications about new files.    


**8. Create SnowPipe in Snowflake:**   
Automates the data loading process by continuously monitoring the external stage for new files.    


**9. Test the Pipeline by Uploading a File at GCS Bucket:**   
Verifies that the entire pipeline is functioning correctly and data is ingested as expected.  


This approach automates data ingestion, reducing manual effort and ensuring timely updates to your Snowflake data warehouse.

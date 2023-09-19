# Orchestrate Python ETL Pipeline with Astro and DBT using Airflow on GCP

This project demonstrates how to build and automate an ETL pipeline using DAGs in Airflow and load the transformed data to Bigquery. There are different tools that have been used in this project such as Astro (A docker wrapper around Airflow), DBT (Used for Data Modelling and creating reports using SQL), Soda (Used for Data Quality Checks), Metabase (Containarized Data visualization tool) and Google Cloud Platform for storing the tables.


# Project Goals - To try new tools and learn!

0. There has been a deulge of new tools and technologies in the market accentuating the data engineering field and the best way to keep abreast is to pry them out and do hands-on. So, in this project there are a lot of new tools that I have used to create an effective and robust data pipeline. It goes without saying that when there are more tools involved, the integration of the tools (because of dependencies or much worse "dependency hell" :scream: ) becomes a big hassle but at the same time, it allows us to understand the nitty gritties of the architecture. 

1. Data Ingestion - Create a data ingestion pipeline to extract new incoming data into the GCP BigQuery.
2. Data Quality - Use Soda to create highly customized data quality checks using yml files.
3. Data Transformation - Use DBT to perform data modeling and transform the data into star schema.
4. Data Loading - Use data pipeline to load the extracted and transformed data into GCP BigQuery.
5. Data Reporting/Analytics - Use Metabase to create dashboards for reporting or analytics purposes.

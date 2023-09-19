# Orchestrate Python data Pipeline with Astro, DBT, Soda and Metabase using Airflow on GCP

This project demonstrates how to build and automate an ETL pipeline using DAGs in Airflow and load the transformed data to Bigquery. There are different tools that have been used in this project such as Astro (A docker wrapper around Airflow), DBT (Used for Data Modelling and creating reports using SQL), Soda (Used for Data Quality Checks), Metabase (Containarized Data visualization tool) and Google Cloud Platform for storing the tables.


# Project Goals - To try new tools and learn!

0. There has been a deulge of new tools and technologies in the market accentuating the data engineering field and the best way to keep abreast is to pry them out and do hands-on. So, in this project there are a lot of new tools that I have used to create an effective and robust data pipeline. It goes without saying that when there are more tools involved, the integration of the tools (because of dependencies or much worse "dependency hell" :scream: ) becomes a big hassle but at the same time, it allows us to understand the nitty gritties of the architecture. 

1. Data Ingestion - Create a data ingestion pipeline to extract new incoming data into the GCP BigQuery.
2. Data Quality - Use Soda to create highly customized data quality checks using yml files.
3. Data Transformation - Use DBT to perform data modeling and transform the data into star schema.
4. Data Loading - Use data pipeline to load the extracted and transformed data into GCP BigQuery.
5. Data Reporting/Analytics - Use Metabase to create dashboards for reporting or analytics purposes.

# Data Architecture

The architecture (Data flow) used in this project uses different different tools and languages.

<p align="center">
  <img height="600" src="https://github.com/chayansraj/Orchestrate-Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/c0e1b490-510d-43aa-b34c-9e6ea3c750a5">
  <h6 align = "center" > Source: Author </h6>
</p>


# Dataset Used 
The Online Retail II data set contains all the transactions occurring for a UK-based and registered, non-store online retail between 01/12/2009 and 09/12/2011.The company mainly sells unique all-occasion gift-ware. Many customers of the company are wholesalers.

Dataset link: [Online Retail Dataset](https://www.kaggle.com/datasets/mashlyn/online-retail-ii-uci)

# Tools and technologies used in this project

1. **BigQuery (GCP)** - BigQuery is a fully managed, serverless data warehouse and analytics platform offered by Google Cloud. It is designed for storing and analyzing large datasets in a scalable and cost-effective manner. BigQuery is part of the Google Cloud Platform (GCP) and is often used for a wide range of data processing and analysis tasks, including business intelligence, data warehousing, data exploration, and machine learning.
2. **SODA** - SODA (Scalable Open Data Automation) is a data quality framework and set of tools designed to automate the validation and quality checks of data in a scalable and efficient manner. It is primarily used for checking the quality, integrity, and compliance of large datasets. SODA is not specific to a particular programming language or technology stack and can be applied to various data sources and formats.
3. **DBT** - dbt, short for "Data Build Tool," is an open-source command-line tool and modeling framework for modern data analytics and engineering. It is designed to help data analysts and data engineers manage the transformation and modeling of data within data warehouses. dbt focuses on enabling the transformation and modeling of data in a version-controlled, testable, and maintainable way, similar to software development best practices.
4. **Astro CLI** - The Astro CLI is the command line interface for data orchestration. It is a part of Astronomer suite and enables an easier way to get started with Apache Airflow and can be used with all Astronomer products. One of the Astro CLI's main features is its ability to run Airflow on your local computer. An Astro project contains the set of files necessary to run Airflow, including dedicated folders for your DAG files, plugins, and dependencies.
5. **Metabase** - Metabase is an open-source business intelligence (BI) and data analytics tool that allows organizations to easily visualize and analyze their data. It provides a user-friendly interface for creating charts, dashboards, and reports without requiring deep technical or SQL knowledge. Metabase is designed to make data exploration and reporting accessible to a wide range of users within an organization, including business analysts, data analysts, and non-technical stakeholders.
6. **Visual Code Studio** - Visual Studio Code, often abbreviated as VS Code, is a free, open-source code editor developed by Microsoft. It has become one of the most popular code editors among developers and is widely used for writing and editing code across various programming languages and platforms. VS Code is known for its flexibility, extensive extension marketplace, and a wide range of features that make it suitable for a diverse set of development tasks.
7. **Git Version Control** - Git is a distributed version control system (VCS) that is widely used in software development and other collaborative projects to track changes in source code, documents, and any other types of files. Version control systems like Git help developers and teams manage the history of changes made to a project's files and collaborate effectively on software development and other creative endeavors.

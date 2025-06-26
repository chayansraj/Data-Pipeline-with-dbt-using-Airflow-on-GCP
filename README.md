# Data Pipeline with Astronomer, DBT, Soda and Metabase using Airflow on GCP

This project demonstrates how to build and automate data pipeline using DAGs in Airflow and load the transformed data to Bigquery. There are different tools that have been used in this project such as Astro (A docker wrapper around Airflow), DBT (Used for Data Modelling and creating reports using SQL), Soda (Used for Data Quality Checks), Metabase (Containarized Data visualization tool) and Google Cloud Platform for storing the tables.



# Project Goals - To try new tools and learn!
0. There has been a deluge of new tools and technologies in the market accentuating the data engineering field and the best way to keep abreast is to pry them out and do hands-on. So, in this project there are a lot of new tools that I have used to create an effective and robust data pipeline. It goes without saying that when there are more tools involved, the integration of the tools (because of dependencies or much worse "dependency hell" :scream: ) becomes a big hassle but at the same time, it allows us to understand the nitty gritties of the architecture. 



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
7. **Docker** - Docker is a platform and technology that allows developers to package and distribute applications and their dependencies as lightweight containers. These containers are isolated environments that encapsulate an application and all the libraries, dependencies, and configurations it needs to run. Docker containers provide consistency and portability, making it easier to develop, deploy, and scale applications across different environments, such as development, testing, and production, regardless of the underlying infrastructure.
8. **Git Version Control** - Git is a distributed version control system (VCS) that is widely used in software development and other collaborative projects to track changes in source code, documents, and any other types of files. Version control systems like Git help developers and teams manage the history of changes made to a project's files and collaborate effectively on software development and other creative endeavors.


# Implementation

* **Step 1** - Install Astro CLI and create a working Airflow environment with a GCP connection.
  Astro CLI is like a wrapper around docker that makes it easy to setup Airflow locally and all its components such as Webserver, Scheduler, Database and Trigger. It is a containarized method to create an Airflow server. This step requires you to have docker installed in your system with enabled Hyper-V. After installing [Astro CLI](https://docs.astronomer.io/astro/cli/install-cli?tab=windowswithwinget#install-the-astro-cli), run the following command inside an empty directory:
  ```
  astro dev init
  ```

This command will create a structure of airflow components in your directory, that we used to manually create files earlier. The project foler structure is as shown below:
<p align="center">
  <img width = "250" height="350" src="https://github.com/chayansraj/Orchestrate-Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/1047a4b0-9ccd-4df9-b225-c4f85c183e35">
  <h6 align = "center" > Source: Author </h6>
</p>

After this step, we need to create an account in google cloud with a free tier. Then create a new project with a name of your choice. Make sure to note the project ID and keep it handy as we will use it many different places later on. To let google cloud interact with AIrflow, we need a way to establish a connection and that is done by something called "Service Accounts" in GCP under IAM settings. The connection is between google cloud storage and airflow, so create a storage admin account and a BigQuery admin account in service account settings. Download the key and put it in your 'gcp' folder under 'include' folder. **Do not share it with anyone**


> A connection is a two-way street

Just like google needs to connect to Airflow, same goes to the other side. In Airflow, there is a big community of "providers", think of it as a package that we can install on top of Airflow core to create more functionalities and interact with different softwares. So, in our case, we will install Airflow google provider
```
apache-airflow-providers-google
```
After adding the above command in requirements.txt file, we have to start the docker container which can be done as shown below:
```
astro dev start
```
If everything is good, you can access the airflow UI at localhost:8080 where we will create a GCP connection using the service account credentials, in the airflow include directory as shown below:
<p align="center">
  <img  height="400" src="https://github.com/chayansraj/Orchestrate-Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/154c33b4-fe96-426a-b03c-29d6f233748e">
  <h6 align = "center" > Source: Author </h6>
</p>

* **Step 2** - Create the data pipeline using DAGs in Airflow
A DAG (Directed Acyclic Graph) is a core concept and a fundamental building block. It represents a workflow or a sequence of tasks to be executed, where each task is a unit of work, and the edges between tasks define the order in which they should be executed.
    * First task:
          Here the operators are connection methods that are used in Airflow to write custom code to execute a task for different technologies. Operators define what to execute in each task, and they can range from simple operations like running a Python script to more complex tasks like transferring data between systems or executing SQL queries. Operators are Python classes that encapsulate the logic and parameters required for a specific task.

    ```
    from airflow.decorators import (
    dag,
    task,)
    
    # DAG and task decorators for interfacing with the TaskFlow API
    from datetime import datetime
    from airflow.providers.google.cloud.transfers.local_to_gcs import LocalFilesystemToGCSOperator
    from airflow.providers.google.cloud.operators.bigquery import BigQueryCreateEmptyDatasetOperator
    
    upload_csv_to_gcs = LocalFilesystemToGCSOperator(
    task_id='upload_csv_to_gcs',
    src='/usr/local/airflow/include/dataset/online_retail.csv',
    dst='raw/online_retail.csv',
    bucket='online_retail_database',
    gcp_conn_id='gcp',
    mime_type='text/csv')
    ```


     <p> </p> It's always good to test a task after creating it and so we can do that by running the following command:</p>


    ```
    astro dev bash -> airflow tasks test <DAG name> <Task Name> <Start Date>
    ```
    This should store a file in google cloud storage bucket and marke the task as success with corresponding dag id and task id as shown below:

    <p align="center">
      <img height="35" src="https://github.com/chayansraj/Orchestrate-Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/a5ce63ce-b274-4964-ac96-616950457940">
      <h6 align = "center" > Source: Author </h6>
    </p>

    * Second Task:
      In order to create a SQL table in BigQuery, it should have a "Dataset" in place, within which we can place our relational tables. So this task will create a Dataset inside BigQuery:
      ```
      create_retail_dataset = BigQueryCreateEmptyDatasetOperator(
      task_id='create_retail_dataset',
      dataset_id='retail',
      gcp_conn_id='gcp',)
      ```

    <p align="center">
      <img height="35" src="https://github.com/chayansraj/Orchestrate-Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/1fcca080-524f-4f43-872b-483285f2c58e">
      <h6 align = "center" > Source: Author </h6>
    </p>

    * Thrid Task:
      We use load file operator using atronomer which will store the csv file into a table in BigQuery:
      ```
      gcs_to_raw = aql.load_file(
  
          task_id='gcs_to_raw',
          input_file=File(
              'gs://online_retail_database/raw/online_retail.csv',
              conn_id='gcp',
              filetype=FileType.CSV,
          ),
          output_table=Table(
              name='raw_online_retail',
              conn_id='gcp',
              metadata=Metadata(schema='retail')
          ),
          use_native_support=False,      )
      ```

    <p align="center">
      <img height="390" src="https://github.com/chayansraj/Orchestrate-Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/66e4d94d-9720-4179-9659-3e3ad06b785d">
      <h6 align = "center" > Source: Author </h6>
    </p>

* **Step 3** - You need to register at [soda.io](https://soda.io) to get a connection key to establish connection with BigQuery as our table is stored there. Soda CL can be used to write data quality checks based on your use case. The API key get the credentials to connect soda cloud with airflow, so whenever a check runs, we can see that on our Soda account. Keeping things a bit less complicated, we can setup a simple data type check of each column by writing checks as below:

    <p align="center">
      <img width = "800" height="240" src="https://github.com/chayansraj/Orchestrate-Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/1b0620d9-d3ab-4414-8be5-5576ba1b84b1">
      <h6 align = "center" > Source: Author </h6>
    </p>
get inside the docker container using > astro dev bash   


and run the following command:

```
soda scan -d retail -c include/soda/configuration.yml include/soda/checks/sources/raw_online_retail.yml
```

<p align="center">
  <img width = "800" height="150" src="https://github.com/chayansraj/Orchestrate-Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/180f6af1-4751-4465-97f1-27da9ef96cbc">
  <h6 align = "center" > Source: Author </h6>
</p>
But, if we modigy any check, for example, let's say we purposefuly change the datatype of numeric column to string. It will throw an error.
Now to create data quality check within our DAG, for this, we will use Python external task. This task allows any python code in any external virtual environment to be executed inside the DAG. This will prevent any dependency conflict with any other open source tool you are using. To create a python vistual environment and activate it, we will modify the Dockerfile as follows: 

```
RUN python -m venv soda_venv && source soda_venv/bin/activate && \
    pip install --no-cache-dir soda-core-bigquery==3.0.45 &&\
    pip install --no-cache-dir soda-core-scientific==3.0.45 && deactivate
```
This includes the soda library along with its dependencies to interact with google bigquery. It activates the environment, installs the library and then deactivates it. 
Python external task in DAG:

```
@task.external_python(python='/usr/local/airflow/soda_venv/bin/python')
def check_load(scan_name='check_load', checks_subpath='sources'):
    from include.soda.check_function import check

    return check(scan_name, check_subpath)

check_load()
```

The corresponding 'check_function' that will run in the python environment and will be called from our DAG is in repo files. **Whenever we use a decorator inside our DAG, we need to explicitly call that task inside the DAG**

* **Step 4** - Use DBT to transform the data and create fact and dimension tables.
  This is star schema data modelling in practice where we have a fact table sorrounded by dimension tables. Fact table keeps all the numerical and keys of the database and dimension tables contains context and background information such as product, customer, datetime, etc.
<p align="center">
  <img width = "550" height="290" src="https://github.com/chayansraj/Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/e7b02c6b-262f-463e-abda-6bccc72f6d28">
  <h6 align = "center" > Source: Author </h6>
</p>



  We use cosmos to integrate dbt with airflow, cosmos will allow more information about the processes inside the dbt models. Each model becomes a task inside the DAG providing better obeservability. Cosmos will execute the dbt models inside a virtual python environment, so we create a new virtual environment for the same:

  ```
  RUN python -m venv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir dbt-bigquery==1.5.3 && deactivate
  ```
  All the profile.yml, dbt_project.yml, sources.yml and packages.yml files are uploaded in files section. All the .sql files are also uploaded. After running the dbt models using dbt cli, we can see four tables inside bigquery:

  <p align="center">
  <img width = "700" height="230" src="https://github.com/chayansraj/Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/2cdeb95e-cb9c-4cab-bfd4-5f44ee3341c8">
  <h6 align = "center" > Source: Author </h6>
  </p>

  Now we can integrate dbt models within the DAG for airflow to run that task:
  ```
  transform = DbtTaskGroup(
    group_id = 'transform',
    project_config = DBT_PROJECT_CONFIG,
    profile_config = DBT_CONFIG,
    render_config = RenderConfig(
        load_method = LoadMode.DBT_LS,
        select=['path:models/transform']
    ))
```
With this task implemented, we can go over the airflow UI and check the DAG to see those in a more granular way as shown below:
  <p align="center">
  <img width = "500" height="270" src="https://github.com/chayansraj/Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/0452245e-2fa7-41d0-a30d-2cd95e4dd026">
  <h6 align = "center" > Source: Author </h6>
  </p>
  Similarly, we can implement the same for reporting models using sql and dbt. 

* **Step 5** - We repeat the step 3 to run the data quality checks after we have transformed our data into fact and dimension tables. The quality check files for transformation is given in files section. We create another task in the DAG that will check the transformed tables.

```
@task.external_python(python='/usr/local/airflow/soda_venv/bin/python')
def check_transform(scan_name='check_transform', checks_subpath='transform'):
    from include.soda.check_function import check

    return check(scan_name, checks_subpath)
```
The corresponding 'check_function' that will run in the python environment and will be called from our DAG is in repo files.

Now it's time to create a chain of tasks for airflow to know the direction of tasks to perform squentially. It is done using chain method inside DAGs as shown below:

```
chain(
    upload_csv_to_gcs,
    create_retail_dataset,
    gcs_to_raw,
    check_load(),
    transform,
    check_transform(),
    report,
    check_report(),
)
```

  <p align="center">
  <img width = "800" height="50" src="https://github.com/chayansraj/Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/cf6788d7-227a-48a2-a3da-cbef921ee53a">
  <h6 align = "center" > Source: Author </h6>
  </p>


* **Step 6** - Creating a dashboard using Metabase which is an opensourse data visualization and analytics platform. It will running locally on our machine and runs on localhost. To run metabase, we create a docker-compose override file as shown below:

  ```
  version: "3.1"
  services:
  metabase:
    image: metabase/metabase:v0.46.6.4
    volumes:
      - ./include/metabase-data:/metabase-data
    environment:
      - MB_DB_FILE=/metabase-data/metabase.db
    ports:
      - 3000:3000
    restart: always
  ```
We restart the airflow instance and we can start accessing metabase from localhost:3000. 
Using the tables above and performing data analytics, we can finally create a dashboard.

  <p align="center">
  <img  height="700" src="https://github.com/chayansraj/Python-ETL-Pipeline-with-DBT-using-Airflow-on-GCP/assets/22219089/83498c85-96bb-41b1-b7cc-523e3f8df982">
  <h6 align = "center" > Source: Author </h6>
  </p>


**The End**









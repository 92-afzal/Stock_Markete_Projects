# Data Pipeline Architecture

## Overview
This project defines a modern data engineering pipeline that automates the ingestion, transformation, and visualization of data. It is containerized with **Docker** for consistent deployment across environments.

The pipeline leverages key technologies such as **Kafka**, **S3**, **Snowflake**, **dbt**, **Airflow**, and **Power BI** to enable efficient and scalable data flow from raw sources to business-ready insights.

---

## Architecture Breakdown

### 1. Data Source
- **API**  
  External or internal APIs serve as the primary data source.  
  Data is collected in real time or batch mode, depending on the integration.

### 2. Data Streaming
- **Kafka**  
  Kafka handles the ingestion and streaming of data from the API.  
  It ensures reliable delivery and supports high-throughput, fault-tolerant data flow.

### 3. Data Storage
- **Amazon S3**  
  Kafka streams data into S3 buckets for persistent and cost-effective storage.  
  The data is stored in its raw format, serving as a source of truth for downstream processes.

### 4. Data Warehouse
- **Snowflake**  
  The data warehouse is hosted in Snowflake, where data moves through three stages:
  - **Raw Layer (Bronze):** Unprocessed data ingested directly from S3.  
  - **Cleaned Layer (Silver):** Data that has undergone initial transformations, cleaning, and quality checks.  
  - **Business-Ready Layer (Gold):** Aggregated and modeled data optimized for analytics and reporting.

### 5. Data Processing
- **dbt (Data Build Tool)**  
  dbt manages the transformation workflows in Snowflake.  
  It applies SQL-based transformations, handles model dependencies, and maintains data lineage and testing.

### 6. Orchestration
- **Apache Airflow**  
  Airflow orchestrates the end-to-end workflow — from ingestion to transformation to loading into the warehouse.  
  It schedules and monitors DAGs that coordinate Kafka, S3, dbt, and Snowflake processes.

### 7. Visualization
- **Power BI**  
  Power BI connects to the business-ready data layer in Snowflake.  
  It provides dashboards and visual analytics for end users to explore and monitor key business metrics.

---

## Technology Stack

| Layer | Tool | Purpose |
|-------|------|----------|
| Containerization | Docker | Environment consistency and portability |
| Ingestion | API, Kafka | Real-time or batch data ingestion |
| Storage | AWS S3 | Raw data storage |
| Warehousing | Snowflake | Scalable cloud data warehouse |
| Processing | dbt | Transformations and data modeling |
| Orchestration | Apache Airflow | Workflow automation and scheduling |
| Visualization | Power BI | Data visualization and business reporting |

---

## Data Flow Summary

1. **API** → sends data to **Kafka**.  
2. **Kafka** → streams data into **S3 buckets**.  
3. **S3** → feeds data into **Snowflake (Raw layer)**.  
4. **dbt** → transforms data across Raw → Cleaned → Business Ready layers.  
5. **Airflow** → orchestrates and schedules all pipeline components.  
6. **Power BI** → connects to Snowflake for visualization and reporting.

---

## Deployment

### Prerequisites
- Docker and Docker Compose installed
- Access to AWS S3 and Snowflake accounts
- API credentials for data ingestion
- Power BI access for reporting

### Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/92-afzal/Stock_Markete_Projects.git
   cd Stock_Markete_Projects
   ```

2. **Set up environment variables:**
   Create a `.env` file in the root directory and configure your credentials:
   ```bash
   SNOWFLAKE_USER=<your_username>
   SNOWFLAKE_PASSWORD=<your_password>
   SNOWFLAKE_ACCOUNT=<your_account>
   AWS_ACCESS_KEY_ID=<your_access_key>
   AWS_SECRET_ACCESS_KEY=<your_secret_key>
   API_KEY=<your_api_key>
   ```

3. **Build and run the containers:**
   ```bash
   docker-compose up --build
   ```

4. **Access Airflow UI:**
   - Open [http://localhost:8080](http://localhost:8080)
   - Default credentials: `airflow / airflow`

5. **Trigger the data pipeline DAG** to start ingestion and transformation.

6. **Connect Power BI** to the Snowflake `Business Ready` schema to visualize reports.

---

## Project Structure

```
data-pipeline/
│
├── airflow/                 # Airflow DAGs and configurations
├── dbt/                     # dbt models, seeds, and tests
├── docker-compose.yml       # Docker orchestration
├── scripts/                 # Utility scripts for setup and maintenance
├── requirements.txt         # Python dependencies
├── .env.example             # Example environment configuration
└── README.md                # Project documentation
```

---

## Future Enhancements

- Add automated data quality checks (e.g., Great Expectations)
- Implement real-time analytics via Kafka Streams or Flink
- Integrate CI/CD for dbt and Airflow pipelines

---

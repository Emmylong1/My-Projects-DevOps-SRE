 # Temperature Data Collection and Storage Infrastructure
This project is dedicated to designing, implementing, and maintaining a robust and scalable infrastructure for temperature data collection and storage. The system is containerized for portability and ensures high availability and reliability.

## Table of Contents
1. [Containerization](#containerization)
2. [Temperature Scraper](#temperature-scraper)
3. [Cloud Infrastructure](#cloud-infrastructure)
4. [Data Storage](#data-storage)
5. [Monitoring and Logging](#monitoring-and-logging)
6. [Documentation](#documentation)
7. [Deployment](#deployment)

## Install Required Tools
### Docker & Docker-Compose
Install Docker by following the instructions <a href="https://docs.docker.com/engine/install/">here.</a>
Install Docker-compose by following the instructions <a href="https://docs.docker.com/compose/install/linux/">here.</a>
### Terraform
Install Terraform by following the instructions <a href="https://developer.hashicorp.com/terraform/install?product_intent=terraform">here.</a>
### Python
Install Python by following the instructions <a href="https://www.python.org/downloads/.">here.</a>



## Containerization

### Dockerized Applications
- To containerize  a temperature scraper application that collects temperature data (in °C) for Zurich,
London, Miami, Tokyo, and Singapore, the first step is setting up a suitable environment. 
- The second step is to begin writing your Dockerfile for the temperature scraper application. After completing your Dockerfile, proceed to build & run your application using the command:
```bash
docker build -t your_image_name .
docker run -d --name your_container_name your_image_name
```

## Temperature Scraper
### Setup
- Requires Python 3.6 or higher.
- Dependencies can be installed using pip install -r requirements.txt.
- Obtain necessary API keys for accessing the wttr.in API.
 
### Implementation
- Application consists of scraper.py for data retrieval and scheduler.py for scheduling tasks.
- Dependencies include requests for HTTP requests and schedule for task scheduling.
### Functionality
- Scraper script retrieves temperature data from wttr.in for specified cities.
- Scheduler ensures periodic execution of the scraper script.
### Deployment
- Configure environment variables for API keys.
- Deploy the application to a suitable hosting environment in my case i'm using Kubernetes as my hosting environment, ensuring continuous execution of the scheduler.
## Cloud Infrastructure


### AWS Setup
- Set up the required infrastructure on AWS for hosting the containerized applications.
- Configured auto-scaling and load balancing for high availability.

## Data Storage

### Relational Database
- Set up an instance of a relational database (e.g., Amazon RDS with PostgreSQL) to store incoming temperature data efficiently.
- first thing you have to do is to spin up an instance for your database using terraform. 
- Next is to SSH into your EC2 instance using the following command: 
 ```bash
ssh -i your-key.pem ubuntu@your-ec2-ip
```
- Next, you have to follow the instructions given <a href="https://www.postgresql.org/download/linux/ubuntu/.">below.</a>or <a href="https://emmanuelibok505.medium.com/setting-up-a-postgresql-database-and-designing-an-appropriate-schema-915474a1e842/.">Documentation.</a> to install the PostgreSQL database on your EC2 instance. 

- Designed an appropriate schema for the data storage.
- You can check out my <a href="https://emmanuelibok505.medium.com/setting-up-a-postgresql-database-and-designing-an-appropriate-schema-915474a1e842/.">article.</a>

### Kafka Integration
- Created a consumer to read data from Kafka and store it in the database.

### IPFS Storage
- Set up data storage on IPFS to store measurement data points and retrieve the location for public access.

## Monitoring and Logging

### Implementation
- Implemented a monitoring and logging solution to track the health and performance of the entire system.
- First is to set up a machine on any of the cloud provider of your chioce that you want make use off.
- Here is the bash script to install prometheus and grafana                                           

## Documentation

### Infrastructure Setup
- Documented the entire infrastructure setup, including instructions for deployment, scaling, and troubleshooting.

## Deployment

### Deployment Process
- Sketched a deployment process that allows for seamless updates and rollbacks.

## Repository Structure
The GitHub repository contains all the code and configuration files required for the infrastructure setup.

## Final Deliverable
The final deliverable is a GitHub repository containing all the aforementioned points. For detailed documentation and troubleshooting, please refer to the repository.

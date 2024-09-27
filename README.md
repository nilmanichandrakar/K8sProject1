# Robot Framework Automation with Kubernetes, Grafana, and MariaDB

This project demonstrates how to use Robot Framework to automate the setup and validation of data flow between MariaDB and Grafana in a local Kubernetes environment.

## Table of Contents
1. Prerequisites
2. Project Structure
3. Setup Local Kubernetes
4. Deploy Grafana and MariaDB
5. Python Project with Robot Framework
    1. Load Data into MariaDB
    2. Connect to Grafana
    3. Configure Data Source
    4. Create Dashboard
    5. Validate Data
6. Running the Automation
7. Conclusion

### Prerequisites
* Docker Desktop with Kubernetes Enabled or Minikube
* Helm (Package Manager for Kubernetes)
* kubectl (Kubernetes Command-Line Tool)
* Python 3.10+ and pip
* Robot Framework and Libraries (robotframework, robotframework-requests, robotframework-databaselibrary, pymysql)
* Grafana API Key with necessary permissions
* MariaDB Docker image

### Project Structure
``` .
├── GRAFANA-TEST/                   # Kubernetes manifests and Helm charts
│   ├── grafana-deployment.yaml              # Grafana Deployment & Service
│   ├── mariadb-deployment.yaml              # MariaDB Deployment & Service
│   ├── insert-data-job.yaml                 # Intert Data job
|   ├── insert_data.py                       # Python script to insert data into MariaDB
|   └──insert_data.py
|   ├── Dockerfile                    # Dockerfile for insert data into Maraidb
├── tests/
│   ├── insert_data.robot
│   ├── grafana_setup.robot
│   ├── validate_dashboad.robot  
│   ├── keywords.robot             # Robot Framework combined keywords
│   └── grafana-tests.robot        # Robot Framework combined test cases
├── Dockerfile                    # Dockerfile for Robot Framework automation
├── requirements.txt              # Python dependencies
└── README.md                     # Project documentation
```
### Setup Local Kubernetes
#### 1. Start Local Kubernetes Cluster:
```bash
  $ minikube start
```
#### 2. Verify kubernetes cluster
```bash
  $ kubectl get nodes
```
### Deploy Grafana and MariaDB
#### 1. Deploy MariaDB:
```bash
  ~/grafana-test$ kubectl apply -f mariadb-deployment.yaml
```
#### 2. Deploy Grafana:
```bash
 ~/grafana-test$ kubectl apply -f grafana-deployment.yaml
```
#### 3. Verify Deployments:
```bash
 ~/grafana-test$ kubectl get pods
```
Ensure that both Grafana and MariaDB pods are in a ```Running``` state.
#### 4. Verify services:
```bash
 ~/grafana-test$ kubectl get services
```
#### 5. Grafana service port-forwad:
```bash
~/grafana-test$ kubectl port-forward svc/grafana-service 3000:3000
```
Ensure that grafana page ```http://localhost:3000/``` is accessible.

### Python Project with Robot Framework
#### 1. Load Data into MariaDB
  * Use the insert_data.py script to insert known data into a table in MariaDB.
  * This script connects to the MariaDB service in your Kubernetes cluster and populates the measurements table with random data.
#### 2. Connect to Grafana
  ##### 2.1 Configure Data Source
  * Create a Grafana data source configuration using the Robot Framework ```RequestsLibrary``` Library. 
  * Use the Grafana API to configure a MySQL data source that connects to the MariaDB instance.
  ##### 2.2 Create Dashboard
  * Create a Grafana dashboard using the Grafana API with a Timeseries Visualization.
  * The visualization will query data from the ```measurements``` table in MariaDB.
#### 3. Validate Data
 * Use Robot Framework to validate that the data displayed in the Grafana dashboard matches the data inserted into the MariaDB table.

### Running the Automation
1. Install Python Dependencies:
  ```bash
  pip install -r requirements.txt
```
2. Run Robot Framework Tests in vscode:
  ``` bash
  robot tests/grafana_tests.robot
```
4. Check Test Results:
* The test results will be stored in the output directory as HTML and XML files.
* Open the ```log.html``` file to view detailed test results.

### Grafana Dashboard Snapshots
![image](https://github.com/user-attachments/assets/29838546-279a-4a5a-b930-e75580bfe6b7)

![image](https://github.com/user-attachments/assets/25e34098-a48e-42ca-88fe-a8bc7b474ee6)

![image](https://github.com/user-attachments/assets/2e707eb8-26ad-4077-ba8c-48a680982454)





### Conclusion
This project automates the setup and verification of data between MariaDB and Grafana, demonstrating the power of Robot Framework for testing in a Kubernetes environment. The automation can be extended to cover more test scenarios and data validations.

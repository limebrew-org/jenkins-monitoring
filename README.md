# jenkins-monitoring
Monitoring Jenkins with Prometheus and Grafana

![Grafana-Dashboard](images/grafana-dashboard.png)

## Pre-Requisites:
The pre-requisites for this project is having Docker and Docker Compose

## Setup:
To setup the project, follow the steps below:

### Clone Repository:
Clone the repository using git:

        git clone git@github.com:limebrew-org/jenkins-monitoring.git

### Jenkins Setup:
- Setup Jenkins locally using Docker Compose:

        docker-compose up -d jenkins

![Jenkins](images/terminal-jenkins.png)

- Setup the admin password by exec into the docker container or via docker logs

        docker exec -it jenkins sh

        cat /var/jenkins_home/secrets/initialAdminPassword

- Install the recommended plugins and setup admin password

- Now once everything is setup, Navigate to `Manage Jenkins` > `Plugins` > `Available` and then search for the two plugins:

![Plugins](images/jenkins-plugins.png)

- Choose the 2 plugins and install and then restart Jenkins once downloaded.

- Once Jenkins restarts, the logs will be visible at `localhost:8080/prometheus/`

![Jenkins-Logs](images/jenkins-logs.png)

- You can configure prometheus by navigating to `Manage Jenkins` > `System` > `Prometheus`

![Jenkins-System](images/jenkins-system-config.png)


### Prometheus Setup:
- Setup prometheus locally using Docker Compose:

        docker-compose up -d prometheus

- Prometheus server will be running at `localhost:9090`

![Prometheus-UI](images/prometheus-ui.png)

- The configuration file for prometheus is available at `./prometheus/prometheus.yml` in the repo.

![Prometheus-Config](images/prometheus-config.png)

- The `prometheus.yml` have the configuration to connect to Jenkins via http and listens to the logs at `jenkins_ip:8080/prometheus/`

N.B. If you already have jenkins running on a remote machine, change in the `targets` under `static_configs` in `./prometheus/prometheus.yml`

        - job_name: jenkins
            honor_timestamps: true
            metrics_path: /prometheus/
            follow_redirects: true
            static_configs:
            - targets:
                - jenkins_ip_or_domain_name:8080

### Grafana Setup:
- Setup Grafana locally using Docker Compose:

        docker-compose up -d grafana

- Grafana server will be running at `localhost:3000`

![Grafana-UI](images/grafana-ui.png)

- Authenticate to Grafana via the `username` and `password` which is set in `docker-compose.yml`

- Once done, click on the `Toggle Menu` in the top left corner > `Connections` > `Datasources`. The `Prometheus Jenkins` data source will be automatically visible. This is done via creating the datasource on container creation process from the grafana config file at `./grafana/datasource.yml`

![Prometheus-Datasource](images/grafana-datasource.png)

- Now import a public dashboard template from `https://grafana.com/grafana/dashboards/?search=jenkins`
You can try the following Dashboard templates

        a. Jenkins: Performance and Health Overview: https://grafana.com/grafana/dashboards/9964-jenkins-performance-and-health-overview/

        b. https://grafana.com/grafana/dashboards/9524-jenkins-performance-and-health-overview/

Copy the dashboard template ID and paste it during import, then choose the `datasource` as `Prometheus Jenkins`.

![Grafana-Dashboard-Import](images/grafana-dashboard-import.png)

- Once done, you can view the dashboard in Grafana.

![Grafana-Dashboard](images/grafana-dashboard.png)

- Dont forget to save it in `dashboards` folder inside `grafana`
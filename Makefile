jenkins_up:
	docker-compose up -d jenkins

jenkins_down:
	docker-compose down jenkins

prometheus_up:
	docker-compose up -d prometheus

prometheus_down:
	docker-compose down prometheus

grafana_up:
	docker-compose up -d grafana

grafana_down:
	docker-compose down grafana
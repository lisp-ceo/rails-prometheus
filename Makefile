release:
	make build && make tag && make push
tag:
	docker tag rails-prometheus johncena/rails-prometheus
push:
	docker push johncena/rails-prometheus
build:
	docker build -t rails-prometheus .
run:
	docker run --rm -p 3000:80 johncena/rails-prometheus:latest
run_lcl:
	docker run --rm -p 80:3000 -v "$PWD":/usr/src/app -w /usr/src/app johncena/rails-prometheus:latest
run_prod:
	docker run --rm -p 3000:80 -e RAILS_ENV='production' \
	-e RAILS_LOG_TO_STDOUT='true' \
	-e SECRET_KEY_BASE='320e0c0a905c6f641b3a2455b972ceb85b3ea9b49d77c8aaf7f816a2d8e55f3698cf9ca7d03c58637ada02b670a49163c23b0b8d923a537b78f88b2a75147ee9' \
	-e RAILS_SERVE_STATIC_FILES='true' \
	rails-prometheus
run_prod_shell:
	docker run --rm -it -p 3000:80 -e RAILS_ENV='production' \
		-e RAILS_LOG_TO_STDOUT='true' \
		-e SECRET_KEY_BASE='320e0c0a905c6f641b3a2455b972ceb85b3ea9b49d77c8aaf7f816a2d8e55f3698cf9ca7d03c58637ada02b670a49163c23b0b8d923a537b78f88b2a75147ee9' \
		-e RACK_ENV='production' rails-prometheus /bin/bash
install_prom:
	GO15VENDOREXPERIMENT=1 go get github.com/prometheus/prometheus/cmd/...
install_am:
	GO15VENDOREXPERIMENT=1 go get github.com/prometheus/alertmanager/cmd/...
rails_lcl:
	RAILS_ENV=development bundle exec rails s
prom_lcl:
	prometheus -config.file=prometheus.yml
am_lcl:
	alertmanager -config.file=alertmanager.yml
check_alert_rule:
	promtool check-rules
example_alert:
	curl -H "Content-Type: application/json" -d '[{"labels":{"alertname":"TestAlert1"}}]' localhost:9093/api/v1/alerts

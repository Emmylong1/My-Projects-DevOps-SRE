#!/bin/bash -e

PROMETHEUS_VERSION="2.32.1"
NODE_EXPORTER_PORT="9100"
NODE_EXPORTER_INSTANCE_IP="18.222.117.31"

cd /tmp

curl -LO "https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"

sudo useradd --no-create-home --shell /bin/false prometheus

tar -xzf "prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"
sudo mv "prometheus-${PROMETHEUS_VERSION}.linux-amd64/prometheus" /usr/local/bin/
sudo mv "prometheus-${PROMETHEUS_VERSION}.linux-amd64/promtool" /usr/local/bin/

sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool

sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

sudo mv "prometheus-${PROMETHEUS_VERSION}.linux-amd64/consoles" /etc/prometheus
sudo mv "prometheus-${PROMETHEUS_VERSION}.linux-amd64/console_libraries" /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus

sudo tee /etc/prometheus/prometheus.yml > /dev/null <<EOF
global:
  scrape_interval: 15s
  evaluation_interval: 15s

alerting:
  alertmanagers:
    - static_configs:
        - targets: []

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ['${NODE_EXPORTER_INSTANCE_IP}:${NODE_EXPORTER_PORT}']
EOF
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl start prometheus


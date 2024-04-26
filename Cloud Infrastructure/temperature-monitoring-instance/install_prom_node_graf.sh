#!/bin/bash

# Function to install Prometheus
install_prometheus() {
    echo "Installing Prometheus..."
    sudo apt-get update && sudo apt-get install -y gnupg2 curl
    curl -sSL https://packages.grafana.com/gpg.key | sudo apt-key add -
    echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
    sudo apt-get update
   
    sudo apt-get install -y prometheus
}

# Function to install Node Exporter
install_node_exporter() {
    echo "Installing Node Exporter..."
    wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
    tar xvfz node_exporter-1.2.2.linux-amd64.tar.gz
    sudo mv node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin/
    sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF
    sudo systemctl daemon-reload
    sudo systemctl enable node_exporter
    sudo systemctl start node_exporter
}

# Function to install Grafana
install_grafana() {
    echo "Installing Grafana..."
    # Add Grafana repository and key
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
    wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
    sudo apt-get update
   
    sudo apt-get install -y grafana
}

# Main function
main() {
    install_prometheus
    install_node_exporter
    install_grafana
    echo "Prometheus, Node Exporter, and Grafana installed successfully."
}

# Execute the main function
main

exit 0

#!/bin/bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_node_exporter() {
    wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
    
    tar -xvf node_exporter-1.2.2.linux-amd64.tar.gz
    
    sudo mv node_exporter-1.2.2.linux-amd64/node_exporter /usr/local/bin/
    
    rm -rf node_exporter-1.2.2.linux-amd64.tar.gz node_exporter-1.2.2.linux-amd64
    
    cat << EOF | sudo tee /etc/systemd/system/node_exporter.service
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
    sudo systemctl start node_exporter
    sudo systemctl enable node_exporter
}

main() {
    if ! command_exists wget; then
        echo "Error: wget is not installed. Please install wget and rerun this script."
        exit 1
    fi

    if command_exists node_exporter; then
        echo "Node Exporter is already installed."
        exit 0
    fi

    install_node_exporter

    echo "Node Exporter has been successfully installed and started."
}

main

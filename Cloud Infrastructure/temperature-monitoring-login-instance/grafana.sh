#!/bin/bash -e

# Grafana installation
GRAFANA_REPO="https://packages.grafana.com/oss/deb"
GRAFANA_KEY_URL="https://packages.grafana.com/gpg.key"
sudo apt-get update
sudo apt-get install -y apt-transport-https software-properties-common wget
wget -q -O - "${GRAFANA_KEY_URL}" | sudo apt-key add -
sudo add-apt-repository "deb ${GRAFANA_REPO} stable main"
sudo apt-get update
sudo apt install grafana -y
sudo systemctl start grafana-server

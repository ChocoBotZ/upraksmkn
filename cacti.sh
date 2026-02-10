#!/bin/bash
# CACTI via APT Debian 12 - SUPER CEPAT!
set -e

echo "🚀 Installing CACTI via APT (No 404 error)..."

# Update + Install CACTI langsung
sudo apt update
sudo apt install -y cacti cacti-spine

# Auto-config database saat install (pilih: mysql, password: cacti123)
sudo dpkg-reconfigure cacti

# SNMP untuk router/server
sudo sed -i "s/#rocommunity public/rocommunity public/" /etc/snmp/snmpd.conf
sudo systemctl restart snmpd && sudo systemctl enable snmpd

# Permissions
sudo chown -R www-data:www-data /usr/share/cacti
sudo chmod -R 755 /usr/share/cacti

echo "✅ CACTI Selesai via APT!"
echo "🌐 http://192.168.30.10/cacti"
echo "👤 Login: admin / admin"

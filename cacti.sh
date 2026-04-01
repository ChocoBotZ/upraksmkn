#!/bin/bash
# CACTI via APT Debian 12 - SUPER CEPAT!
set -e

echo "🚀 Installing CACTI via APT (No 404 error)..."

# Update + Install CACTI langsung
sudo apt update
sudo apt install cacti snmp snmpd rrdtool -y

CONF="/etc/snmp/snmpd.conf"

# 1. Hapus baris agentAddress dan rocommunity yang lama
sed -i '/agentAddress/d' $CONF
sed -i '/rocommunity/d' $CONF

# 2. Tambahkan konfigurasi baru
echo "agentAddress udp:161" >> $CONF
echo "rocommunity public" >> $CONF

# 3. Restart layanan snmpd
systemctl restart snmpd

echo "SNMP Berhasil diubah ke: public"

# Permissions
sudo chown -R www-data:www-data /usr/share/cacti
sudo chmod -R 755 /usr/share/cacti

echo "✅ CACTI Selesai via APT!"
echo "🌐 http://192.168.30.10/cacti"
echo "👤 Login: admin / admin"

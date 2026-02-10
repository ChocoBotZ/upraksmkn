#!/bin/bash
# CACTI Monitoring Debian 12 - monitor.lab-smk.xyz (Ganti Prometheus)
# IP: 192.168.30.10 | Router: 192.168.30.1

set -e

echo "🚀 Installing CACTI Monitoring..."

# Install Cacti + dependencies
sudo apt update
sudo apt install -y apache2 mariadb-server php php-mysql php-snmp php-gd php-ldap php-net-socket php-xml php-zip php-mbstring snmp snmpd rrdtool wget

# Secure MariaDB
sudo mysql_secure_installation <<< "y$n$n$n$n$y"  # Auto-yes, no password

# Create Cacti Database
sudo mysql -e "
CREATE DATABASE cacti;
CREATE USER 'cacti'@localhost IDENTIFIED BY 'cacti123';
GRANT ALL ON cacti.* TO 'cacti'@localhost;
FLUSH PRIVILEGES;
"

# Download & Install Cacti
cd /tmp
wget https://files.cacti.net/cacti/latest/cacti-latest.tar.gz
tar -xzf cacti-latest.tar.gz
sudo rsync -av cacti/ /var/www/html/

# Import Cacti SQL schema
sudo mysql -u cacti -pcacti123 cacti < /var/www/html/cacti/cacti.sql

# Cacti Config
sudo cp /var/www/html/cacti/include/config.php.sample /var/www/html/cacti/include/config.php
sudo sed -i "s/\$database_password = '';/\$database_password = 'cacti123';/" /var/www/html/cacti/include/config.php

# Apache Config untuk Cacti
sudo a2enmod rewrite
cat > /etc/apache2/sites-available/cacti.conf << 'EOF'
<VirtualHost *:80>
    ServerName monitor.lab-smk.xyz
    DocumentRoot /var/www/html/cacti
    <Directory /var/www/html/cacti>
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog ${APACHE_LOG_DIR}/cacti_error.log
    CustomLog ${APACHE_LOG_DIR}/cacti_access.log combined
</VirtualHost>
EOF

sudo a2ensite cacti.conf
sudo a2dissite 000-default.conf  # Disable default site
sudo systemctl restart apache2

# SNMP Config (untuk monitor router/server)
sudo sed -i "s/#rocommunity public/rocommunity public/" /etc/snmp/snmpd.conf
sudo systemctl restart snmpd
sudo systemctl enable snmpd

# Set permissions
sudo chown -R www-data:www-data /var/www/html/cacti
sudo chmod -R 755 /var/www/html/cacti

# Start services
sudo systemctl enable apache2 mariadb snmpd

echo "✅ CACTI Selesai!"
echo "🌐 Akses: http://192.168.30.10/cacti atau http://monitor.lab-smk.xyz"
echo "👤 Login pertama: admin / admin atau cacti cacti123"
echo "📊 Tambah device:"
echo "  1. Console → Create Devices → router (192.168.30.1)"
echo "  2. Create Graphs → CPU / Memory"

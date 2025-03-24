#!/usr/bin/env bash

# Shell Options
set -o errexit   # Exit immediately on non-zero command status
set -o xtrace    # Trace all commands

# System Update
dnf -y upgrade

# Install System Packages
dnf -y install httpd wget cowsay python3 python3-pip php stress
pip3 install random-cat
systemctl enable --now httpd

# Custom Random Web Page
bgcolor=$(printf "%02x%02x%02x\n" $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
instanceId=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
wget -O /var/www/html/cat.gif "http://thecatapi.com/api/images/get?format=src&type=gif&api_key=8f7dc437-0b9b-47b8-a2c0-65925d593acf"
cat << EOF > /var/www/html/index.php
<html><head>
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
</head><body style="background-color:#$bgcolor;">
<center><h1>Instance ID : $instanceId</h1></center><br>
<center><img src="cat.gif?nocache=<?php echo time(); ?>">
</body></html>
EOF

# Permissions 
usermod -a -G apache ec2-user   
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

# Cowsay MoTD
echo "#!/bin/sh" > /etc/update-motd.d/40-cow
echo 'cowsay "Amazon Linux 2 AMI - Animals4Life"' > /etc/update-motd.d/40-cow
chmod 755 /etc/update-motd.d/40-cow
rm /etc/update-motd.d/30-banner
update-motd


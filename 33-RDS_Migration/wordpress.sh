#!/usr/bin/env bash

# Shell Options
set -o errexit   # Exit immediately on non-zero command status
set -o xtrace    # Trace all commands

# Pull Config Parameters from SSM
DBName=$(aws ssm get-parameter --name '/saa/a4l/db_name' --query 'Parameter.Value' --output 'text')
DBUser=$(aws ssm get-parameter --name '/saa/a4l/db_user' --query 'Parameter.Value' --output 'text')
DBPassword=$(aws ssm get-parameter --name '/saa/a4l/db_pass' --with-decryption --query 'Parameter.Value' --output 'text')

# Install Required Packages
dnf install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel cowsay -y

# Web and DB Services
systemctl enable --now httpd

# Install Wordpress
wget http://wordpress.org/latest.tar.gz -P /var/www/html
cd /var/www/html
tar -zxvf latest.tar.gz
cp -rvf wordpress/* .
rm -R wordpress
rm latest.tar.gz

# Configure Wordpress
cp ./wp-config-sample.php ./wp-config.php
sed -i "s/'database_name_here'/'$DBName'/g" wp-config.php
sed -i "s/'username_here'/'$DBUser'/g" wp-config.php
sed -i "s/'password_here'/'$DBPassword'/g" wp-config.php
sed -i "s/'localhost'/'${ec2_db_dns}'/g" wp-config.php

# Set User and Directory Permissions
usermod -a -G apache ec2-user   
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

# Setup MOTD
echo "#!/bin/sh" > /etc/update-motd.d/40-cow
echo 'cowsay "Amazon Linux 2023 AMI - Animals4Life"' >> /etc/update-motd.d/40-cow
chmod 755 /etc/update-motd.d/40-cow
update-motd

# Install CloudWatch Agent
dnf install amazon-cloudwatch-agent -y

# Retrieve Config from SSM
mkdir -p /usr/share/collectd/
touch /usr/share/collectd/types.db
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:/saa/a4l/cw_agent_config -s


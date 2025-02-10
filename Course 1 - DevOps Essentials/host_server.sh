#!/bin/bash

# Define cron file path
CRON_FILE="/etc/cron.d/automation"

# Check if cron job file exists, if not, create it
if [ ! -f "$CRON_FILE" ]; then
    echo "Cron file for root does not exist, creating..."
    touch "$CRON_FILE"
    echo "@daily root /root/Automation_Project/automation.sh" >> "$CRON_FILE"
fi

# Define S3 bucket name
s3_bucket="task2-s3bucket"

# Update package list
echo "Updating system packages..."
apt-get update -y

# Check if Apache is installed, install if missing
if ! dpkg -l | grep -q apache2; then
    echo "Installing Apache Server..."
    apt-get install apache2 -y
else
    echo "Apache2 is already installed"
fi

# Ensure Apache service is running
if ! systemctl is-active --quiet apache2; then
    echo "Starting Apache service..."
    systemctl start apache2
else
    echo "Apache2 service is already running"
fi

# Create a timestamp for log naming
timestamp=$(date '+%d%m%Y-%H%M%S')
name="Jasleen"
tar_file_name="$name-httpd-logs-$timestamp.tar.gz"

# Archive Apache logs
echo "Creating log archive: $tar_file_name"
tar -zcvf "/tmp/$tar_file_name" /var/log/apache2/*.log

# Copy archive to S3
if aws s3 cp "/tmp/$tar_file_name" "s3://$s3_bucket/$tar_file_name"; then
    echo "Log file successfully uploaded to S3."
else
    echo "Error: Failed to upload log file to S3."
fi

# Define inventory file path
inventory_file="/var/www/html/inventory.html"

# Check if inventory file exists, create it if missing
if [ ! -f "$inventory_file" ]; then
    echo "Creating inventory.html file..."
    touch "$inventory_file"
    echo -e "Log Type\tTime Created\t\tType\tSize" > "$inventory_file"
fi

# Get log file size
log_size=$(du -h "/tmp/$tar_file_name" | awk '{print $1}')

# Append log details to inventory
echo -e "httpd-logs\t$timestamp\tTar\t$log_size" >> "$inventory_file"

echo "Script execution completed successfully."

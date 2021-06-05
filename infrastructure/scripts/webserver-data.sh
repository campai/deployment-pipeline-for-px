#!/bin/bash

sudo apt-get update -y
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo bash -c "echo 'it is working' > /var/www/html/index.html"

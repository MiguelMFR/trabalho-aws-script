#!/bin/bash

LOG_FILE="/var/log/setup.log"
NOME="Miguel"

yum update -y | tee -a $LOG_FILE

yum install -y httpd | tee -a $LOG_FILE
systemctl start httpd | tee -a $LOG_FILE
systemctl enable httpd | tee -a $LOG_FILE

yum install -y git | tee -a $LOG_FILE
git clone https://github.com/MiguelMFR/trabalho-aws-index.git /var/www/html/ | tee -a $LOG_FILE

chown -R apache:apache /var/www/html | tee -a $LOG_FILE

curl -X POST -d "nome=$NOME" https://difusaotech.com.br/lab/aws/index.php

echo "Setup concluído!" | tee -a $LOG_FILE



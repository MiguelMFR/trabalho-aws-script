#!/bin/bash

LOG_FILE="/var/log/setup.log"

# Atualiza os pacotes
yum update -y | tee -a $LOG_FILE

# Instala o Apache (httpd), Git e Curl
yum install -y httpd git curl | tee -a $LOG_FILE

# Inicia e habilita o Apache (httpd)
systemctl start httpd | tee -a $LOG_FILE
systemctl enable httpd | tee -a $LOG_FILE

# Clona o repositório com o site
git clone https://github.com/MiguelMFR/trabalho-aws-index.git /var/www/html/ | tee -a $LOG_FILE

# Define permissões
chown -R apache:apache /var/www/html/
chmod -R 755 /var/www/html/

sleep 10
# Envia solicitação POST
curl -X POST -d "nome=Miguel Ferreira" https://difusaotech.com.br/lab/aws/index.php | tee -a $LOG_FILE

echo "Setup concluído!" | tee -a $LOG_FILE

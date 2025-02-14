#!/bin/bash

LOG_FILE="/var/log/setup.log"

# Atualiza os pacotes
apt update -y | tee -a $LOG_FILE
apt install -y apache2 git curl | tee -a $LOG_FILE

# Inicia e habilita o Apache
systemctl start apache2 | tee -a $LOG_FILE
systemctl enable apache2 | tee -a $LOG_FILE

# Clona o repositório com o site
git clone https://github.com/MiguelMFR/trabalho-aws-index.git /var/www/html/ | tee -a $LOG_FILE

# Define permissões
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Envia solicitação POST
curl -X POST -d "nome=Miguel" https://difusaotech.com.br/lab/aws/index.php | tee -a $LOG_FILE

echo "Setup concluído!" | tee -a $LOG_FILE

#!/bin/bash

LOG_FILE="/var/log/setup.log"

# Atualiza os pacotes
sudo yum update -y | tee -a $LOG_FILE

# Instala Apache (httpd), Git e Curl
sudo yum install -y httpd git curl | tee -a $LOG_FILE

# Inicia e habilita o Apache (httpd)
sudo systemctl start httpd | tee -a $LOG_FILE
sudo systemctl enable httpd | tee -a $LOG_FILE

# Clona o repositório com o site
git clone https://github.com/MiguelMFR/trabalho-aws-index.git /var/www/html/ | tee -a $LOG_FILE

# Verifica se os arquivos foram baixados corretamente
ls -lah /var/www/html/ | tee -a $LOG_FILE

# Define permissões para o Apache
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/

# Aguarda um tempo para o Apache iniciar corretamente
sleep 15

# Envia solicitação POST e exibe detalhes para depuração
curl -X POST -d "nome=Miguel Ferreira" https://difusaotech.com.br/lab/aws/index.php --verbose | tee -a $LOG_FILE

echo "Setup concluído!" | tee -a $LOG_FILE

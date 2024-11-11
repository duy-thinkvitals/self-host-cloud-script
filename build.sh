#!/bin/bash

sudo apt update && sudo apt upgrade -y

wait

# Install maven
sudo apt install -y maven

wait

# Install nginx
sudo apt install nginx -y 
sudo systemctl start nginx 
sudo systemctl enable nginx
sudo systemctl status nginx
sudo ufw allow 'Nginx Full'

wait

# Install Docker and Docker Compose
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

wait

# Install SSL
sudo apt install certbot python3-certbot-nginx -y
sudo nano /etc/nginx/sites-available/[subdomain].taviewear.com

sudo ln -s /etc/nginx/sites-available/[subdomain].taviewear.com /etc/nginx/sites-enabled/

sudo certbot --nginx -d cloud-gateway.taviewear.com

sudo certbot renew --dry-run

wait 

# Install GIT
git sudo apt install git -y
git --version
git config --global user.name “username”
git config --global user.email “email@domain.com”
ssh-keygen -t ed25519 -C “email@domain.com”
eval "$(ssh-agent -s)" 
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com
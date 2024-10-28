#!/bin/bash
#Author: DuongDT
set -x
# Tao thu muc ssl nginx ca copy cert vao
sudo mkdir -p /etc/nginx/ssl
cp createcert/ca.crt /etc/nginx/ssl/
cp createcert/wildcard.crt /etc/nginx/ssl/
cp createcert/wildcard.key /etc/nginx/ssl/
#cai dat nginx
sudo yum install nginx -y

# Duong dan den file cau hinh nginx
CONFIG_FILE="/etc/nginx/nginx.conf"
#Thay the noi dung file cau hinh nginx
NEW_CONFIG="user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    log_format main '\$remote_addr - \$remote_user [\$time_local] \"\$request\" '
                    '\$status \$body_bytes_sent \"\$http_referer\" '
                    '\"\$http_user_agent\" \"\$http_x_forwarded_for\"';

    access_log /var/log/nginx/access.log main;

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;

    

    
    server {
        listen 443 ssl;
        server_name jenkins.mylabpoc.local;
        
        ssl_certificate /etc/nginx/ssl/wildcard.crt;
        ssl_certificate_key /etc/nginx/ssl/wildcard.key;
        ssl_trusted_certificate /etc/nginx/ssl/ca.crt;

        location / {
            proxy_pass http://localhost:8080;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;
            proxy_ssl_name \$host;
            proxy_set_header Host \$host;
            proxy_ssl_server_name on;
        }
    }

    server {
        listen 80;
        server_name jenkins.mylabpoc.local;
        return 301 https://\$host\$request_uri;
    }
}
"
#ghi de noi dung vao tep cau hinh
echo "$NEW_CONFIG" > "$CONFIG_FILE"
sudo systemctl restart nginx
#cau hinh jenkins chay qua proxy
JENKINS_CONFIG_FILE="/etc/sysconfig/jenkins"
NEW_CONFIG='JENKINS_ARGS="--httpListenAddress=127.0.0.1"'
if [ ! -f "$JENKINS_CONFIG_FILE" ]; then
    
    echo "$NEW_CONFIG" > "$JENKINS_CONFIG_FILE"
else
    
    echo "$NEW_CONFIG" > "$JENKINS_CONFIG_FILE"
fi
systemctl restart jenkins
sudo systemctl restart nginx
systemctl stop firewalld
systemctl disable firewalld
systemctl mask firewalld

# Sao luu cau hinh SE linux
CONFIG_FILE="/etc/selinux/config"
if [[ -f $CONFIG_FILE ]]; then
    
    cp $CONFIG_FILE ${CONFIG_FILE}.backup

    # Tat SE linux
    sed -i 's/^SELINUX=.*/SELINUX=disabled/' $CONFIG_FILE

    reboot
set +x 
#!/bin/bash
#Author: DuongDT
set +x
# Nhap cac bien can thiet
DOMAIN="*.poc.local" # Thay the domain cua ban
COUNTRY="VN"
STATE="VN"
LOCALITY="HCM"
ORGANIZATION="MYLAB"
ORG_UNIT="MYLAB"
EMAIL="duongtrungduong86@gmail.com"
DAYS=365 # 

# Tao thu muc chua chung chi
mkdir -p createcert
cd createcert || exit

# Bước 1: Tạo ca key va chung chi ca tu ky
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -sha256 -days $DAYS -out ca.crt -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$ORG_UNIT/CN=CA/emailAddress=$EMAIL"

# Bước 2: Tao private key cho wildcard
openssl genrsa -out wildcard.key 2048

# Bước 3: Tap CSR
openssl req -new -key wildcard.key -out wildcard.csr -subj "/C=$COUNTRY/ST=$STATE/L=$LOCALITY/O=$ORGANIZATION/OU=$ORG_UNIT/CN=$DOMAIN/emailAddress=$EMAIL"

# Bước 4: Ky chung chi
openssl x509 -req -in wildcard.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out wildcard.crt -days $DAYS -sha256

# Xoa tep k can thiet
rm -f wildcard.csr ca.srl

# in ket qua
echo "Wildcard certificate created:"
echo "CA Certificate: /craetecert/ca.crt"
echo "Wildcard Certificate: /createcert/wildcard.crt"
echo "Wildcard Private Key: /createcert/wildcard.key"
set -x
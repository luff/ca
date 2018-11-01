#!/usr/bin/env bash
#
# copyright (c) 2015 luffae@gmail.com
#

wd=$(cd $(dirname $0) && pwd)

mkdir -p $wd/ca/{misc,newcerts,private}

cat > $wd/openssl.conf << \
EOF
[ ca ]
default_ca = my_ca
[ my_ca ]
database               = $wd/ca/misc/index.txt
serial                 = $wd/ca/misc/serial
new_certs_dir          = $wd/ca/newcerts
certificate            = $wd/ca/private/ca.crt
private_key            = $wd/ca/private/ca.key
RANDFILE               = $wd/ca/private/.rand
default_days           = 365
default_crl_days       = 30
default_md             = md5
unique_subject         = no
policy                 = policy_any
[ policy_any ]
countryName            = match
stateOrProvinceName    = match
organizationName       = match
organizationalUnitName = match
localityName           = optional
commonName             = supplied
emailAddress           = optional
EOF

openssl genrsa \
  -out \
   $wd/ca/private/ca.key

openssl req \
  -new \
  -nodes \
  -subj "/C=CN/ST=Beijing/L=Beijing/O=Neucloud/OU=Ops/CN=mqtt.neuseer.com" \
  -key \
   $wd/ca/private/ca.key \
  -out \
   $wd/ca/private/ca.csr

openssl x509 \
  -req \
  -days 365 \
  -in \
   $wd/ca/private/ca.csr \
  -signkey \
   $wd/ca/private/ca.key \
  -out \
   $wd/ca/private/ca.crt

echo FACE > $wd/ca/misc/serial

touch $wd/ca/misc/index.txt

openssl ca \
  -gencrl \
  -out \
   $wd/ca/private/ca.crl \
  -crldays 7 \
  -config \
   $wd/openssl.conf


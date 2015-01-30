#!/usr/bin/env bash
#
# copyright (c) 2015 luffae@gmail.com
#

wd=$(cd $(dirname $0) && pwd)

keytool=/usr/java/default/bin/keytool

mkdir -p $wd/users/

openssl genrsa -des3 \
  -out $wd/users/client.key 1024

openssl req -new \
  -key $wd/users/client.key \
  -out $wd/users/client.csr

openssl ca \
  -in $wd/users/client.csr \
  -cert $wd/private/ca.crt \
  -keyfile $wd/private/ca.key \
  -out $wd/users/client.crt \
  -config $wd/conf/openssl.conf

openssl pkcs12 -export -clcerts \
  -in $wd/users/client.crt \
  -inkey $wd/users/client.key \
  -out $wd/users/client.p12

$keytool -v -importkeystore -trustcacerts \
  -srckeystore $wd/users/client.p12 \
  -srcstoretype PKCS12 \
  -destkeystore $wd/users/client.jks \
  -deststoretype JKS


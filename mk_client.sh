#!/usr/bin/env bash
#
# copyright (c) 2018 luffae@gmail.com
#

wd=$(cd $(dirname $0) && pwd)

keytool=/usr/java/default/bin/keytool

mkdir -p $wd/ca/client

openssl genrsa \
  -des3 \
  -out \
   $wd/ca/client/client.key 1024

openssl req \
  -new \
  -key \
   $wd/ca/client/client.key \
  -out \
   $wd/ca/client/client.csr \
  -nodes

openssl ca \
  -cert \
   $wd/ca/private/ca.crt \
  -keyfile \
   $wd/ca/private/ca.key \
  -config \
   $wd/openssl.conf \
  -in \
   $wd/ca/client/client.csr \
  -out \
   $wd/ca/client/client.crt \
  -batch

openssl pkcs12 \
  -export \
  -clcerts \
  -in \
   $wd/ca/client/client.crt \
  -inkey \
   $wd/ca/client/client.key \
  -out \
   $wd/ca/client/client.p12

$keytool \
  -importkeystore \
  -trustcacerts \
  -v \
  -srckeystore \
   $wd/ca/client/client.p12 \
  -srcstoretype PKCS12 \
  -destkeystore \
   $wd/ca/client/client.jks \
  -deststoretype JKS


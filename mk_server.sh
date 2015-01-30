#!/usr/bin/env bash
#
# copyright (c) 2015 luffae@gmail.com
#

wd=$(cd $(dirname $0) && pwd)

mkdir -p $wd/server

openssl genrsa \
  -out $wd/server/server.key

openssl req -new \
  -key $wd/server/server.key \
  -out $wd/server/server.csr

openssl ca \
  -in $wd/server/server.csr \
  -cert $wd/private/ca.crt \
  -keyfile $wd/private/ca.key \
  -out $wd/server/server.crt \
  -config $wd/conf/openssl.conf


#!/usr/bin/env bash
#
# copyright (c) 2015 luffae@gmail.com
#

wd=$(cd $(dirname $0) && pwd)

mkdir -p $wd/private $wd/misc

openssl genrsa \
  -out $wd/private/ca.key

openssl req -new \
  -key $wd/private/ca.key \
  -out $wd/private/ca.csr

openssl x509 -req -days 365 \
  -in $wd/private/ca.csr \
  -signkey $wd/private/ca.key \
  -out $wd/private/ca.crt

echo FACE > $wd/misc/serial

touch $wd/misc/index.txt

openssl ca -gencrl \
  -out $wd/private/ca.crl -crldays 7 \
  -config $wd/conf/openssl.conf


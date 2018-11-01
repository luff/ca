#!/usr/bin/env bash
#
# copyright (c) 2015 luffae@gmail.com
#

wd=$(cd $(dirname $0) && pwd)

mkdir -p $wd/ca/server

openssl genrsa \
  -out \
   $wd/ca/server/server.key

openssl req \
  -new \
  -nodes \
  -subj "/C=CN/ST=Beijing/L=Beijing/O=Neucloud/OU=Ops/CN=mqtt.neuseer.com" \
  -key \
   $wd/ca/server/server.key \
  -out \
   $wd/ca/server/server.csr

openssl ca \
  -cert \
  -batch \
   $wd/ca/private/ca.crt \
  -keyfile \
   $wd/ca/private/ca.key \
  -config \
   $wd/openssl.conf \
  -in \
   $wd/ca/server/server.csr \
  -out \
   $wd/ca/server/server.crt


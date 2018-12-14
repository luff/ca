#!/usr/bin/env bash
#
# copyright (c) 2018 luffae@gmail.com
#

wd=$(cd $(dirname $0) && pwd)

mkdir -p $wd/ca/server

openssl genrsa \
  -out \
   $wd/ca/server/server.key

openssl req \
  -new \
  -subj "/C=CN/ST=Beijing/L=Beijing/O=MyOrg/OU=Ops/CN=a.b.com" \
  -key \
   $wd/ca/server/server.key \
  -out \
   $wd/ca/server/server.csr \
  -nodes

openssl ca \
  -cert \
   $wd/ca/private/ca.crt \
  -keyfile \
   $wd/ca/private/ca.key \
  -config \
   $wd/openssl.conf \
  -in \
   $wd/ca/server/server.csr \
  -out \
   $wd/ca/server/server.crt \
  -batch


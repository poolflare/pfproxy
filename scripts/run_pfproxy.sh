#!/usr/bin/env bash

while true
do
    ./pfproxy run -L tls://:6443 -R please-fill-remote-address
    sleep 1
done

#!/usr/bin/env bash

while true
do
    ./pfproxy run -L :3443 \
        -R tls://kda.ss.poolflare.net:1443 \
        -R tls://kda-asia.ss.poolflare.net:1443 \
        -R tls://kda-eu.ss.poolflare.net:1443 \
        -R tls://kda-us.ss.poolflare.net:1443 \
        -V || true

    sleep 1
done

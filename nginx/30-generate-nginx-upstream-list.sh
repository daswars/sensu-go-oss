#!/usr/bin/env sh
# Define a string variable with a value
UPTREAM_LIST=${UPTREAM_LIST:-backend:8080}

test -f /etc/nginx/upstream.conf && rm -f /etc/nginx/upstream.conf
# Iterate the string variable using for loop
for backends in $UPTREAM_LIST; do
    echo "server $backends;" >>/etc/nginx/upstream.conf
done

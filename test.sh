#!/bin/sh
set -e
if cmp -s unencrypted.txt encrypted.txt; then
    echo "The files are the same!"
else
    echo "Not the same!"
    exit 1
fi

echo "Testing connection to redis..."
echo "hello" | redis-cli -h redis -x set mypasswd
redis-cli -h redis get mypasswd

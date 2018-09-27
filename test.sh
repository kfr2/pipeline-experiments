#!/bin/bash
if cmp -s unencrypted.txt encrypted.txt; then
    echo "The files are the same!"
    exit 0
else
    echo "Not the same!"
    exit 1
fi

#!/bin/bash 
openssl passwd -6 -salt "$(openssl rand -base64 12 | head -c 16)" "$1" > 3_hash.txt 

#!/bin/bash
echo -n "$1" | sha1sum | head -c 40 > 0_hash.txt

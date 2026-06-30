#!/bin/bash
#
# 1-xor_decoder.sh - Decode a WebSphere {xor} obfuscated string
#
# Usage: ./1-xor_decoder.sh '{xor}KzosKw=='
#
# WebSphere "xor" obfuscation algorithm:
#   1. Strip the leading "{xor}" tag
#   2. Base64-decode the remaining string
#   3. XOR every resulting byte with 0x5F (95)
#

input="$1"

# Strip the {xor} prefix if present
encoded="${input#\{xor\}}"

# Base64-decode then XOR each byte with 0x5F
echo -n "$encoded" | base64 -d 2>/dev/null | python3 -c "
import sys
data = sys.stdin.buffer.read()
sys.stdout.write(''.join(chr(b ^ 0x5F) for b in data))
"
echo

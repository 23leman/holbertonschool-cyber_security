#!/bin/bash
dig +noall +answer $1 ANY $1 A $1 MX $1 TXT $1 NS | sort -u

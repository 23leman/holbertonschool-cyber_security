#!/bin/bash
subfinder -d $1 -silent -o $1.txt -oIP 2>/dev/null || true

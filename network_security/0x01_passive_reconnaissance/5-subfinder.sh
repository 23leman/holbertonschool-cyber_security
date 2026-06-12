#!/bin/bash
subfinder -d $1 -silent; subfinder -d $1 -silent -oIP -o $1.txt >/dev/null

#!/bin/bash
useradd -m -s /bin/sh "$1"
chpasswd <<< "$1:$2"

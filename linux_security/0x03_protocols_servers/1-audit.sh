#!/bin/bash
awk '$1 !~ /^#/ && NF > 0' /etc/ssh/sshd_config

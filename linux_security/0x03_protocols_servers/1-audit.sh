#!/bin/bash
grep -v "^\s*#" /etc/ssh/sshd_config /etc/ssh/sshd_config.d/*.conf 2>/dev/null | grep -v "^\s*$" | grep -v "^/etc"

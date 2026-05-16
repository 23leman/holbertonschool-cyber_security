#!/bin/bash
grep -E "smtpd_tls|smtp_tls" /etc/postfix/main.cf 2>/dev/null || echo "STARTTLS not configured"

#!/bin/bash
postconf -n | grep smtpd_tls_security_level 2>/dev/null || echo "STARTTLS not configured"

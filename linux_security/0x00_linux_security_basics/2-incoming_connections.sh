#!/bin/bash
sudo ufw default deny incoming
sudo ufw allow 80/tcp
sudo ufw --force enable

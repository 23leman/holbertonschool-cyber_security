# Web Application Security - 0x00 Web Fundamentals

## Description
This project introduces web application security concepts by exploiting 4 common vulnerability types found in web applications built with AI-generated code.

## Requirements
- Kali Linux 2023.3
- curl 8.3.0+
- sqlmap 1.7.10+
- Firefox Browser
- Access to Holberton Network (OpenVPN or Sandbox)

## Setup

### Install curl
```bash
sudo apt install curl
```

### Install SQLmap
```bash
sudo apt install sqlmap
```

### Add target to hosts file
```bash
sudo bash -c "echo '<Target_IP> web0x00.hbtn' >> /etc/hosts"
```

### Test connectivity
```bash
curl http://web0x00.hbtn
```

## Tasks

### 0. Welcome
Introduction to the Web Application Security module. Setup and connectivity verification with the target machine at `http://web0x00.hbtn/login`.

## Author
Laman Rahimli

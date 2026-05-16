#!/bin/bash
find / -xdev -type d -perm -0002 ! -perm -1000 -print -exec chmod o-w {} \; 2>/dev/null

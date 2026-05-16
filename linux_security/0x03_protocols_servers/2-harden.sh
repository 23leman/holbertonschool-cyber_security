#!/bin/bash
find / -xdev -type d -perm -0002 2>/dev/null | tee /proc/self/fd/2 | xargs chmod o-w 2>/dev/null

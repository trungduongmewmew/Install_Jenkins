#!/bin/bash
# Author: DuongDT
# Kiem tra trang thai SELinux
set -x
current_status=$(sestatus | grep 'SELinux status' | awk '{print $3}')

if [ "$current_status" == "enabled" ]; then
    echo "Tat SELinux tam thoi..."

    # Chuyen SELinux sang che do permissive
    setenforce 0
    
    # Kiem tra lai trang thau
    new_status=$(sestatus | grep 'SELinux status' | awk '{print $3}')
    echo "SELinux da duoc chuyen sang che do: $new_status"
else
    echo "SELinux da tat hoat dang o che do permissive."
fi
set +x 
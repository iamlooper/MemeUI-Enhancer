#!/system/bin/sh
# MemeUI Enhancer
# Author: LOOPER (iamlooper @ github)

wait_until_boot_complete() {
  while [[ "$(getprop sys.boot_completed)" != "1" ]]; do
    sleep 3
  done
}

wait_until_boot_complete

# Sleep until proper init complete
sleep 30

# Apply Enhancer
mienhancer

#!/system/bin/sh
# MemeUI Enhancer
# Author: LOOPER (iamlooper @ github)

wait_until_boot_complete() {
  while [[ "$(getprop sys.boot_completed)" != "1" ]]; do
    sleep 2
  done
}

wait_until_boot_complete

# Sleep until proper init complete
sleep 60

# Apply Enhancer
mienhancer
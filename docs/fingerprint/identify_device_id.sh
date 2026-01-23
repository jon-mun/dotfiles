# Find exactly device ID
for device in /sys/bus/usb/devices/*; do
  if [ -f "$device/idVendor" ]; then
    vendor=$(cat "$device/idVendor" 2>/dev/null)
    product=$(cat "$device/idProduct" 2>/dev/null)
    if [ "$vendor" = "06cb" ] && [ "$product" = "009a" ]; then
      echo "Device found in:: $(basename $device)"
      echo "Path: $device"
    fi
  fi
done

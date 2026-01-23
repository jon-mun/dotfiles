<!-- markdownlint-disable -->
```bash
yay -S python-validity
```


```bash
# 1. Stop service AND socket (socket activation can restart the service unexpectedly)
sudo systemctl stop python3-validity.service
sudo systemctl stop python3-validity.socket

# 2. Run the factory reset script
sudo python3 /usr/share/python-validity/playground/factory-reset.py
```


```bash
sudo validity-sensors-firmware
```

```bash
echo 'on' | sudo tee /sys/bus/usb/devices/1-9/power/control
```

```bash
fprintd-enroll
```


<!-- markdownlint-disable -->
# Fingerprint Setup

## Diagnostics

### Hardware and USB diagnostics

```bash lsusb
➜  ~ lsusb -d 06cb:009a -v | pbcopy
Couldn't open device, some information will be missing

Bus 001 Device 005: ID 06cb:009a Synaptics, Inc. Metallica MIS Touch Fingerprint Reader
Negotiated speed: Full Speed (12Mbps)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass        16 [unknown]
  bDeviceProtocol       255 
  bMaxPacketSize0         8
  idVendor           0x06cb Synaptics, Inc.
  idProduct          0x009a Metallica MIS Touch Fingerprint Reader
  bcdDevice            1.64
  iManufacturer           0 
  iProduct                0 
  iSerial                 1 7345b486869c
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0035
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           5
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x84  EP 4 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval              10

```

```bash dmesg
➜  ~ sudo dmesg | grep -i "usb" | tail -n 20
[    1.367336] usb 2-3: SerialNumber: 20120501030900000
[    1.403407] usb-storage 2-3:1.0: USB Mass Storage device detected
[    1.403516] scsi host0: usb-storage 2-3:1.0
[    1.403651] usbcore: registered new interface driver usb-storage
[    1.472075] usb 1-7: new full-speed USB device number 3 using xhci_hcd
[    1.597253] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2b, bcdDevice= 0.10
[    1.597256] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.711063] usb 1-8: new high-speed USB device number 4 using xhci_hcd
[    1.871329] usb 1-8: New USB device found, idVendor=13d3, idProduct=56a6, bcdDevice=17.11
[    1.871333] usb 1-8: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[    1.871334] usb 1-8: Product: Integrated Camera
[    1.871335] usb 1-8: Manufacturer: Azurewave
[    1.871337] usb 1-8: SerialNumber: 0001
[    1.934544] usbcore: registered new interface driver uas
[    1.985278] usb 1-9: new full-speed USB device number 5 using xhci_hcd
[    2.110173] usb 1-9: New USB device found, idVendor=06cb, idProduct=009a, bcdDevice= 1.64
[    2.110184] usb 1-9: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    2.110190] usb 1-9: SerialNumber: 7345b486869c
[    5.835810] usbcore: registered new interface driver btusb
[    5.873737] usbcore: registered new interface driver uvcvideo
```

### Service and driver logs

```bash systemctl
➜  ~ systemctl status python3-validity
● python3-validity.service - python-validity driver dbus service
     Loaded: loaded (/usr/lib/systemd/system/python3-validity.service; enabled; preset: disabled)
     Active: active (running) since Fri 2025-12-26 12:40:24 WIB; 5s ago
 Invocation: 7f5337e3b64e4d4cb14b897834459053
   Main PID: 25369 (python3)
      Tasks: 2 (limit: 19027)
     Memory: 20.5M (peak: 20.5M)
        CPU: 317ms
     CGroup: /system.slice/python3-validity.service
             └─25369 python3 /usr/lib/python-validity/dbus-service --debug

Dec 26 12:40:24 thinkpad-t480 systemd[1]: python3-validity.service: Scheduled restart job, restart counter is at 26.
Dec 26 12:40:24 thinkpad-t480 systemd[1]: Started python-validity driver dbus service.
Dec 26 12:40:25 thinkpad-t480 python3[25369]: DEBUG:root:>cmd> 3e
```

```bash journalctl
➜  ~ journalctl -u python3-validity.service -n 50 --no-pager
Dec 26 12:47:58 thinkpad-t480 systemd[1]: Started python-validity driver dbus service.
Dec 26 12:47:59 thinkpad-t480 python3[26824]: DEBUG:root:>cmd> 3e
Dec 26 12:47:59 thinkpad-t480 python3[26824]: DEBUG:root:<cmd< 0000
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]: Traceback (most recent call last):
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:   File "/usr/lib/python-validity/dbus-service", line 305, in <module>
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:     main()
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:     ~~~~^^
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:   File "/usr/lib/python-validity/dbus-service", line 262, in main
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:     init.open()
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:     ~~~~~~~~~^^
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:   File "/usr/lib/python3.13/site-packages/validitysensor/init.py", line 50, in open
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:     open_common()
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:     ~~~~~~~~~~~^^
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:   File "/usr/lib/python3.13/site-packages/validitysensor/init.py", line 31, in open_common
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:     init_flash()
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:     ~~~~~~~~~~^^
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:   File "/usr/lib/python3.13/site-packages/validitysensor/init_flash.py", line 122, in init_flash
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:     info = get_flash_info()
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:   File "/usr/lib/python3.13/site-packages/validitysensor/flash.py", line 45, in get_flash_info
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:     jid0, jid1, blocks, unknown0, blocksize, unknown1, pcnt = unpack('<HHHHHHH', hdr)
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]:                                                               ~~~~~~^^^^^^^^^^^^^^^^^
Dec 26 12:47:59 thinkpad-t480 dbus-service[26824]: struct.error: unpack requires a buffer of 14 bytes
Dec 26 12:47:59 thinkpad-t480 systemd[1]: python3-validity.service: Main process exited, code=exited, status=1/FAILURE
Dec 26 12:47:59 thinkpad-t480 systemd[1]: python3-validity.service: Failed with result 'exit-code'.
Dec 26 12:47:59 thinkpad-t480 systemd[1]: python3-validity.service: Scheduled restart job, restart counter is at 82.
Dec 26 12:47:59 thinkpad-t480 systemd[1]: Started python-validity driver dbus service.
Dec 26 12:47:59 thinkpad-t480 python3[26828]: DEBUG:root:>cmd> 3e
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]: Traceback (most recent call last):
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python-validity/dbus-service", line 305, in <module>
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     main()
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     ~~~~^^
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python-validity/dbus-service", line 262, in main
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     init.open()
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     ~~~~~~~~~^^
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python3.13/site-packages/validitysensor/init.py", line 50, in open
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     open_common()
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     ~~~~~~~~~~~^^
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python3.13/site-packages/validitysensor/init.py", line 31, in open_common
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     init_flash()
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     ~~~~~~~~~~^^
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python3.13/site-packages/validitysensor/init_flash.py", line 122, in init_flash
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     info = get_flash_info()
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python3.13/site-packages/validitysensor/flash.py", line 40, in get_flash_info
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     rsp = tls.cmd(unhex('3e'))
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python3.13/site-packages/validitysensor/tls.py", line 124, in cmd
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     rsp = self.usb.cmd(cmd)
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python3.13/site-packages/validitysensor/usb.py", line 105, in cmd
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     resp = self.dev.read(129, 100 * 1024)
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python3.13/site-packages/usb/core.py", line 1043, in read
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     ret = fn(
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:             self._ctx.handle,
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     ...<2 lines>...
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:             buff,
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:             self.__get_timeout(timeout))
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python3.13/site-packages/usb/backend/libusb1.py", line 850, in bulk_read
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     return self.__read(self.lib.libusb_bulk_transfer,
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:            ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:                        dev_handle,
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:                        ^^^^^^^^^^^
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     ...<2 lines>...
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:                        buff,
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:                        ^^^^^
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:                        timeout)
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:                        ^^^^^^^^
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python3.13/site-packages/usb/backend/libusb1.py", line 958, in __read
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     _check(retval)
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     ~~~~~~^^^^^^^^
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:   File "/usr/lib/python3.13/site-packages/usb/backend/libusb1.py", line 602, in _check
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]:     raise USBTimeoutError(_strerror(ret), ret, _libusb_errno[ret])
Dec 26 12:48:14 thinkpad-t480 dbus-service[26828]: usb.core.USBTimeoutError: [Errno 110] Operation timed out
Dec 26 12:48:14 thinkpad-t480 systemd[1]: python3-validity.service: Main process exited, code=exited, status=1/FAILURE
Dec 26 12:48:14 thinkpad-t480 systemd[1]: python3-validity.service: Failed with result 'exit-code'.
Dec 26 12:48:15 thinkpad-t480 systemd[1]: python3-validity.service: Scheduled restart job, restart counter is at 83.
Dec 26 12:48:15 thinkpad-t480 systemd[1]: Started python-validity driver dbus service.
Dec 26 12:48:15 thinkpad-t480 python3[26851]: DEBUG:root:>cmd> 3e
Dec 26 12:48:15 thinkpad-t480 python3[26851]: DEBUG:root:<cmd< 0000
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]: Traceback (most recent call last):
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:   File "/usr/lib/python-validity/dbus-service", line 305, in <module>
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:     main()
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:     ~~~~^^
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:   File "/usr/lib/python-validity/dbus-service", line 262, in main
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:     init.open()
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:     ~~~~~~~~~^^
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:   File "/usr/lib/python3.13/site-packages/validitysensor/init.py", line 50, in open
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:     open_common()
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:     ~~~~~~~~~~~^^
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:   File "/usr/lib/python3.13/site-packages/validitysensor/init.py", line 31, in open_common
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:     init_flash()
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:     ~~~~~~~~~~^^
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:   File "/usr/lib/python3.13/site-packages/validitysensor/init_flash.py", line 122, in init_flash
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:     info = get_flash_info()
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:   File "/usr/lib/python3.13/site-packages/validitysensor/flash.py", line 45, in get_flash_info
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:     jid0, jid1, blocks, unknown0, blocksize, unknown1, pcnt = unpack('<HHHHHHH', hdr)
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]:                                                               ~~~~~~^^^^^^^^^^^^^^^^^
Dec 26 12:48:15 thinkpad-t480 dbus-service[26851]: struct.error: unpack requires a buffer of 14 bytes
Dec 26 12:48:15 thinkpad-t480 systemd[1]: python3-validity.service: Main process exited, code=exited, status=1/FAILURE
Dec 26 12:48:15 thinkpad-t480 systemd[1]: python3-validity.service: Failed with result 'exit-code'.
Dec 26 12:48:15 thinkpad-t480 systemd[1]: python3-validity.service: Scheduled restart job, restart counter is at 84.
Dec 26 12:48:15 thinkpad-t480 systemd[1]: Started python-validity driver dbus service.
Dec 26 12:48:15 thinkpad-t480 python3[26855]: DEBUG:root:>cmd> 3e
```

### Kernel and MSR Configuration
```bash msr allow writes
cat /sys/module/msr/parameters/allow_writes
on
```

```bash fprintd status
systemctl is-enabled fprintd
masked
```

### Local State Investigation
```bash
ls -al /var/lib/python-validity/
ls: cannot access '/var/lib/python-validity/': No such file or directory
```

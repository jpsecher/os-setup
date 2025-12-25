# Firmware for Intel Macbook (T2)

The online guides are at https://wiki.t2linux.org/

## T2

Use git to get the T2 firmware, see `lamport-configuration.nix`

## Wifi 

See https://wiki.t2linux.org/distributions/nixos/installation/#wi-fi-and-bluetooth-setup

```
sudo mkdir -p /lib/firmware/brcm
 
```

1. Download https://raw.githubusercontent.com/kholia/OSX-KVM/refs/heads/master/fetch-macOS-v2.py
1. Run the script like `python fetch-macOS-v2.py`
1. Use firmware from ~~Sonoma~~ Tahoe
1. 

## Actual fetch fw

- Boot nixos 25.11 with firmware (?) from USB stick

```
sudo mkdir -p /lib/firmware/brcm
sudo get-apple-firmware
```

Select option Sonoma, and wait for the firmware to be extracted into `/lib/firmware/brcm`.

Then plug in another usb stick, and do eg. `sudo mount /dev/sdb1 /mnt`, and `sudo mkdir /mnt/brcm`.

Then `sudo cp /lib/firmware/brcm/* /mnt/brcm/` and `sudo umount /mnt` and wait for it to finish.

Now the firmware is on the separate usb stick and can be transferred to `/lib/firmware/brcm/` on the real system. 

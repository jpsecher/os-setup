# NixOS in virtual machine

Adapted from mitchellh/nixos-config


## Bootstrap

Create a virtual machine (eg. in UTM)

- Use UEFI.
- Attach NixOS 23.05 ISO.
- Start VM.
- Select manual/terminal installation.

In the VM do:
```
sudo -i
passwd # Set to "root"
lsblk # Check that /dev/sda is there
ip a # Take note of the IP address eg. 192.168.64.2
```

On the host do:
```
export NIXADDR=192.168.64.2
make bootstrap-vm-step-1
```

Then detach ISO from VM and make a snapshot to make it faster to make changes to the next step:

Start the VM again and run this on the host to finalize the VM:
```
make bootstrap-vm-step-2
```

Thereafter use
```
export NIXADDR=192.168.64.2
make copy-configuration-to-vm
make nix-rebuild-and-switch
```
on the host repeatedly to change configuration.


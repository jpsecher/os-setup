# Adapted from mitchellh/nixos-config

# Connectivity info for VM guest
NIXADDR ?= unset
NIXPORT ?= 22
NIXUSER ?= jps
# The name of the nixosConfiguration in the flake
NIXNAME ?= vm-intel

makefile_dir := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
# ssh_options := -o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
ssh_options := -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
uname := $(shell uname)

switch:
ifeq ($(uname), Darwin)
	nix build ".#darwinConfigurations.${NIXNAME}.system"
	./result/sw/bin/darwin-rebuild switch --flake "$$(pwd)#${NIXNAME}"
else
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake ".#${NIXNAME}"
endif

test:
ifeq ($(uname), Darwin)
	nix build ".#darwinConfigurations.${NIXNAME}.system"
	./result/sw/bin/darwin-rebuild test --flake "$$(pwd)#${NIXNAME}"
else
	sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild test --flake ".#$(NIXNAME)"
endif

# Bootstrap a brand new VM.  The VM should have NixOS ISO on the CD drive
# and just set the password of the root user to "root".  This will install
# NixOS.  After installing NixOS, you must reboot and set the root password
# for the next step.
bootstrap-vm-step-1:
	ssh $(ssh_options) -p$(NIXPORT) root@$(NIXADDR) " \
		parted /dev/sda -- mklabel gpt; \
		parted /dev/sda -- mkpart primary 512MB -8GB; \
		parted /dev/sda -- mkpart primary linux-swap -8GB 100\%; \
		parted /dev/sda -- mkpart ESP fat32 1MB 512MB; \
		parted /dev/sda -- set 3 esp on; \
		sleep 1; \
		mkfs.ext4 -L nixos /dev/sda1; \
		mkswap -L swap /dev/sda2; \
		mkfs.fat -F 32 -n boot /dev/sda3; \
		sleep 1; \
		mount /dev/disk/by-label/nixos /mnt; \
		mkdir -p /mnt/boot; \
		mount /dev/disk/by-label/boot /mnt/boot; \
		nixos-generate-config --root /mnt; \
		sed --in-place '/system\.stateVersion = .*/a \
			nix.package = pkgs.nixUnstable;\n \
			nix.extraOptions = \"experimental-features = nix-command flakes\";\n \
  			services.openssh.enable = true;\n \
			services.openssh.settings.PasswordAuthentication = true;\n \
			services.openssh.settings.PermitRootLogin = \"yes\";\n \
			users.users.root.initialPassword = \"root\";\n \
		' /mnt/etc/nixos/configuration.nix; \
		nixos-install --no-root-passwd && shutdown now; \
	"

# After bootstrap-vm-step-1, detach ISO from VM and start it again.
# Then run this to finalize.  After this, do everything
# else in the VM unless secrets change.
bootstrap-vm-step-2:
	NIXUSER=root $(MAKE) copy-configuration-to-vm
	NIXUSER=root $(MAKE) nix-rebuild-and-switch
	$(MAKE) copy-secrets-to-vm
	ssh $(ssh_options) -p$(NIXPORT) $(NIXUSER)@$(NIXADDR) " \
		sudo reboot; \
	"

copy-secrets-to-vm:
	rsync -av -e 'ssh $(ssh_options)' \
		--exclude='.#*' \
		--exclude='S.*' \
		--exclude='*.conf' \
		$(HOME)/.gnupg/ $(NIXUSER)@$(NIXADDR):~/.gnupg
	rsync -av -e 'ssh $(ssh_options)' \
		--exclude='environment' \
		$(HOME)/.ssh/ $(NIXUSER)@$(NIXADDR):~/.ssh

copy-configuration-to-vm:
	rsync -av -e 'ssh $(ssh_options) -p$(NIXPORT)' \
		--exclude='vendor/' \
		--exclude='.git/' \
		--exclude='.git-crypt/' \
		--exclude='iso/' \
		--rsync-path="sudo rsync" \
		$(makefile_dir)/ $(NIXUSER)@$(NIXADDR):/nix-config

# Run the nixos-rebuild switch command.  This does NOT copy files so you
# have to run copy-configuration-to-vm before.
nix-rebuild-and-switch:
	ssh $(ssh_options) -p$(NIXPORT) $(NIXUSER)@$(NIXADDR) " \
		sudo NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1 nixos-rebuild switch --flake \"/nix-config#${NIXNAME}\" \
	"

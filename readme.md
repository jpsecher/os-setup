# Generic OS setup

Use at your own risk.

Files are grouped by major Operating System type:

- [common](./common) for OS-independent files
- [darwin-nix](./darwin-nix) for [Nix-Darwin](https://github.com/nix-darwin/nix-darwin)
- [debian](./debian) for Debian-based systems
- [macos](./macos) for MacOS
- [nixos](./nixos) for NixOS
- [windows](./windows) for Windows

Private keys etc. are placed in `common/secrets/` on each OS where this repository is cloned to, and of course ignored in `.gitignore`.


---
title: "Install Nix on macOS Catalina"
date: "2020-02-22"
draft: false
featured_image: "/images/nix-social-preview.png"
tags:
 - Nix
 - macOS
 - Package Management
 - Developer Environment
---

**Updated on: 18 Nov 2020**

Recent changes by Apple to macOS have made that operating system less
compatible with software designed for Unix, including
[Nix](https://nixos.org/).
Here is how to work around the changes to install Nix on macOS 15 (Catalina).

<!--more-->

```shell
echo 'nix' | sudo tee -a /etc/synthetic.conf
reboot  # Actually reboot your Mac.
sudo diskutil apfs addVolume disk1 APFSX Nix -mountpoint /nix
sudo diskutil enableOwnership /nix
sudo chflags hidden /nix
echo "LABEL=Nix /nix apfs rw" | sudo tee -a /etc/fstab
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### Credits

- https://github.com/NixOS/nix/issues/2925#issuecomment-539570232

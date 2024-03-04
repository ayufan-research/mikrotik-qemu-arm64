# Run MikroTik in ARM64 KVM

This is set of a few simple scripts to run MikroTik AMPERE variant
in QEMU on ARM64 with KVM.

## Install

Run: `./install-kvm.sh` to install first.
After system installs, Ctrl-C to exit.

## Run

Run: `./run-kvm-bridged.sh` to run connected to the default bridge.
Requires to have your main interface added to bridge on your host.

Or run: `./run-kvm-user.sh` to use user networking.

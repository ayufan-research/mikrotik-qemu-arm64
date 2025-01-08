#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source "$SCRIPT_DIR/helpers"

wget -c https://download.mikrotik.com/routeros/$VERSION/mikrotik-$VERSION-arm64.iso

[[ -e efi-vars.qcow2 ]] || qemu-img create efi-vars.qcow2 64M
[[ -e root.qcow2 ]] || qemu-img create root.qcow2 1G

exec qemu-system-aarch64 -m 1024 \
  -pflash AAVMF_CODE.fd -pflash efi-vars.qcow2 \
  -vga none -nographic -monitor none \
  -serial chardev:term0 -chardev stdio,id=term0 \
  -cpu cortex-a72 -smp cpus=2,sockets=1,cores=2,threads=1 \
  -machine virt,virtualization=on -accel tcg,tb-size=128 \
  -device nvme,drive=hd0,serial=BDCF8C72-9BE7-4118-B274-EAD8B0982915,bootindex=1 \
  -drive if=none,file=root.qcow2,id=hd0,media=disk,discard=unmap,detect-zeroes=unmap \
  -device virtio-blk-pci,drive=cdrom0,bootindex=0 \
  -drive if=none,format=raw,file=mikrotik-$VERSION-arm64.iso,id=cdrom0 \
  "$@"

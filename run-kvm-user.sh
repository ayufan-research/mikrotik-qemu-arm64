#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0); pwd)
source "$SCRIPT_DIR/helpers"

exec qemu-system-aarch64 -m "${MEM:-256}" \
  -pflash AAVMF_CODE.fd \
  -vga none -nographic -monitor none \
  -serial chardev:term0 -chardev stdio,id=term0 \
  -cpu host -smp "cpus=${CPUS:-2},sockets=1,cores=${CPUS:-2},threads=1" \
  -machine virt,accel=kvm \
  -device nvme,drive=hd0,serial=BDCF8C72-9BE7-4118-B274-EAD8B0982915,bootindex=0 \
  -drive if=none,file=root.qcow2,id=hd0,media=disk,discard=unmap,detect-zeroes=unmap \
  -device virtio-net-pci,netdev=netdev0 \
  -netdev user,id=netdev0 \
  "$@"

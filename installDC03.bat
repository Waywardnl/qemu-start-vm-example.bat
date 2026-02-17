#!/bin/sh

/usr/bin/qemu-system-x86_64 \
  -enable-kvm \
  -machine q35 \
  -cpu host \
  -smp 2 \
  -m 8G \
  -device virtio-balloon-pci \
  \
  -display none \
  -audio none \
  -vnc 0.0.0.0:2 \
  -daemonize \
  -pidfile /Deb08/vms/WW_DC03/WW_DC03.pid \
  -monitor unix:/Deb08/vms/WW_DC03/monitor.sock,server,nowait \
  \
  -netdev tap,id=net0,ifname=tap_dc03,script=no,downscript=no \
  -device virtio-net-pci,netdev=net0,mac=52:54:00:dc:03:01 \
  \
  -device virtio-scsi-pci,id=scsi0 \
  \
  -drive file=/Deb08/vms/WW_DC03/WW_DC03.qcow2,if=none,id=disk0,format=qcow2 \
  -device scsi-hd,drive=disk0,bus=scsi0.0 \
  \
  -drive file=/Deb08/vms/WW_DC03/WW_DC03_SYSVOL.qcow2,if=none,id=disk1,format=qcow2 \
  -device scsi-hd,drive=disk1,bus=scsi0.0 \
  \
  -cdrom /Deb08/isos/iso/en-us_windows_server_2022_updated_dec_2023_x64_dvd_f101ef8f.iso \
  -drive file=/Deb08/isos/virtio-win-0.1.285.iso,media=cdrom \
  \
  -boot d

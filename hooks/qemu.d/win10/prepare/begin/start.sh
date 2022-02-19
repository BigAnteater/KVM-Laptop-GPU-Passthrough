set -x

# unbind vtconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# unbind efi framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# avoid race condition (racist)
sleep 2

# detach the gpu
virsh nodedev-detach pci_0000_10_00_0
virsh nodedev-detach pci_0000_10_00_1
virsh nodedev-detach pci_0000_10_00_2
virsh nodedev-detach pci_0000_10_00_3

# load the mf vfio
modprobe vfio-pci

set -x

# rebind the gpu

virsh nodedev-reattach pci_0000_01_00_0
virsh nodedev-reattach pci_0000_01_00_1
virsh nodedev-reattach pci_0000_01_00_2
virsh nodedev-reattach pci_0000_01_00_3

# rebind vtconsoles
echo 1 > /sys/class/vtconsoles/vtcon0/bind
echo 1 > /sys/class/vtconsoles/vtcon1/bind

# KVM-Laptop-GPU-Passthrough
This is a simple and easy guide to setting up an Nvidia optimus laptop for GPU passthrough.
This guide is meant for advanced arch users who know about virtualization and troubleshooting.

# Setup

To set up your laptop for this guide, follow these steps:

Enable VT-d and VT-x/Intel Virtualization Technology in your laptops UEFI/BIOS.

Then install optimus manager. This can be installed using [yay](https://aur.archlinux.org/packages/yay).
```
yay -S optimus-manager optimus-manager-qt
```
Once installed, enable the optimus manager service so that it launches every time on startup.
```
sudo systemctl enable optimus-manager
```
Then finally, reboot your computer. [This guide](https://youtu.be/RZdWVntmvI8) is a very in depth guide about optimus manager, but I won't go too into detail. All that I stress you to do is not enable PCI-Remove or PCI-Reset. Once you are happy with your optimus manager config, we can continue.

# GRUB Configuration


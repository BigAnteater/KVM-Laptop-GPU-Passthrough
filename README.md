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

Finally, clone the git repository:
```
git clone https://github.com/BigAnteater/KVM-Laptop-GPU-Passthrough && cd KVM-Laptop-GPU-Passthrough
```

# GRUB Configuration

I have made a script to configure the GRUB bootloader for IOMMU. I expect you to be using GRUB because systemd-boot sucks :trollface:

1) Mark the script as executable
```
chmod +x grub_config.sh
```
2) Run the script as a superuser
```
sudo ./grub_config.sh
```
3) Reboot your computer

# Libvirt Configuration

Once you have GRUB configured, you are going to want to set up libvirt. Once again I have set up a script for this because I want you guys to just sit around on your lazy bum.

Setting this up is pretty simple:

1) Mark the script as executable
```
chmod +x libvirt_config.sh
```
2) Run the script as a superuser
```
sudo ./libirt_config.sh
```
Now your Libvirt is good to go!

# QEMU Hooks

To allow the virtual machine to detach your GPU from your laptop and attach the GPU to the VM, you will have to make a hooks script. To keep things simple, I have already made a hooks script for you. The hooks script is based off of [The Passthrough Post's](https://passthroughpo.st/simple-per-vm-libvirt-hooks-with-the-vfio-tools-hook-helper/) hooks script.

To install this script, just follow these steps:

1) Mark the hooks setup script as executable
```
chmod +x hooks_config.sh
```
2) Run the hooks setup script
```
sudo ./hooks_config.sh
```
If you get an error saying something along the lines of: "could not remove /etc/libvirt/hooks no such file or directory", it's not an error it is intended.

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

# Creating the virtual machine

Creating the virtual machine can be done in multiple different ways. I am doing the simple way for the sake of this guide but if you don't happen to have an external monitor + external kb/mouse scroll down to the alternative step.

![IMG_1248](https://user-images.githubusercontent.com/77298458/154849141-f45ef912-4864-442f-bf69-4d87b1a88ddc.jpg)

To create the virtual machine, we will have to follow some pretty easy steps.

1) Open up the fancy new application installed on your computer named virt-manager
![Screenshot_select-area_20220220073205](https://user-images.githubusercontent.com/77298458/154850362-1f7e57cb-1b7f-4786-acf1-6de299d437b3.png)
2) Create a new virtual machine under local install media
![Screenshot_select-area_20220220073407](https://user-images.githubusercontent.com/77298458/154850467-975ece75-e61c-4763-922e-7504f556d0b5.png)
3) Download the windows 10/11 ISO from EvilCorp- sorry I meant Microsoft 🤮
4) Give the VM the ISO that you just downloaded
![Screenshot_select-area_20220220075046](https://user-images.githubusercontent.com/77298458/154851265-f54e5342-8799-41a6-ad6b-64fce214c9b8.png)
5) You can allocate ram & stuff but I would do that some time later.
6) Create a disk for your vm. I reccomend at least 60 gigabytes but allocate more if you want to get some stuff done.
7) Name the VM win10 and make sure to customize configuration before install.
![Screenshot_select-area_20220220075930](https://user-images.githubusercontent.com/77298458/154851718-c4a122da-b711-4e0b-9860-6b963500e0d7.png)
8) Then make sure you are going to want to make sure your firmware is set to OVMF_Code.FD
![Screenshot_select-area_20220220080101](https://user-images.githubusercontent.com/77298458/154852909-c9aab1b9-b329-4b40-a860-3f9e81ed2836.png)
7) Finally, remove the tablet, sound ich9, console 1, and both usb directors.
8) Then press begin installation and go through a normal windows installation.

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

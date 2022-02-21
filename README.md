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

I have yet again created a script to set up the vm for you

1) Mark the script as executable
```
chmod +x vm-config.sh
```
2) Run the script
```
./vm-config.sh
```
3) Your VM is now set up! Just kidding it isn't. Open up virt manager and highlight the win10 VM and click open.
![Screenshot_select-area_20220220111100](https://user-images.githubusercontent.com/77298458/154859937-ad44edf7-42c8-4f4e-a96e-8396b7d163a1.png)
4) I put 2 PCI devices related to your GPU in the VM but you might have 4. To check this, click on "add hardware" > "PCI host device" and add any other PCI devices in the 0000:01:00.* group. Rinse and repeat until all NVIDIA PCI devices are in the VM. (suggest better wording for this please)
![Screenshot_select-area_20220220111800](https://user-images.githubusercontent.com/77298458/154860600-dfedf365-79ec-46ea-bcf9-127dfd0ca7e1.png)
5) Add your USB keyboard and mouse to the VM
![Screenshot_select-area_20220220113108](https://user-images.githubusercontent.com/77298458/154860878-78b195ce-e066-45c0-a0bc-dcfc9fbb12f0.png)
6) Download the Windows 10 ISO from EvilCorp- Microsoft.
7) Add your Windows 10 ISO to the VM
![Screenshot_select-area_20220220114135](https://user-images.githubusercontent.com/77298458/154861086-78293087-01cc-4c7a-9e82-f8410222568b.png)
8) Lastly, add a display spice to the VM so we can install windows later.
![Screenshot_select-area_20220220114449](https://user-images.githubusercontent.com/77298458/154861218-d20235f4-a1b6-4cf9-9b99-7bf8c2636338.png)

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

# Installing Windows + Drivers

Once you have finished settings up the hooks and VM, you are going to want to turn the vm on. If you are switched to your Nvidia card on optimus manager, switch to your integrated graphics. Installing windows should be pretty simple. Do the install from the display spice window on the VM.
![Screenshot_select-area_20220220145030](https://user-images.githubusercontent.com/77298458/154869073-8d13f4a1-a400-42a4-88a7-49b1c43d1fce.png)
Once your Windows is done installing, install the Nvidia driver for your laptop.
![Screenshot_select-area_20220220154225](https://user-images.githubusercontent.com/77298458/154869630-4000737f-3b2a-4e57-af5a-b069b8f5722b.png)
Some people may experience an issue where despite having the driver installed, there will still be no video output. This can be simply fixed by opening the app (on windows) called Turn Windows Features on or off. Then just enable and apply the feature "Hyper-V". After this, everything should be all set up and good to go! You can play around with your VM's settings (passing through USB/audio devices/Changing specs) but I set them to the optimal settings.

# Closing Notes

There is a lot more that you can do with this guide, but I felt that I had to make one on how to do this just to get it out there. I spent many hours browsing reddit/youtube/github and I never found a guide that actaully made sense. After compiling a lot of information from multiple different reddit posts on [r/vfio](https://reddit.com/r/vfio) from many different helpful users, I finally made this guide.

There are many different programs that you can pair with this guide to make it better like [looking glass](https://looking-glass.io) or [scream](https://github.com/duncanthrax/scream) but I won't go over this for the sake of my sanity.

Finally, feel free to edit, suggest, and give feedback to my programs/guides, and have a nice day.

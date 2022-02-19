#!/bin/bash

if [ $EUID -ne 0 ]
	then
		echo "This program must run as root to function."
		exit 1
fi

echo "This program will install your QEMU hooks script. The hooks script is based off of The Passthrough Post."
sleep 1s
echo "All previous hooks scripts will be rewritten in 5 seconds. ctrl + c to cancel."
sleep 5s
echo "Rewriting hooks script..."
rm -rf /etc/libvirt/hooks
cp -r hooks/ /etc/libvirt/
chmod +x "/etc/libvirt/hooks/qemu" "/etc/libvirt/hooks/qemu.d/win10/prepare/begin/start.sh" "/etc/libvirt/hooks/qemu.d/win10/release/end/stop.sh"
echo "Hooks successfully installed!"

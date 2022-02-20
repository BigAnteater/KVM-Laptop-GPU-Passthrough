#!/bin/bash

echo "This program will help set up your VM."

sleep 2s

echo "In gigabytes, how big would you like your disk to be? (for the love of god make it something over 60 gigs you hog)"

read SIZE

sleep 1s

echo "Sounds good!"
sleep 2s

qemu-img create -f qcow2 win10.img "$SIZE"G

clear

sleep 2s

echo "Now we will be adding the VM's XML to Virt-Manager."
sleep 1s

DIR=$(pwd)

sed -i "s|CHANGEME|$DIR|g" win10.xml

virt-xml-validate win10.xml
virsh --connect qemu:///system define win10.xml

sleep 2s

echo "If you get an error saying that the VM failed to valiadte the XMl, that isn't an issue."

sleep 2s

echo "The VM has been successfully configured!"

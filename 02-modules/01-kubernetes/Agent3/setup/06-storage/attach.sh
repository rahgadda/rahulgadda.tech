#!/bin/bash

# -- Connect additional OCI block Storage
# https://www.youtube.com/watch?v=r8hjFOj9Dew
# https://docs.oracle.com/en-us/iaas/Content/Block/Tasks/connectingtoavolume.htm
# -- Partioning Disk
# https://linuxhint.com/creating-and-resizing-xfs-partitions/

# -- List disk partionins - Raw disks, Primary/Logical Partitions & Network Attached Storage
echo -e "\n***********************"
echo      " List all disk details"
echo      "***********************"

lsblk
# fdisk -l

# -- Format disk with xfs
umount /dev/sdb
rm -rf /var/lib/longhorn
mkdir -p -m740 /var/lib/longhorn/
mkfs.ext4  /dev/sdb

#-- Adding entry for auto mount
# fstab=/etc/fstab
# MATCHES=$(grep -n "/var/lib/longhorn/" /etc/fstab)

vi /etc/fstab

# if [ ! -z "$MATCHES" ]
# then
#     echo "" >> /etc/fstab
#     echo "# device       mountpoint           fstype    options     dump   fsck" >> /etc/fstab
#     echo "/dev/sdb       /var/lib/longhorn/    ext4      defaults     0      0" >> /etc/fstab
# else
#     echo "Entry in fstab exists."
# fi

# -- Mounting a file system attaches that file system to a directory (mount point) and makes it available to the system.
# mount /dev/sdb /var/lib/longhorn/
mount -a
echo -e "\n***********************"
echo      "Checking mounting data"
echo      "***********************"
cat /proc/mounts | grep longhorn
cat /proc/self/mounts  | grep longhorn

# umount /dev/sdb

# -- Disk free
df -h | grep longhorn
df -HP -t ext4 | grep longhorn
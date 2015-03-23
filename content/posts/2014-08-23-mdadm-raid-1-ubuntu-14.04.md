# Creating RAID 1 MDADM on an existing Ubuntu install

Remove all the old partions

sudo parted

select /dev/sda
rm 1
rm 2
select /dev/sdb
sudo mkfs.ext4 /dev/sd[a-d]1

#Setup MDADM

sudo mdadm --create --verbose /dev/md0 --level=mirror --raid-devices=2 /dev/sda1 /dev/sdb1

karlcordes@spacex:~$ sudo mdadm --create --verbose /dev/md0 --level=mirror --raid-devices=2 /dev/sda1 /dev/sdb1
mdadm: /dev/sda1 appears to contain an ext2fs file system
size=1953513472K  mtime=Thu Jan  1 10:00:00 1970
mdadm: Note: this array has metadata at the start and
may not be suitable as a boot device.  If you plan to
store '/boot' on this device please ensure that
your boot-loader understands md/v1.x metadata, or use
--metadata=0.90
mdadm: /dev/sdb1 appears to contain an ext2fs file system
size=1953513472K  mtime=Thu Jan  1 10:00:00 1970
mdadm: size set to 1953382208K


karlcordes@spacex:~$ sudo mdadm --create --verbose /dev/md1 --level=mirror --raid-devices=2 /dev/sdc1 /dev/sdd1
mdadm: /dev/sdc1 appears to contain an ext2fs file system
size=1953513472K  mtime=Thu Jan  1 10:00:00 1970
mdadm: Note: this array has metadata at the start and
may not be suitable as a boot device.  If you plan to
store '/boot' on this device please ensure that
your boot-loader understands md/v1.x metadata, or use
--metadata=0.90
mdadm: /dev/sdd1 appears to contain an ext2fs file system
size=1953513472K  mtime=Thu Jan  1 10:00:00 1970
mdadm: size set to 1953382208K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.


karlcordes@spacex:~$ cat /proc/mdstat 
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md1 : active raid1 sdd1[1] sdc1[0]
1953382208 blocks super 1.2 [2/2] [UU]
[>....................]  resync =  0.4% (8139008/1953382208) finish=243.9min speed=132882K/sec

md0 : active raid1 sdb1[1] sda1[0]
1953382208 blocks super 1.2 [2/2] [UU]
[>....................]  resync =  0.4% (9560128/1953382208) finish=253.9min speed=127572K/sec


karlcordes@spacex:~$ cat /proc/mdstat 
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md1 : active raid1 sdd1[1] sdc1[0]
1953382208 blocks super 1.2 [2/2] [UU]
[=>...................]  resync =  7.2% (140990656/1953382208) finish=222.1min speed=135966K/sec

md0 : active raid1 sdb1[1] sda1[0]
1953382208 blocks super 1.2 [2/2] [UU]
[=>...................]  resync =  6.9% (136385792/1953382208) finish=239.9min speed=126214K/sec



## Save the configuration

mdadm --detail --scan >> /etc/mdadm/mdadm.conf

"after you've created your array, it's important to save the configuration in the proper mdadm configuration file. In Ubuntu, this is file /etc/mdadm/mdadm.conf. In some other distributions, this is file /etc/mdadm.conf. Check your distribution's documentation, or look at man mdadm.conf, to see what applies to your distribution.
To save the configuration information:
Ubuntu:

https://raid.wiki.kernel.org/index.php/RAID_setup#Saving_your_RAID_configuration

Add to /etc/fstab
/dev/md0  /mnt/io       ext4  noatime,rw 0 0
/dev/md1  /mnt/europa   ext4  noatime,rw 0 0




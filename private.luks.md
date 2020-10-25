### How to create LUKS image

1. create a file (20MB as a mininum due to LUKS requirements)
```shell
    dd if=/dev/zero of=luksvolume1 bs=1M count=50
```
2. format it with LUKS

```shell
    cryptsetup -vy luksFormat ./luksvolume1
```
3. open container and bind it to the device mapper with 'luksvolume1' name

```shell
    sudo cryptsetup open ./luksvolume1 luksvolume1
```
4. format it

```shell
    sudo mkfs.ext4 /dev/mapper/luksvolume1
```
5. now you can mount it

```shell
    sudo mount /dev/mapper/luksvolume1 /mnt/luksvolume1
```
---
dont forget to unmount and close this container

```shell
    sudo cryptsetup close luksvolume1
```
or check it time to time

```shell
    sudo fsck /dev/mapper/luksvolume1
```



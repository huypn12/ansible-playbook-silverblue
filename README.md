# first-install-suse
To shape a pleasant dev environment on OpenSUSE Tumbleweed.

## 0. Installation
To enable LUKS2 support, press `e` on boot screen, add the following boot option
```
    YAST_LUKS2_AVAILABE=1
```
As LUKS2 support on GRUB is at its early phase (), to encrypt `/boot` with LUKS2 is not a reliable option.
To ease my paranoid brain, I use the following setup
```
    /dev/xx1    /boot/efi   512MiB  FAT     unencrypted
    /dev/xx2    /boot       2GiB    BTRFS   LUKS1 (password decryption)
    /dev/xx3    (lvm)               LUKS2 (token-based decryption)
```

## 1. Fonts
As a Vietnamese, I find Google's Noto satisfying enough as a desktop font. Occasionally I read Japanese, but even so I want full coverage on CJK.
Finally, the little square boxes just upset me as a bowl of noodle without spring onion. So, full set of Noto as desktop font. Story ends.
```
    sudo zypper in noto-fonts google-noto-{sans,serif}-{tc,sc,hk,jp,kr}-fonts-full
```
It takes less than 1GiB to make my eyes happy, why not?

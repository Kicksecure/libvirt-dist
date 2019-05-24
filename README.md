# Whonix Libvirt XML Files for KVM and QEMU #

Libvirt XML files for Whonix-Gateway, Whonix-Workstation,
Whonix-Custom-Workstation and Whonix's internal network.

See also:
- https://www.whonix.org/wiki/KVM
- https://www.whonix.org/wiki/QEMU
## How to install `whonix-libvirt` using apt-get ##

1\. Add [Whonix's Signing Key](https://www.whonix.org/wiki/Whonix_Signing_Key).

```
sudo apt-key --keyring /etc/apt/trusted.gpg.d/whonix.gpg adv --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-keys 916B8D99C38EAF5E8ADC7A2A8D66066A2EEACCDA
```

3\. Add Whonix's APT repository.

```
echo "deb http://deb.whonix.org buster main contrib non-free" | sudo tee /etc/apt/sources.list.d/whonix.list
```

4\. Update your package lists.

```
sudo apt-get update
```

5\. Install `whonix-libvirt`.

```
sudo apt-get install whonix-libvirt
```

## How to Build deb Package ##

Replace `apparmor-profile-torbrowser` with the actual name of this package with `whonix-libvirt` and see [instructions](https://www.whonix.org/wiki/Dev/Build_Documentation/apparmor-profile-torbrowser).

## Contact ##

* [Free Forum Support](https://forums.whonix.org)
* [Professional Support](https://www.whonix.org/wiki/Professional_Support)

## Donate ##

`whonix-libvirt` requires [donations](https://www.whonix.org/wiki/Donate) to stay alive!

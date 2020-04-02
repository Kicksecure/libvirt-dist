# Whonix Libvirt XML Files for KVM and QEMU #

Libvirt XML files for Whonix-Gateway, Whonix-Workstation,
Whonix-Custom-Workstation and Whonix's internal network.

Whonix-Host grub branding, motd and issue banner.

See also:
- https://www.whonix.org/wiki/KVM
- https://www.whonix.org/wiki/QEMU
## How to install `whonix-libvirt` using apt-get ##

1\. Download [Whonix's Signing Key]().

```
wget https://www.whonix.org/patrick.asc
```

Users can [check Whonix Signing Key](https://www.whonix.org/wiki/Whonix_Signing_Key) for better security.

2\. Add Whonix's signing key.

```
sudo apt-key --keyring /etc/apt/trusted.gpg.d/whonix.gpg add ~/patrick.asc
```

3\. Add Whonix's APT repository.

```
echo "deb https://deb.whonix.org buster main contrib non-free" | sudo tee /etc/apt/sources.list.d/whonix.list
```

4\. Update your package lists.

```
sudo apt-get update
```

5\. Install `whonix-libvirt`.

```
sudo apt-get install whonix-libvirt
```

## How to Build deb Package from Source Code ##

Can be build using standard Debian package build tools such as:

```
dpkg-buildpackage -b
```

See [instructions](https://www.whonix.org/wiki/Dev/Build_Documentation/whonix-libvirt). (Replace `package-name` with the actual name of this package.)

## Contact ##

* [Free Forum Support](https://forums.whonix.org)
* [Professional Support](https://www.whonix.org/wiki/Professional_Support)

## Donate ##

`whonix-libvirt` requires [donations](https://www.whonix.org/wiki/Donate) to stay alive!

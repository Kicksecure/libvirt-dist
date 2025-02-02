# Whonix Libvirt XML Files for KVM and QEMU #

Libvirt XML files for Whonix-Gateway, Whonix-Workstation,
Whonix-Custom-Workstation and Whonix's internal network.

Whonix-Host grub branding, motd and issue banner.

Whonix-Host boot popup.

See also:
- https://www.kicksecure.com/wiki/KVM
- https://www.kicksecure.com/wiki/QEMU

## How to install `libvirt-dist` using apt-get ##

1\. Download the APT Signing Key.

```
wget https://www.kicksecure.com/keys/derivative.asc
```

Users can [check the Signing Key](https://www.kicksecure.com/wiki/Signing_Key) for better security.

2\. Add the APT Signing Key.

```
sudo cp ~/derivative.asc /usr/share/keyrings/derivative.asc
```

3\. Add the derivative repository.

```
echo "deb [signed-by=/usr/share/keyrings/derivative.asc] https://deb.kicksecure.com bookworm main contrib non-free" | sudo tee /etc/apt/sources.list.d/derivative.list
```

4\. Update your package lists.

```
sudo apt-get update
```

5\. Install `libvirt-dist`.

```
sudo apt-get install libvirt-dist
```

## How to Build deb Package from Source Code ##

Can be build using standard Debian package build tools such as:

```
dpkg-buildpackage -b
```

See instructions.

NOTE: Replace `generic-package` with the actual name of this package `libvirt-dist`.

* **A)** [easy](https://www.kicksecure.com/wiki/Dev/Build_Documentation/generic-package/easy), _OR_
* **B)** [including verifying software signatures](https://www.kicksecure.com/wiki/Dev/Build_Documentation/generic-package)

## Contact ##

* [Free Forum Support](https://forums.kicksecure.com)
* [Premium Support](https://www.kicksecure.com/wiki/Premium_Support)

## Donate ##

`libvirt-dist` requires [donations](https://www.kicksecure.com/wiki/Donate) to stay alive!

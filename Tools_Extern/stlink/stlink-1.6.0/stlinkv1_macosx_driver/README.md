from: marco.cassinerio@gmail.com

to: texane@gmail.com

Hi,

i managed to get the stlink v1 working under os x and i would like to share the solution so maybe you can
add it in your package.
The problem is that os x claims the device as scsi and libusb won't be able to connect to it.
I've created what is called a codeless driver which claims the device and has a higher priority then the
default apple mass storage driver, so the device can be accessed through libusb.

I tested this codeless driver under OS X 10.6.8 and 10.7.2. I assume it works with any 10.6.x and 10.7.x
version as well.

Attached to this mail you'll find the osx folder with the source code of the driver, both drivers (for
10.6.x and 10.7.x), an install.sh script and the modified Makefile, i only added a line at the end which
invoke the `install.sh`.

First, unpack the `osx.tar.gz` contents:
```bash
tar xzvf osx.tar.gz
```

Then, install the driver using:
```bash
sudo make osx_stlink_shield
```

no reboot required.

P.S. If error `OS X version not supported` occurs. For the latest versions of Mac OS X you may need to change the `osx/install.sh` as follows:
```bash
< ISOSXLION=$(sw_vers -productVersion)
---
> ISOSXLION=$(sw_vers -productVersion | sed -e 's:.[[:digit:]]*$::')
```

### OS X 10.10 Yosemite

For OS X 10.10 Yosemite you must force the system to load unsigned kernelextensions

```bash
sudo nvram boot-args="kext-dev-mode=1“
```

reboot the system!

### OS X 10.11 El Capitan

(Update from another user)

For OS X 10.11 El Capitan: the Yosemite kext seems to work (tested on 10.11.04).

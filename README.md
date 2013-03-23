cleanroom
=========

Bootstrap shell script for a hygienic sysadmin environment

Cleanroom initialises a portable minimal XFCE4 desktop with remote administration and editing tools. Specifically :-

* Safe web browser [Claws] and mail client [Icedove]
* KeePass Password Manager
* SSH and standard Linux tools
* OpenVPN and PPTP VPNs
* Git and SVN clients
* Windows RDP & VNC client (password authentication only)
* Smart Cards for SSH
* Drivers for most laptop hardware

It does not attempt to provide anonymous browsing or a full working environment. Cleanroom is aimed at server administrators. (There are several good privacy orientated Linux distributions, my favourite is [TAILS](https://tails.boum.org).)

No functionality as been provided which is not trivially installable from Debian stable. Cleanroom is not a new Linux distribution, it is only a configuration script of standard packages.


Get Started
-----------
You will need a Debian netinstall ISO, an SD Card (or USB stick, but this is much slower) and an ethernet connection.

1. Make a base installation to your USB stick with the netinstall ISO. Use the "Guided - Set-up encrypted LVM" option. Install Standard System Tools only.
2. Examine (I'm just some random guy on the internet) and execute cleanroom.sh as root.
3. Read the post-boot instructions
4. Reboot

Known Issues
------------
* OpenVPN fails as non-root. Unfortunately, this appears to be a general Debian isssue.
* VIA chipset netbooks (e.g. HP2133 MiniNote) freeze up with Debian. TAILS and Linux Mint both work - perhaps there are some hardware support packages worth borrowing.

TODO
----
* An "inward" facing browser user which is only used for trusted sites, e.g. AWS control panel. Without this using smart cards for both SSH and secure web access would be risky.
* Wheezy has packages for HTTPS Everywhere and Perspectives, this may be worth pulling in. The other Firefox methods for installing plugins from the command-line do not appear to work with Iceweasel.
* RDesktop supports smart cards for RDP in later versions. Might be worth pulling a newer version from wheezy.
* SELinux is tempting. I have experimented, but the default policies literally stop XFCE4 from booting. There are also many reported issues with VPNs etc. Perhaps someone more experienced could suggest a suitable policy set?
* GRSecurity is packaged for Debian, but only as a kernel patch. If there is a simple way to install this that would be great.

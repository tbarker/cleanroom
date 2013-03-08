cleanroom
=========

Bootstrap shell script for a hygienic sysadmin environment

Cleanroom initialises a portable minimal XFCE4 desktop with remote administration and editing tools. Specifically :-

* Safe web browser [Claws] and mail client [Icedove]
* KeePass Password Manager
* SSH and standard Linux tools
* OpenVPN and PPTP VPNs
* Git and SVN clients
* Windows RDP client (password authentication only)
* Smart Cards for SSH
* Drivers for most laptop hardware

It does not attempt to provide anonymous browsing or a full working environment. Cleanroom is aimed at server administrators. (There are several good privacy orientated Linux distributions, my favourite is (TAILS)[https://tails.boum.org/].)

No functionality as been provided that is not trivially installable from Debian stable. Cleanroom is not a development project, it is only a configuration of standard packages. Both the mail client and web browser have their own user accounts, since they are the only likely attack vectors.

Get Started
-----------
You will need a Debian netinstall ISO, a USB stick and an ethernet internet
connection.

1. Make a base installation to your USB stick with the netinstall ISO. Use the "Guided - Set-up encrypted LVM" option.
2. Examine (I'm just some random guy on the internet) and execute cleanroom.sh as root.
3. Read the post-boot instructions
4. Reboot the USB

TODO
----
* The icedove user can currently execute any command as iceweasel. This is excessive.
* RDesktop supports smart cards for RDP in later versions. Might be worth pulling a newer version from wheezy.
* SELinux is tempting. I have experimented, but the default policies literally stop XFCE4 from booting. There are also many reported issues with VPNs etc.
* GRSecurity is packaged for Debian, but only as a kernel patch. If there is a simple way to install this that would be great.

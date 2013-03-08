#!/bin/sh

# To be run ONCE on a fresh Debian install as root.

# Enable contributed and non-free packages (for hardware support)
sed -i 's/squeeze main$/squeeze main contrib non-free/' /etc/apt/sources.list
sed -i 's/update main$/update main contrib non-free/' /etc/apt/sources.list
apt-get update

# Set-up for laptops
tasksel install laptop

# Normal command-line tools
apt-get install -y vim vim-common emacs subversion-tools mtr wipe git wget curl rsync python ruby telnet elinks lftp tftp openssl screen perl netcat nmap whois htop mutt

# Many people have AWS accounts, a few Macs and mount over SSH
apt-get install -y s3cmd
apt-get install -y hfsplus hfsutils xfsprogs encfs sshfs

# Basic XFCE4 desktop with email, web browser and a password manager
apt-get install -y xorg xfce4 gdebi slim
apt-get install -y iceweasel xul-ext-noscript xul-ext-adblock-plus iceweasel-firebug
apt-get install -y claws-mail gnupg gnupg-agent claws-mail-plugins claws-mail-doc
apt-get install -y xfce4-goodies desktop-base tango-icon-theme xfce4-xfapplet-plugin gpart xfce4-notes-plugin xfce4-cellmodem-plugin vim-gnome keepassx thunar-volman
apt-get install -y update-manager-gnome apt-watch-gnome

# Full UI support of common VPNs
apt-get install -y network-manager-gnome network-manager-pptp-gnome network-manager-openvpn-gnome network-manager-vpnc-gnome network-manager-openconnect

# Do not need printers or an extra browser
apt-get remove -y xfprint4
apt-get remove -y epiphany-browser

# Additional drivers I have found useful
apt-get install -y firmware-b43-installer firmware-linux-nonfree xfce4-hdaps firmware-ralink

# Smart Cards
apt-get install -y opensc libccid coolkey openct

# Sandbox email and web under seperate users
adduser iceweasel --gecos "" --disabled-password
adduser claws-mail --gecos "" --disabled-password

# Need to pull them back onto our display
echo "
User_Alias X_USERS = cdrom
Defaults:X_USERS env_reset
Defaults:X_USERS env_keep += DISPLAY
Defaults:X_USERS env_keep += XAUTHORITY

# Any user that can insert a CD, can use web and email sandboxes
# Claws Mail is allowed to reach into the web sandbox user account,
# but not the reverse.
%cdrom ALL=(iceweasel) NOPASSWD:ALL
%cdrom ALL=(claws-mail) NOPASSWD:ALL
%claws-mail ALL=(iceweasel) NOPASSWD: /usr/local/bin/iceweasel, /usr/bin/iceweasel" >> /etc/sudoers.d/sandbox
echo "xhost local:" > /etc/profile.d/sandbox-xsupport.sh

# Override local paths with sandboxed versions
echo "sudo -u iceweasel -H /usr/bin/iceweasel \$1" > /usr/local/bin/iceweasel
echo "sudo -u claws-mail -H BROWSER=/usr/local/bin/iceweasel /usr/bin/claws-mail" > /usr/local/bin/claws-mail
chmod a+x /usr/local/bin/*

# Disable root login for normal users
echo "auth       required   pam_wheel.so" >> /etc/pam.d/su

# Tidy
apt-get -y autoremove

# Not every Iceweasel plugin is packaged
echo ""
echo "------------------------------------------------------------------"
echo "Now reboot the system and install HTTPS Everywhere and Perspectives"
echo "from within Iceweasel"
echo ""


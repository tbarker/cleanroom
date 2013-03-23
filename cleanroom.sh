#!/bin/sh

# To be run ONCE on a fresh Debian install as root.

# Enable contributed and non-free packages (for hardware support)
sed -i 's/squeeze main$/squeeze main contrib non-free/' /etc/apt/sources.list
sed -i 's/update main$/update main contrib non-free/' /etc/apt/sources.list
apt-get update

# Set-up for laptops
# Unattended equivalent to 'tasksel install laptop'
apt-get install -y --force-yes --no-install-recommends wireless-tools acpi-support cpufrequtils acpi wpasupplicant powertop acpid apmd pcmciautils pm-utils anacron avahi-autoipd bluetooth laptop-mode-tools

# Normal command-line tools
apt-get install -y --no-install-recommends subversion-tools mtr wipe git wget mtools mlocate curl rsync python ruby telnet elinks lftp tftp openssl screen perl netcat nmap whois htop mutt
apt-get install -y vim vim-common emacs

# Many people have AWS accounts, a few Macs, Windows boxes and mount over SSH
apt-get install -y --no-install-recommends s3cmd
apt-get install -y --no-install-recommends hfsplus hfsutils xfsprogs encfs sshfs

# Basic XFCE4 desktop with email, web browser and a password manager
apt-get install -y xorg xfce4 gdebi slim gsynaptics
apt-get install -y --no-install-recommends iceweasel foxyproxy xul-ext-noscript xul-ext-adblock-plus iceweasel-firebug
apt-get install -y --no-install-recommends claws-mail gnupg gnupg-agent claws-mail-plugins claws-mail-doc
apt-get install -y --no-install-recommends desktop-base tango-icon-theme xfce4-xfapplet-plugin gpart xfce4-notes-plugin xfce4-cellmodem-plugin vim-gnome keepassx thunar-volman gnome-disk-utility gnome-screensaver ristretto thunar-archive-plugin xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-taskmanager xfce4-datetime-plugin xfce4-screenshooter
apt-get install -y --no-install-recommends update-manager-gnome apt-watch-gnome update-notifier

# RDP and VNC client
apt-get install -y tsclient xvnc4viewer xnest

# Full UI support of common VPNs
apt-get install -y --no-install-recommends network-manager-gnome network-manager-pptp-gnome network-manager-openvpn-gnome network-manager-vpnc-gnome network-manager-openconnect

# Additional drivers as suggested by the package list of TAILS
apt-get install -y --force-yes toshset firmware-linux firmware-linux-nonfree xfce4-hdaps pciutils firmware-ralink firmware-b43-installer firmware-b43legacy-installer firmware-brcm80211 firmware-ipw2x00 firmware-iwlwifi firmware-realtek zd1211-firmware

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
%claws-mail ALL=(iceweasel) NOPASSWD: /usr/local/bin/iceweasel, /usr/bin/iceweasel" > /etc/sudoers.d/sandbox
chmod -R 440 /etc/sudoers.d/sandbox
echo "xhost local:" > /etc/profile.d/sandbox-xsupport.sh

# Override local paths with sandboxed versions
echo "sudo -u iceweasel -H /usr/bin/iceweasel \$1" > /usr/local/bin/iceweasel
echo "sudo -u claws-mail -H BROWSER=/usr/local/bin/iceweasel /usr/bin/claws-mail" > /usr/local/bin/claws-mail
chmod a+x /usr/local/bin/*
ln -s /usr/local/bin/iceweasel /usr/local/bin/sensible-browser

# Disable root login for normal users
echo "auth       required   pam_wheel.so" >> /etc/pam.d/su

# Smart Card configuration
apt-get install -y --no-install-recommends opensc libccid coolkey openct
ls /home | xargs -n 1  usermod -a -G scard
echo "PKCS11Provider /usr/lib/opensc/opensc-pkcs11.so" >> /etc/ssh/ssh_config

# Do not need printers, MTAs or an extra browser
apt-get remove -y --purge xfprint4 cups cups-client
apt-get remove -y --purge epiphany-browser
apt-get remove -y --purge exim4

# Tidy
apt-get -y autoremove
apt-get -y clean

# Not every Iceweasel plugin is packaged
echo ""
echo "------------------------------------------------------------------"
echo "Now reboot the system and install HTTPS Everywhere and Perspectives"
echo "from within Iceweasel"
echo ""


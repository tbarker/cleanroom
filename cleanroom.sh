# Enable contributed and non-free packages (for hardware support)
sed -i 's/squeeze main$/squeeze main contrib non-free/' /etc/apt/sources.list
sed -i 's/update main$/update main contrib non-free/' /etc/apt/sources.list
apt-get update

# Set-up for laptops
tasksel install laptop

# Normal command-line tools
apt-get install -y vim vim-common emacs subversion-tools mtr wipe git wget curl rsync python ruby telnet elinks lftp tftp openssl screen perl netcat nmap whois htop mutt

# People have AWS accounts, a few Macs and mount over SSH
apt-get install -y s3cmd
apt-get install -y hfsplus hfsutils xfsprogs encfs sshfs

# Basic XFCE4 desktop with email, web browser and a password manager
apt-get install -y xorg xfce4 gdebi slim
apt-get install -y iceweasel xul-ext-noscript xul-ext-adblock-plus iceweasel-firebug
apt-get install -y icedove gnupg gnupg-agent enigmail
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

# Harden kernel (Would like to use selinux, but default policies too broken on desktops)
apt-get install -y linux-patch-grsecurity2

# Tidy
apt-get -y autoremove

# Not every Iceweasel plugin is packaged
echo ""
echo "------------------------------------------------------------------"
echo "Now reboot to system and install HTTPS Everywhere and Perspectives"
echo "from within Iceweasel"
echo ""


#!/bin/sh

[ $1 = update ] && { npm udpate shout; whiptail --msgbox "The Lounge updated!" 8 32; break; }
[ $1 = remove ] && { sh sysutils/service.sh remove TheLounge; npm uninstall thelounge; userdel -rf thelounge; groupdel thelounge;  whiptail --msgbox "The Lounge  updated!" 8 32; break; }

# Define port
port=$(whiptail --title "The Lounge port" --inputbox "Set a port number for Shout" 8 48 "9000" 3>&1 1>&2 2>&3)
[ "$port" != "" ] && port_arg=" --port $port"

. sysutils/Node.js.sh

# Add thelounge user
useradd -rU thelounge

# Install
npm install -g thelounge

# Add systemd process and run the server
sh sysutils/service.sh TheLounge "/usr/bin/node /usr/bin/lounge$port_arg" / thelounge

whiptail --msgbox "The Lounge installed!

Open http://$URL:$port in your browser." 10 64

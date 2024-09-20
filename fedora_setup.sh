#!/bin/bash

# Update the system first and foremost.
echo "Getting everything up to date! Remember to reboot."
sleep 1
dnf upgrade -y
sleep 1

# Debloat
echo "Time to debloat!"
sleep 1
dnf remove -y abrt* anthy-unicode firefox firefox-langpacks fedora-bookmarks fedora-chromium-config fedora-flathub-remote mediawriter nano nano-default-editor vim-data vim-minimal libpinyin-data libpinyin-data ibus-libpinyin libzhuyin ibus-libzhuyin yelp gnome-text-editor evince gnome-classic-session baobab gnome-calculator gnome-characters gnome-system-monitor gnome-font-viewer gnome-font-viewer gnome-tour gnome-shell-extension* gnome-weather gnome-boxes gnome-clocks gnome-contacts gnome-logs gnome-remote-desktop loupe libreoffice* rhythmbox snapshot simple-scan totem gnome-calendar gnome-shell-extension-background-logo gnome-maps gnome-connections
sleep 1

# Add Brave's Repo
echo "Adding Brave's Repo"
sleep 1
dnf install dnf-plugins-core
dnf-3 config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sleep 1

# Adding VSCodium's Repo
echo "Adding VSCodium's Repo"
sleep 1
rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | tee -a /etc/yum.repos.d/vscodium.repo

# Remove unused dependencies
echo "Cleaning up!"
sleep 1
dnf autoremove -y
fwupdmgr get-devices
fwupdmgr refresh --force
fwupdmgr get-updates -y
fwupdmgr update -y
sleep 1

# Add flathub and install flatpaks
echo "Enabling Flathub and installing necessary applications"
sleep 1
fedora-third-party enable
fedora-third-party refresh
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.gnome.Calculator org.gnome.Calendar org.gnome.Characters org.gnome.Snapshot org.gnome.Connections org.gnome.Contacts org.gnome.Evince org.gnome.Logs org.gnome.Loupe org.gnome.Maps org.gnome.TextEditor org.gnome.Weather org.gnome.baobab org.gnome.clocks org.gnome.font-viewer org.mozilla.firefox com.mattjakeman.ExtensionManager org.gtk.Gtk3theme.adw-gtk3-dark -y
flatpak upgrade -y

# Add dependencies
echo "You'll be wanting these"
sleep 1
dnf install -y adw-gtk3-theme brave-browser codium gnome-tweaks neovim
sleep 1
echo "The configuration is now complete."

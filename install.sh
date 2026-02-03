#!/usr/bin/env bash
echo "This will delete ALL local files and convert this machine to a Nixbook!"
read -p "Do you want to continue? (y/n): " answer
if [[ $answer =~ ^[Yy]$ ]];then
echo "Installing NixBook..."
rm -rf ~/
mkdir ~/Desktop
mkdir ~/Documents
mkdir ~/Downloads
mkdir ~/Pictures
mkdir ~/.local
mkdir ~/.local/share
cp -R /etc/nixbook/config/config ~/.config
cp /etc/nixbook/config/desktop/* ~/Desktop/
cp -R /etc/nixbook/config/applications ~/.local/share/applications
sudo sed -i '/hardware-configuration\.nix/a\      /etc/nixbook/base.nix' /etc/nixos/configuration.nix
nix-shell -p flatpak --run 'sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo'
sudo nixos-rebuild switch
flatpak install flathub com.google.Chrome -y
flatpak install flathub us.zoom.Zoom -y
flatpak install flathub org.libreoffice.LibreOffice -y
flatpak override --env=ZYPAK_ZYGOTE_STRATEGY_SPAWN=0 us.zoom.Zoom
reboot
else
echo "Nixbook Install Cancelled!"
fi

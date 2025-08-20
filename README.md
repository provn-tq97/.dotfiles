# Install my shit
 - set keyboard layout
 - connect to wlan
 - start archinstall

# Some configs for archinstall
- BTRFS with default subvolumes
- pipewire
- gnome and hyprland (main)

# post install
- clone this repo
- install all needed package
```
sudo pacman -S --noconfirm intel-ucode xorg-xrdb \
    gnome gdm nautilus hyprland wofi waybar kitty \
    swaync hypridle hyprlock hyprpaper hyprsunset \
    natilus hyprpolkitagent hyprcursor cliphist \
    network-manager-applet blueberry bluez-utils \
    dolphin nwg-look tmux oh-my-posh neovim btop \
    cava zsh fzf git lazygit less mariadb stow \
    tlp tlp-rdw tlpui blueman caddy fastfetch grim \
    powertop qt5-wayland qt6-wayland reflector \
    slurp pavucontrol obfuscate zoxide mkcert \
    caddy
```
- install yay and the packages
```
yay -S --noconfirm activate-linux-git activitywatch-bin anki-bin \
    catppuccin-gtk-theme-mocha espanso-wayland \
    microsoft-edge-stable-bin normcap portmaster-stub-bin \
    wlogout ttf-symbola
```

- config fonts
```
# https://github.com/davgar99/arch-linux-font-improvement-guide

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm ttf-fira-code noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-liberation ttf-dejavu ttf-roboto

yay -S --noconfirm tff-symbola

sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/

sudo fc-cache -fv

echo "#########################################"
echo "########### NEXT STEEPS #################"
echo "#########################################"
echo "sudo vim /etc/profile.d/freetype2.sh"
echo "Uncomment the following line from the file."
echo "export FREETYPE_PROPERTIES=\"truetype:interpreter-version=40\""
echo "and refresh with sudo fc-cache -fv"
```
- stow all files
```
stow activitywatch hyprland neofetch tmux-sessionizer zsh \
    backgrounds edge normcap swaync waybar btop \
    espanso kitty nvim systemd wofi cava fontconfig \
    matugen scripts tmux xresources
```
- setup normcap
```
sudo pacman -S --noconfirm tesseract-data-eng \
tesseract-data-ita \
tesseract-data-deu
```

- setup power plan
```
systemctl enable tlp.service
systemctl start tlp.service

systemctl enable NetworkManager-dispatcher.service
systemctl start NetworkManager-dispatcher.service

systemctl mask systemd-rfkill.service systemd-rfkill.socket
```

pls dont break anything :((


# Install my shit
 - set keyboard layout
 - connect to wlan
 - start archinstall

# Some configs for archinstall
- BTRFS with default subvolumes
- pipewire
- gnome and hyprland (main)
- fulldisk encryption

# post install
- clone this repo
- install all needed package
```
sudo pacman -S --noconfirm intel-ucode xorg-xrdb \
    gnome gdm hyprland wofi waybar kitty \
    swaync hypridle hyprlock hyprpaper hyprsunset \
    natilus hyprpolkitagent hyprcursor cliphist \
    network-manager-applet blueberry bluez-utils \
    dolphin nwg-look tmux neovim btop \
    cava zsh fzf git lazygit less mariadb stow \
    tlp tlp-rdw blueman caddy fastfetch grim \
    powertop qt5-wayland qt6-wayland reflector \
    slurp pavucontrol obfuscate zoxide mkcert \
    caddy discord spotify-launcher bat
```
- install yay and the packages
```
yay -S --noconfirm activate-linux-git activitywatch-bin anki-bin \
    catppuccin-gtk-theme-mocha espanso-wayland \
    microsoft-edge-stable-bin normcap portmaster-stub-bin \
    wlogout ttf-symbola
```
- Here are the thing that is in yay
```
 ~ ❯ yay -Qem    
activate-linux-git r363.746a84e-1
activitywatch-bin 0.13.2-1
anki-bin 25.02.6-1
catppuccin-gtk-theme-mocha 1.0.3-1
espanso-wayland 2.2.3-1
gowall 0.2.1-1
hyprshade 4.0.0-1
lavat-git 1:r70.8a78d22-1
libva-intel-driver-irql 2.4.4-1
matugen-bin 2.4.1-1
microsoft-edge-stable-bin 137.0.3296.83-1
normcap 0.5.9-1
portmaster-stub-bin 1.0.0-1
tlpui 2:1.8.0-1
ttf-symbola 14.00-2
wlogout 1.2.2-0
wlrctl 0.2.2-2
yay 12.5.0-1
yay-debug 12.5.0-1
 ~ ❯
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
    matugen scripts tmux xresources chromium bat
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

- add custom pluggins into edge 

- setup github credentials store

- setup activitywatcher with caddy for a custom domain: https://activitywatch.local/ | [docs](https://docs.activitywatch.net/en/latest/getting-started.html)
```
yay -S activitywatch-bin
```

- install all the pluggins for hyprland

- enable notify every 20 minutes

- setup anki (login)

- setup reflector

- make a faster boot time (disable some service on boot ask chat-gpt for the thing that can be disable)

- use some of the optimization https://www.reddit.com/r/archlinux/comments/rz6294/arch_linux_laptop_optimization_guide_for/

- maybe use a different scale 

- install timekpr-next for kinderzeit

- you are ready :)) enjoy it

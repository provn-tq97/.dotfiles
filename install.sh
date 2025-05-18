if [[ $EUID -ne 0 ]]; then
   echo "Bitte führe das Skript mit Root-Rechten aus (sudo)." 
   exit 1
fi

install_pacman_pkg() {
    echo "Installiere $1 über pacman..."
    pacman -S --noconfirm --needed "$1"
}

install_yay_pkg() {
    echo "Installiere $1 über yay..."
    sudo -u "$SUDO_USER" yay -S --noconfirm "$1"
}

echo "### Update System ###"
pacman -Syu --noconfirm
install_pacman_pkg "intel-ucode"

echo "### yay ###"
install_pacman_pkg "git"
install_pacman_pkg "base-devel"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd -
rm -rf yay

echo "### xorg-xrdb ###"
install_pacman_pkg "xorg-xrdb"

echo "### Fonts ###"
# https://github.com/davgar99/arch-linux-font-improvement-guide
PACMAN_FONT_PACKAGES=(
    ttf-fira-code
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    ttf-liberation
    ttf-dejavu
    ttf-roboto
)

for pkg in "${PACMAN_FONT_PACKAGES[@]}"; do
    install_pacman_pkg "$pkg"
done

install_yay_pkg "ttf-symbola"

sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/

sudo fc-cache -fv

echo "### Installiere & Setup Gnome ###"
install_pacman_pkg "gnome"
install_pacman_pkg "gdm"
install_pacman_pkg "nautilus"

systemctl enable gdm.service

echo "### Audio ###"
PACMAN_AUDIO_PACKAGES=(
    pipewire
    pipewire-pulse
    pipewire-alsa
    pipewire-jack
    wireplumber
    alsa-utils
)

for pkg in "${PACMAN_AUDIO_PACKAGES[@]}"; do
    install_pacman_pkg "$pkg"
done

systemctl --user enable --now pipewire.service
systemctl --user enable --now pipewire-pulse.service
systemctl --user enable --now wireplumber.service

echo "### Installiere Hyprland & Stuff ###"
PACMAN_HYPR_PACKAGES=(
    hyprland
    wofi
    waybar
    kitty
    swaync
    hypridle
    hyprlock
    hyprpaper
    hyprsunset
    natilus
    hyprpolkitagent
    hyprcursor
    cliphist
    network-manager-applet
    blueberry
    bluez-utils
    dolphin
)

YAY_HYPR_PACKAGES=(
    wlogout
)

for pkg in "${PACMAN_HYPR_PACKAGES[@]}"; do
    install_pacman_pkg "$pkg"
done

for pkg in "${YAY_HYPR_PACKAGES[@]}"; do
    install_yay_pkg "$pkg"
done

echo "### gtk ###"
install_yay_pkg "catppuccin-gtk-theme-mocha"
install_yay_pkg "nwg-look"

echo "### Browser ###"
install_yay_pkg "microsoft-edge-stable-bin"

echo "### Terminal Stuff ###"
PACMAN_TERMINAL_PACKAGES=(
    tmux
    oh-my-posh
    neovim
    btop
    cava
    zsh
    fzf
    git
    lazygit
    less
    mariadb
    stow
)

for pkg in "${PACMAN_TERMINAL_PACKAGES[@]}"; do
    install_pacman_pkg "$pkg"
done

mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql


chsh -s $(which zsh)

"### stowing the file ###"
stow backgrounds btop cava edge hyprland kitty neofetch nvim scripts swaync tmux waybar wofi xresources zsh fontconfig

echo "### tlp ###"

install_pacman_pkg "tlp"
install_pacman_pkg "tlp-rdw"
install_pacman_pkg "tlpui"

systemctl enable tlp.service
systemctl start tlp.service

systemctl enable NetworkManager-dispatcher.service
systemctl start NetworkManager-dispatcher.service

systemctl mask systemd-rfkill.service systemd-rfkill.socket

echo "#########################################"
echo "########### NEXT STEEPS #################"
echo "#########################################"
echo "Setup nwg-look"
echo "sudo vim /etc/profile.d/freetype2.sh"
echo "Uncomment the following line from the file."
echo "export FREETYPE_PROPERTIES=\"truetype:interpreter-version=40\""
echo "and refresh with sudo fc-cache -fv"

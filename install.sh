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
stow backgrounds btop cava edge hyprland kitty neofetch nvim scripts swaync tmux waybar wofi xresources zsh

echo "### tlp ###"

install_pacman_pkg "tlp"
install_pacman_pkg "tlp-rdw"
install_pacman_pkg "tlpui"

systemctl enable tlp.service
systemctl start tlp.service

systemctl enable NetworkManager-dispatcher.service
systemctl start NetworkManager-dispatcher.service

systemctl mask systemd-rfkill.service systemd-rfkill.socket

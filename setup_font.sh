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

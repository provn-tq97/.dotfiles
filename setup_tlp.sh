systemctl enable tlp.service
systemctl start tlp.service

systemctl enable NetworkManager-dispatcher.service
systemctl start NetworkManager-dispatcher.service

systemctl mask systemd-rfkill.service systemd-rfkill.socket

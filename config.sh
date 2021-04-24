source ./utility.sh

sudo systemctl enable NetworkManager
sudo systemctl enable cronie
sudo systemctl enable geoclue
# Create default user folder such as Music Picutres
xdg-user-dirs-update
# {{{ Ibus
messout "Ibus" info
gsettings set org.freedesktop.ibus.general engines-order "['xkb:us::eng', 'Bamboo']"
gsettings set org.freedesktop.ibus.general preload-engines "['xkb:us::eng', 'Bamboo']"
gsettings set org.freedesktop.ibus.general.hotkey triggers "['<Control>space']"
ibus restart
# }}}
# {{{ .bashrc and .xprofile
messout "bashrc and xprofile" info
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ./source/bash_config/bashrc ~/.bashrc
cp ./source/bash_config/xprofile ~/.xprofile
cp ./source/bash_config/bash_aliases ~/.bash_aliases
cp ./source/bash_config/zshrc ~/.zshrc
cp ./source/bash_config/profile ~/.profile
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/tmux-resurrect/
git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux/tmux-yank/
cp ./source/bash_config/tmux.conf ~/.tmux.conf
sudo usermod --shell /usr/bin/zsh $USER
# }}}
# {{{ Connection
messout "Enable firewall" info
# TODO make a firewall rule
# sudo systemctl enable iptables
# sudo systemctl start iptables
# 
# # http and https
# sudo iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
# sudo iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
# # mail
# sudo iptables -A INPUT -p tcp -m tcp --dport 25 -j ACCEPT
# sudo iptables -A INPUT -p tcp -m tcp --dport 465 -j ACCEPT
# sudo iptables -A INPUT -p tcp -m tcp --dport 110 -j ACCEPT
# sudo iptables -A INPUT -p tcp -m tcp --dport 995 -j ACCEPT
# sudo iptables -A INPUT -p tcp -m tcp --dport 143 -j ACCEPT
# sudo iptables -A INPUT -p tcp -m tcp --dport 993 -j ACCEPT

messout "Change DNS to 8.8.8.8 8.8.4.4" info
add_string_to_file "nameserver 8.8.8.8\nnameserver 8.8.4.4" /etc/resolv.conf.head

messout "Start bluetooth" info
sudo systemctl enable bluetooth
add_string_to_file "# automatically switch to newly-connected devices\nload-module module-switch-on-connect" /etc/pulse/default.pa
add_string_to_file "AutoEnable=true" /etc/bluetooth/main.conf
# }}}
# {{{ Nvidia stuff
echo -e "${GREEN}${BOLD}Fix the fucking tearing problem that made me want to kill myself such when I tried fixing it and finally I did it${NORMAL}${NOCOLOR}\n"
add_string_to_file "options nvidia-drm modeset=1" /etc/modprobe.d/nvidia-drm-nomodeset.conf
sudo update-initramfs -u
# }}}
# {{{ Background
sudo mkdir -p /usr/share/backgrounds/$USER
cp ./source/backgrounds/* ~/Pictures
sudo cp ./source/backgrounds/* /usr/share/backgrounds/$USER
# }}}
# {{{ Default App
messout "Change default apps" info
cp ./source/default_app.list ~/.config/mimeapps.list
# }}}
# {{{ Okular
messout "Okular" info
cp ./source/okular/okularpartrc ~/.config
cp ./source/okular/okularrc ~/.config
cp ./source/okular/okular2 ~/.local/share/okular -r 
# }}}
# {{{ Firefox
messout "Firefox" info
firefox -new-tab -url "https://color.firefox.com/?theme=XQAAAAIrAQAAAAAAAABBqYhm849SCia2CaaEGccwS-xNKlhYao_wZOmecUnjrsET7z8v5L5v2ocjU_4HLB84FLw91EBR-mW3heDhVicLetP0uaHWjen-5ayd0jZeWdPVmm680ivSgrDEidHPled4FH4_MPBLHWe_0YfC-1qT17tEX1c3UjZ-TxvKBg7mVJAnvk0Bv7vuI1LRiC465T9TbPka_uydPTAYMIw2wFb8MdIv05hb7Zqs50xFnXj4Vc9fNrDzdW63-Ol4eWO-Six7b2V-SGeJnH5SF6ElIiSOzv__O9QAAA"
cp ./source/firefox/user.js ~/.mozilla/firefox/*.default-release
cp ./source/firefox/xulstore.json ~/.mozilla/firefox/*.default-release
for d in ~/.mozilla/firefox/*.default-release/ ; do
    mkdir "$d"/chrome -pv
done
cp ./source/firefox/userContent.css ~/.mozilla/firefox/*.default-release/chrome
# }}}
# {{{ Documents
# cp ./source/Documents ~ -r
# }}}
# {{{ Touchpad 
messout "Touchpad" info
sudo cp ./source/devices/touchpad /etc/X11/xorg.conf.d/40-libinput.conf
sudo chmod +r /etc/X11/xorg.conf.d/40-libinput.conf

# }}}
# {{{ i3
messout "i3"
mkdir -p ~/.config/i3
cp ./source/i3/config ~/.config/i3
# }}}
# {{{ urxvt
messout "urxvt"
cp ./source/Xresources ~/.Xresources
# }}}
# {{{ Polybar
mkdir -p .config/polybar
cp ./source/config/polybar ~/.config/polybar
# }}}
# {{{ picom
mkdir -p ~/.config/picom
cp ./source/picom/picom.conf ~/.config/picom
# }}}
# {{{ Redshift
mkdir -p ~/.config/redshift
cp ./source/redshift/redshift.conf ~/.config/redshift
# }}}
# {{{ GTK
git clone https://github.com/vinceliuice/vimix-icon-theme
git clone https://github.com/vinceliuice/vimix-gtk-themes
cd ./vimix-gtk-themes
sh ./install.sh -a
cd ..
rm -rf ./vimix-gtk-themes 
cd vimix-icon-theme
sh ./install.sh Doder
cd ..
rm -rf ./vimix-icon-theme

mkdir -p ~/.config/gtk-3.0
cp ./desktop_environment/gtk.css ~/.config/gtk-3.0/gtk.css
# }}}
# {{{ Thunar, vimwiki
cp ./source/thunar/uca.xml ~/.config/Thunar
cp ./source/vimwiki ~ -r
cp ./source/cmus ~/.config -r
# }}}
# {{{ Python
pip install bs4
pip install wget
pip install mutagen
pip install pynvim
pip install python-language-server[all]
pip install pybluez
# }}}
# {{{ Neovim
messout "nvim" info
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/tmp
mkdir -p ~/.config/nvim/cache	

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp ./source/nvim/init.vim ~/.config/nvim
nvim +PlugInstall +qall

# TODO insert pylint, config pylint
nvim +"CocInstall coc-python coc-sh coc-css coc-json coc-clangs coc-html coc-fzf-preview coc-tsserver" +qall
# }}}
#{{{ Change tmp dir
mkdir -p /.tmp
string="if [[ -O /home/\$USER/.tmp && -d /home/\$USER/.tmp ]]; then\n\tTMPDIR=/home/\$USER/.tmp\nelse\n\t# You may wish to remove this line, it is there in case\n\t# a user has put a file 'tmp' in there directory or a\n\trm -rf /home/\$USER/.tmp 2> /dev/null\n\tmkdir -p /home/\$USER/.tmp\n\tTMPDIR=\$(mktemp -d /home/\$USER/.tmp/XXXX)\nfi\n\nTMP=\$TMPDIR\nTEMP=\$TMPDIR\n\nexport TMPDIR TMP TEMP"

add_string_to_file "$string" /etc/profile

# TODO change to anacron
cron="/var/spool/cron/${USER}"
sudo touch $cron
sudo chown $USER:$USER $cron
sudo chmod 600 $cron
# string="00 12 * * * $(which tmpwatch) 7d ${HOME}/.tmp"
add_string_to_file "00 12 * * * $(which tmpwatch) 7d ${HOME}/.tmp" "$cron"
# add_string_to_file "$string" "$cron"
# }}}
# add_string_to_file "00 12 * * * $(which python3) ${HOME}/tiki_price/gather_data.py" "$cron"


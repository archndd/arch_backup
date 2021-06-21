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
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting

cp -r ./source/bash_config/* ~ 

git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/tmux-resurrect/
git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux/tmux-yank/
sudo usermod --shell /usr/bin/zsh $USER
messout "kitty"
mkdir -p ~/.config/kitty
cp ./source/kitty/kitty.conf ~/.config/kitty
# }}}
# {{{ Connection
messout "Enable firewall" info
messout "Change DNS to 8.8.8.8 8.8.4.4" info
add_string_to_file "nameserver 8.8.8.8\nnameserver 8.8.4.4" /etc/resolv.conf.head
# }}}
# {{{ Pipewire
messout "pipewire"
systemctl enable --user pipewire
systemctl enable --user pipewire-pulse
# }}}
# {{{ Bluetooth
messout "Start bluetooth" info
sudo systemctl enable bluetooth
add_string_to_file "# automatically switch to newly-connected devices\nload-module module-switch-on-connect" /etc/pulse/default.pa
[[ $(grep -qs "^AutoEnable=true$" /etc/bluetooth/main.conf) ]] || sudo sed -i "s/^#AutoEnable=false$/AutoEnable=true/" /etc/bluetooth/main.conf
# }}}
# {{{ Nvidia stuff
echo -e "${GREEN}${BOLD}Fix the fucking tearing problem that made me want to kill myself such when I tried fixing it and finally I did it${NORMAL}${NOCOLOR}\n"
add_string_to_file "options nvidia-drm modeset=1" /etc/modprobe.d/nvidia-drm-nomodeset.conf
sudo update-initramfs -u
# }}}
# {{{ Background
cp ./source/backgrounds/* ~/Pictures
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
cp ./source/firefox/user.js ~/.mozilla/firefox/*.default-release
cp ./source/firefox/xulstore.json ~/.mozilla/firefox/*.default-release
for d in ~/.mozilla/firefox/*.default-release/ ; do
    mkdir "$d"/chrome -pv
done
cp ./source/firefox/userContent.css ~/.mozilla/firefox/*.default-release/chrome
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
# {{{ Polybar
mkdir -p .config/polybar
cp -a ./source/polybar/* ~/.config/polybar
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
mkdir -p ~/.config/gtk-3.0
cp ./source/gtk/* ~/.config/gtk-3.0/
# }}}
# {{{ Dunst
mkdir -p ~/.config/dunst
cp ./source/dunst/dunstrc ~/.config/dunst
# }}}
# {{{ Thunar and Cmus
cp ./source/thunar/uca.xml ~/.config/Thunar
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
mkdir -p ~/.config/nvim ~/.config/nvim/tmp ~/.config/nvim/cache	

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp -r ./source/nvim/ ~/.config/nvim
nvim +PlugInstall +qall

# TODO insert pylint, config pylint
nvim +"CocInstall coc-sh coc-css coc-json coc-clangd coc-html coc-fzf-preview coc-tsserver coc-snippets coc-pyright coc-java" +qall
# }}}
#{{{ Change tmp dir
mkdir -p /.tmp
string="if [[ -O /home/\$USER/.tmp && -d /home/\$USER/.tmp ]]; then\n\tTMPDIR=/home/\$USER/.tmp\nelse\n\t# You may wish to remove this line, it is there in case\n\t# a user has put a file 'tmp' in there directory or a\n\trm -rf /home/\$USER/.tmp 2> /dev/null\n\tmkdir -p /home/\$USER/.tmp\n\tTMPDIR=\$(mktemp -d /home/\$USER/.tmp/XXXX)\nfi\n\nTMP=\$TMPDIR\nTEMP=\$TMPDIR\n\nexport TMPDIR TMP TEMP"

add_string_to_file "$string" /etc/profile

cron="/var/spool/cron/${USER}"
sudo touch $cron
sudo chown $USER:$USER $cron
sudo chmod 600 $cron
add_string_to_file "00 12 * * * $(which tmpwatch) 7d ${HOME}/.tmp" "$cron"
# }}}

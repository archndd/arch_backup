source ./utility.sh

sudo systemctl enable NetworkManager
sudo systemctl enable cronie
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
git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/tmux-resurrect/
git clone https://github.com/tmux-plugins/tmux-yank ~/.tmux/tmux-yank/
cp ./source/bash_config/tmux.conf ~/.tmux.conf
sudo usermod --shell /usr/bin/zsh $USER
# }}}
# {{{ Pomodoro user idle 
messout "Pomodoro" info
sudo chmod 755 ./source/script/* 
sudo cp ./source/script/* /usr/bin --preserve=mode

dconf write /org/gnome/pomodoro/plugins/actions/action0/command "'start_pomodoro.sh'"
dconf write /org/gnome/pomodoro/plugins/actions/action0/name "'Start'"
dconf write /org/gnome/pomodoro/plugins/actions/action0/states "['short-break', 'long-break']"
dconf write /org/gnome/pomodoro/plugins/actions/action0/triggers "['complete']"

dconf write /org/gnome/pomodoro/plugins/actions/action1/command "'bring_to_top.sh'"
dconf write /org/gnome/pomodoro/plugins/actions/action1/name "'bring'"
dconf write /org/gnome/pomodoro/plugins/actions/action1/states "['short-break', 'long-break']"
dconf write /org/gnome/pomodoro/plugins/actions/action1/triggers "['start']"

gsettings set org.gnome.pomodoro.plugins.actions actions-list "['/org/gnome/pomodoro/plugins/actions/action0/', '/org/gnome/pomodoro/plugins/actions/action1/']"
gsettings set org.gnome.pomodoro.preferences enabled-plugins "['sounds', 'actions']"
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
# {{{ Autostartup App
messout "Add startup application: Firefox Terminal Pomodoro" info
mkdir -p ~/.config/autostart
cp ./source/startup/* ~/.config/autostart
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
# {{{ Touchpad and Usb autosuspend
messout "Touchpad" info
sudo cp ./source/devices/touchpad /etc/X11/xorg.conf.d/40-libinput.conf
sudo chmod +r /etc/X11/xorg.conf.d/40-libinput.conf

# }}}
# {{{ Gnome terminal
messout "Gnome terminal" info
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro 13'
terminal_name="$(gsettings get org.gnome.Terminal.ProfilesList default)"
terminal_name=":${terminal_name:1:${#terminal_name}-2}"
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ visible-name 'Duy'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ audible-bell false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ palette "['rgb(39,42,51)', 'rgb(216,70,85)', 'rgb(138,171,110)', 'rgb(226,183,95)', 'rgb(95,136,176)', 'rgb(159,112,151)', 'rgb(106,220,185)', 'rgb(197,208,221)', 'rgb(48,52,63)', 'rgb(255,113,125)', 'rgb(163,189,141)', 'rgb(234,203,139)', 'rgb(128,161,192)', 'rgb(179,142,173)', 'rgb(147,230,204)', 'rgb(229,234,240)']"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ bold-is-bright true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ background-transparency-percent 5
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ use-transparent-background true

# Font
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ cell-height-scale 1.05
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ default-size-columns 133
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ default-size-rows 34
# Color scheme
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ background-color 'rgb(42,42,42)'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ bold-color-same-as-fg true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ bold-is-bright false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ foreground-color 'rgb(229,229,229)'
# }}}
# Alacritty
mkdir -v ~/.config/alacritty
cp ./source/alacritty.yml ~/.config/alacritty
{{{ Desktop environment
messout "Xfce4" info
mkdir -p ~/xfwm
mkdir -p ~/gtktheme
git clone https://github.com/addy-dclxvi/gtk-theme-collections ~/gtktheme
git clone https://github.com/addy-dclxvi/Xfwm4-Theme-Collections ~/xfwm

mkdir -p ~/.themes
cp ~/gtktheme/* ~/.themes -r
cp ~/xfwm/* ~/.themes -r
sudo rm ~/xfwm ~/gtktheme -R

mkdir -p ~/.config/gtk-3.0
cp ./desktop_environment/gtk.css ~/.config/gtk-3.0/gtk.css
source ./desktop_environment/xfce.sh
# }}}
# {{{ Thunar, Anki, vimwiki
cp ./source/thunar/uca.xml ~/.config/Thunar
cp ./source/Anki2 ~/.local/share -r
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
add_string_to_file "00 12 * * * $(which python3) ${HOME}/tiki_price/gather_data.py" "$cron"

# Bluetooth headset battery status
git clone https://github.com/TheWeirdDev/Bluetooth_Headset_Battery_Level
sudo chmod +x ./Bluetooth_Headset_Battery_Level/bluetooth_battery.py


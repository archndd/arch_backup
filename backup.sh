cp ~/.config/nvim/init.vim ~/basic_setup/source/nvim/init.vim
cp -r ~/.config/nvim/ftplugin ~/basic_setup/source/nvim
cp ~/.tmux.conf ~/basic_setup/source/bash_config

cp ~/.config/gtk-3.0/* ~/basic_setup/source/gtk
cp ~/.config/picom/picom.conf ~/basic_setup/source/picom
cp ~/.config/polybar/* ~/basic_setup/source/polybar
cp ~/.config/redshift/redshift.conf ~/basic_setup/source/redshift
cp ~/.config/dunst/dunstrc ~/basic_setup/source/dunst

cp ~/.config/i3/* ~/basic_setup/source/i3

cp ~/.Xresources ~/basic_setup/source/bash_config
cp ~/.bashrc ~/basic_setup/source/bash_config
cp ~/.bash_aliases ~/basic_setup/source/bash_config
cp ~/.zshrc ~/basic_setup/source/bash_config
cp ~/.zsh_func ~/basic_setup/source/bash_config
cp ~/.zsh_lang ~/basic_setup/source/bash_config -r
cp ~/.profile ~/basic_setup/source/bash_config

cp ~/.config/kitty/kitty.conf ~/basic_setup/source/kitty

cp ~/.config/okularrc ~/basic_setup/source/okular
rm ~/basic_setup/source/okular/okular2 -r
cp ~/.local/share/okular ~/basic_setup/source/okular/okular2 -r

rm ~/basic_setup/source/backgrounds -r
mkdir ~/basic_setup/source/backgrounds
cp ~/Pictures/* ~/basic_setup/source/backgrounds

rm ~/basic_setup/source/cmus -r
cp ~/.config/cmus ~/basic_setup/source -r

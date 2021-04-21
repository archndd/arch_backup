cp ~/.config/nvim/init.vim ~/basic_setup/source/nvim/init.vim
cp ~/.tmux.conf ~/basic_setup/source/bash_config/tmux.conf

cp ~/.config/gtk-3.0/* ~/basic_setup/gtk

cp ~/.config/i3/config ~/basic_setup/source/i3
cp ~/.Xresources ~/basic_setup/Xresources

cp ~/.bashrc ~/basic_setup/source/bash_config/bashrc
cp ~/.bash_aliases ~/basic_setup/source/bash_config/bash_aliases
cp ~/.zshrc ~/basic_setup/source/bash_config/zshrc
cp ~/.profile ~/basic_setup/source/bash_config/profile

rm ~/basic_setup/source/vimwiki -r
cp ~/vimwiki ~/basic_setup/source -r
cp ~/.config/okularrc ~/basic_setup/source/okular
rm ~/basic_setup/source/okular/okular2 -r
cp ~/.local/share/okular ~/basic_setup/source/okular/okular2 -r

rm ~/basic_setup/source/backgrounds -r
mkdir ~/basic_setup/source/backgrounds
cp ~/Pictures/* ~/basic_setup/source/backgrounds

rm ~/basic_setup/source/cmus -r
cp ~/.config/cmus ~/basic_setup/source -r

rm ~/basic_setup/source/Documents -r
cp ~/Documents ~/basic_setup/source -r

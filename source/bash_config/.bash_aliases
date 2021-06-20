alias nv="nvim"
alias journalctl="grc journalctl"
alias mkd="mkdir -pv"
alias ls="lsd"
alias SS="sudo systemctl"

# Tmux
alias t="tmux"
alias ta="tmux attach -t"
alias tad="tmux attach -d -t"
alias ts="tmux new-session -s"
alias tl="tmux list-sessions"
alias tksv="tmux kill-server"
alias tkss="tmux kill-session -t"

alias py3="python3" 
alias cnv="nvim ~/.config/nvim/init.vim"
alias iswr="sudo isw -r 16J9EMS1"
alias sus="date; systemctl suspend"
alias shut="shutdown now"
alias reb="reboot"
alias note="nvim ~/vimwiki/index.md"

alias chs="bluetoothctl connect 28:52:E0:FF:64:16"
alias dhs="bluetoothctl disconnect 28:52:E0:FF:64:16"
alias sl="nvim ~/basic_setup/song_manager/song_list"
alias update_song="python3 ~/basic_setup/song_manager/main.py"
alias ncard="optimus-manager --switch nvidia --no-confirm && gnome-session-quit --no-prompt"
alias cat="bat"
# alias fzf="fzf --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200"
alias xret="xrdb ~/.Xresources"
alias disk_usage="ncdu"

cdl () { builtin cd "$@" && ls} 
clear_nvim_swp() { rm ~/.config/nvim/tmp/* }

export ZSH="/home/duy/.oh-my-zsh"

autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd	
stty stop undef

# Path to your oh-my-zsh installation.
HISTSIZE=10000
unsetopt HIST_VERIFY

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -Uz promptinit
promptinit


export LANG=en_US.UTF-8
export EDITOR='nvim'

# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin:$HOME/.local/bin:$PATH
export BAT_THEME="TwoDark"

# fzf --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'

plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.zsh_func ] && source ~/.zsh_func
if [ -d ~/.zsh_lang ]; then
    for f in ~/.zsh_lang/*; do
        source $f;
    done
fi


terminal_name="$(gsettings get org.gnome.Terminal.ProfilesList default)"
terminal_name=":${terminal_name:1:${#terminal_name}-2}"

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ palette "['#32302F', '#CC241D', '#98971A', '#D79921', '#458588', '#B16286', '#689D6A', '#A89984', '#928374', '#FB4934', '#B8BB26', '#FABD2F', '#83A598', '#D3869B', '#8EC07C', '#EBDBB2']"

gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ foreground-color '#EBDBB2'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ background-color '#32302F'

#!/bin/bash
# {{{ Default font
pline "Change default font"
gsettings set org.gnome.settings-daemon.plugins.xsettings hinting 'full'
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro 14'
gsettings set org.gnome.desktop.interface font-name 'Tahoma 12.5'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Tahoma Bold 12'
# }}}
# {{{ Extensions
phead "Extensions"
pline "Dash to dock"
wget -q --show-progress -O /tmp/dash-to-dock.zip https://extensions.gnome.org/review/download/9189.shell-extension.zip
sudo unzip -o /tmp/dash-to-dock.zip -d $HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/
sudo chown $USER -R $HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/
pline "Convert Alt Tab flow"
git clone https://github.com/dmo60/CoverflowAltTab /tmp/CoverflowAltTab
cp -r /tmp/CoverflowAltTab/CoverflowAltTab@dmo60.de/ $HOME/.local/share/gnome-shell/extensions
pline "Clipboard Indicator"
git clone https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git $HOME/.local/share/gnome-shell/extensions/clipboard-indicator@tudmotu.com
pling "Disable Window Animations"
git clone git://github.com/lzap/disable-window-animations ~/.local/share/gnome-shell/extensions/disable-window-animations@github.com
pline "Adding Extensions"
gsettings set org.gnome.shell enabled-extensions "['dash-to-dock@micxgx.gmail.com', 'user-theme@gnome-shell-extensions.gcampax.github.com', 'CoverflowAltTab@dmo60.de', 'clipboard-indicator@tudmotu.com', 'apps-menu@gnome-shell-extensions.gcampax.github.com', 'places-menu@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com']"
# }}} 
# {{{ Numlock
pline "Auto turn on numlock"
gsettings set org.gnome.settings-daemon.peripherals.keyboard numlock-state 'on'
# }}}
# {{{ Nightlight
pline "Enable night light from 5h30PM to 7AM"
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 17.5
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 7.0
# }}}
# {{{ Power management
pline "Set Power management"
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1200
# }}}
# {{{ Topbar
pline "Set top bar to show date and weeknumber"
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface clock-show-date true
# }}}
# {{{ Shortcut
pline "Change swith input source shortcut"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Primary>space']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Primary><Shift>space']"
# }}}
# {{{ Dash to Dock
pline "Config dash to dock"
gsettings set org.gnome.shell.extensions.dash-to-dock click-action "cycle-windows"
gsettings set org.gnome.shell.extensions.dash-to-dock autohide-in-fullscreen true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 56

pline "Favorite apps"
gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop']"
# }}}
# {{{ Theme and Icon
pline "Change theme and icon"
gsettings set org.gnome.shell.extensions.user-theme name "Materia-dark"
gsettings set org.gnome.desktop.interface gtk-theme "Materia-dark"
gsettings set org.gnome.desktop.interface icon-theme "Papirus"
# }}}
# {{{ Terminal
pline "Terminal"
terminal_name="$(gsettings get org.gnome.Terminal.ProfilesList default)"
terminal_name="${terminal_name:1:${#terminal_name}-2}"
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ visible-name 'Duy'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ audible-bell false
# Transparent background
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ use-theme-transparency false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ use-transparent-background true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ background-transparency-percent 5
# Font
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ cell-height-scale 1.05
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ default-size-columns 133
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ default-size-rows 34
# Color scheme
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ background-color 'rgb(42,42,42)'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ bold-color-same-as-fg true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ bold-is-bright true
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${terminal_name}/ foreground-color 'rgb(229,229,229)'
# }}}
# {{{ Other
pline "Remove ubuntu dock"
sudo mv /usr/share/gnome-shell/extensions/ubuntu-dock@ubuntu.com{,.bak}
# }}}

# Theme
xfconf-query -n -c xsettings -p /Net/ThemeName -t string -s "Fantome"
xfconf-query -n -c xsettings -p /Gtk/ColorPalette -t string -s "black:white:gray50:red:purple:blue:light blue:green:yellow:orange:lavender:brown:goldenrod4:dodger blue:pink:light green:gray10:gray30:gray75:gray90"
xfconf-query -n -c xfwm4 -p /general/theme -t string -s "Circela"
xfconf-query -n -c xsettings -p /Net/IconThemeName -t string -s "Papirus"

xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/image-style -t int -s 5
xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace1/image-style -t int -s 5
xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace2/image-style -t int -s 5
xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace3/image-style -t int -s 5
xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace0/last-image -t string -s /usr/share/backgrounds/$USER/deer-lake-sunset.jpg 
xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace1/last-image -t string -s /usr/share/backgrounds/$USER/deer-lake-blue.jpg 
xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace2/last-image -t string -s /usr/share/backgrounds/$USER/deer-lake-purple.jpeg 
xfconf-query -n -c xfce4-desktop -p /backdrop/screen0/monitoreDP-1/workspace3/last-image -t string -s /usr/share/backgrounds/$USER/deer-lake-sunset.jpg 
xfconf-query -n -c xfce4-desktop -p /backdrop/single-workspace-mode -t bool -s false

xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -t bool -s false
xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-home -t bool -s false
xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -t bool -s false
xfconf-query -n -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -t bool -s false

xfconf-query -n -c xfwm4 -p /general/placement_ratio -t int -s 50
xfconf-query -n -c xfwm4 -p /general/show_dock_shadow -t bool -s false
xfconf-query -n -c xfwm4 -p /general/easy_click -t string -s "Super"

xfconf-query -n -c xfwm4 -p /general/title_font -t string -s "Sans Bold 10"
xfconf-query -n -c xsettings -p /Gtk/FontName -t string -s "Candara 15"
xfconf-query -n -c xsettings -p /Gtk/MonospaceFontName -t string -s "Source Code Pro 14"
xfconf-query -n -c xsettings -p /Xft/Antialias -t int -s 1
xfconf-query -n -c xsettings -p /Xft/Hinting -t int -s 1
xfconf-query -n -c xsettings -p /Xft/HintStyle -t string -s "hintfull"
xfconf-query -n -c xsettings -p /Xft/RGBA -t string -s "rgb"
xfconf-query -n -c xsettings -p /Xft/DPI -t int -s 96
xfconf-query -n -c xsettings -p /Xfce/LastCustomDPI -t int -s 96

# Top panel
xfconf-query -n -a -c xfce4-panel -p /panels -t int -s 1
# This has to match the number of plugins below:
xfconf-query -n -c xfce4-panel -p /panels/panel-1/plugin-ids -t int -t int -t int -t int -t int -t int -t int -t int -t int -s 51 -s 56 -s 52 -s 53 -s 54 -s 55 -s 57 -s 58 -s 59

xfconf-query -n -c xfce4-panel -p /plugins/plugin-51 -t string -s applicationsmenu
xfconf-query -n -c xfce4-panel -p /plugins/plugin-56 -t string -s separator
xfconf-query -n -c xfce4-panel -p /plugins/plugin-52 -t string -s tasklist
xfconf-query -n -c xfce4-panel -p /plugins/plugin-53 -t string -s separator
xfconf-query -n -c xfce4-panel -p /plugins/plugin-54 -t string -s clock
xfconf-query -n -c xfce4-panel -p /plugins/plugin-55 -t string -s systray
xfconf-query -n -c xfce4-panel -p /plugins/plugin-57 -t string -s power-manager-plugin
xfconf-query -n -c xfce4-panel -p /plugins/plugin-58 -t string -s pulseaudio
xfconf-query -n -c xfce4-panel -p /plugins/plugin-59 -t string -s actions

xfconf-query -n -c xfce4-panel -p /panels/panel-1/length -t int -s 100
xfconf-query -n -c xfce4-panel -p /panels/panel-1/size -t int -s 30
xfconf-query -n -c xfce4-panel -p /panels/panel-1/position -t string -s "p=6;x=0;y=0"
xfconf-query -n -c xfce4-panel -p /panels/panel-1/position-locked -t bool -s true

xfconf-query -n -c xfce4-panel -p /plugins/plugin-56/expand -t bool -s false
xfconf-query -n -c xfce4-panel -p /plugins/plugin-56/style -t int -s 0

xfconf-query -n -c xfce4-panel -p /plugins/plugin-52/middle-click -t int -s 1
xfconf-query -n -c xfce4-panel -p /plugins/plugin-52/flat-buttons -t bool -s true
xfconf-query -n -c xfce4-panel -p /plugins/plugin-52/show-handle -t bool -s false
xfconf-query -n -c xfce4-panel -p /plugins/plugin-52/show-labels -t bool -s true
xfconf-query -n -c xfce4-panel -p /plugins/plugin-52/show-wireframes -t bool -s false
xfconf-query -n -c xfce4-panel -p /plugins/plugin-52/window-scrolling -t bool -s true
xfconf-query -n -c xfce4-panel -p /plugins/plugin-52/sort-order -t int -s 4

xfconf-query -n -c xfce4-panel -p /plugins/plugin-53/expand -t bool -s true
xfconf-query -n -c xfce4-panel -p /plugins/plugin-53/style -t int -s 0

xfconf-query -n -c xfce4-panel -p /plugins/plugin-54/digital-format -t string -s "%R %d-%m"
xfconf-query -n -c xfce4-panel -p /plugins/plugin-54/mode -t int -s 2

xfconf-query -n -c xfce4-panel -p /plugins/plugin-56/enable-keyboard-shortcuts -t bool -s true

# Shortcut
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Primary><Alt>t" -t string -s "gnome-terminal"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>e" -t string -s "thunar"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Super>t" -t string -s "okular"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Ctrl>q" -t string -s "disable_ctrl_q.sh"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Ctrl><Alt>z" -t string -s "cmus-remote --prev"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Ctrl><Alt>x" -t string -s "cmus-remote --play"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Ctrl><Alt>s" -t string -s "cmus-remote --pause"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Ctrl><Alt>c" -t string -s "cmus-remote --stop"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Ctrl><Alt>a" -t string -s "cmus-remote --next"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Ctrl><Alt>minus" -t string -s "cmus-remote --volume -5%"
xfconf-query -n -c xfce4-keyboard-shortcuts -p "/commands/custom/<Ctrl><Alt>equal" -t string -s "cmus-remote --volume +5%"

# French typing with compose key
xfconf-query -n -c keyboard-layout -p /Default/XkbDisable -t bool -s false
xfconf-query -n -c keyboard-layout -p /Default/XkbLayout -t string -s us
xfconf-query -n -c keyboard-layout -p /Default/XkbOptions/Compose -t string -s compose:rctrl

# Touchpad
xfconf-query -n -c pointers -p /DisableTouchpadDuration -t double -s 0.5000
xfconf-query -n -c pointers -p /DisableTouchpadWhileTyping -t bool -s true
xfconf-query -n -c pointers -p /SynPS2_Synaptics_TouchPad/ReverseScrolling -t bool -s true
xfconf-query -n -c pointers -p /SynPS2_Synaptics_TouchPad/Properties/libinput_Tapping_Enabled -t int -s 1
xfconf-query -n -c pointers -p /SynPS2_Synaptics_TouchPad/Properties/libinput_Tapping_Enabled -t int -t int -t int -t int -t int -t int -t int -s 0 -s 0 -s 0 -s 0 -s 1 -s 3 -s 2

xfconf-query -n -c xfce4-power-manager -p /xfce4-power-manager/power-button-action -t int -s 3
xfconf-query -n -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac -t int -s 15
xfconf-query -n -c xfce4-power-manager -p /xfce4-power-manager/blank-on-battery -t int -s 5
xfconf-query -n -c xfce4-power-manager -p /xfce4-power-manager/dpms-enabled -t bool -s true
xfconf-query -n -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-off -t int -s 60
xfconf-query -n -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-sleep -t int -s 30
xfconf-query -n -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-battery-off -t int -s 20
xfconf-query -n -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-battery-sleep -t int -s 10

# Firefox
firefox -new-tab -url "https://color.firefox.com/?theme=XQAAAAIrAQAAAAAAAABBqYhm849SCia2CaaEGccwS-xNKlhYao_wZOmecUnjrsET7z8v5L5v2ocjU_4HLB84FLw91EBR-mW3heDhVicLetP0uaHWjen-5ayd0jZeWdPVmm680ivSgrDEidHPled4FH4_MPBLHWe_0YfC-1qT17tEX1c3UjZ-TxvKBg7mVJAnvk0Bv7vuI1LRiC465T9TbPka_uydPTAYMIw2wFb8MdIv05hb7Zqs50xFnXj4Vc9fNrDzdW63-Ol4eWO-Six7b2V-SGeJnH5SF6ElIiSOzv__O9QAAA"
# Gnome terminal
terminal_name="$(gsettings get org.gnome.Terminal.ProfilesList default)"
terminal_name=":${terminal_name:1:${#terminal_name}-2}"
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/${terminal_name}/ palette "['rgb(39,42,51)', 'rgb(216,70,85)', 'rgb(138,171,110)', 'rgb(226,183,95)', 'rgb(95,136,176)', 'rgb(159,112,151)', 'rgb(106,220,185)', 'rgb(197,208,221)', 'rgb(48,52,63)', 'rgb(255,113,125)', 'rgb(163,189,141)', 'rgb(234,203,139)', 'rgb(128,161,192)', 'rgb(179,142,173)', 'rgb(147,230,204)', 'rgb(229,234,240)']"
# Xfce
xfconf-query -n -c xsettings -p /Net/ThemeName -t string -s "Fantome"
xfconf-query -n -c xsettings -p /Gtk/ColorPalette -t string -s "black:white:gray50:red:purple:blue:light blue:green:yellow:orange:lavender:brown:goldenrod4:dodger blue:pink:light green:gray10:gray30:gray75:gray90"
xfconf-query -n -c xfwm4 -p /general/theme -t string -s "Circela"

# TODO Vim Tmux

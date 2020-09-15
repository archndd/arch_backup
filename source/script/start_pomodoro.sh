for WINDOW in $(xdotool search Pomodoro); do
   xdotool windowminimize ${WINDOW}
done

while [ $(xprintidle) -ge 2000 ]
do
    sleep 0.1
done
gnome-pomodoro --start

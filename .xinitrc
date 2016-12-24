xrdb -merge .Xresources
xset m 4 &
xset r rate 200 50 &
xcape -e 'Shift_L=Escape;Control_L=Control_L|O'
syndaemon -t -k -i 2 -d 
redshift -l 44.7569:19.126 -t 5500:2700 -m randr -r &
feh --bg-scale ~/pictures/hellhound.jpg &
disable_touchpad &
wmname LG3D &
exec startdwm.sh

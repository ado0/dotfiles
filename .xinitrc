xrdb -merge .Xresources
xset m 4 &
xset r rate 200 50 &
xinput set-prop 10 'Synaptics Move Speed' 2 2 0.125 0 &
xcape -e 'Shift_L=Escape;Control_L=Control_L|O'
syndaemon -t -k -i 2 -d 
redshift -l 44.7569:19.126 -t 5500:2700 -m randr -r &
disable_touchpad &
batdown.sh &
wmname LG3D &
exec startdwm.sh

# syno-whealth-keyboard-rgb-automatic-reseter-
Don' t u hate when ur kb driver gets locked due to bad comunication 
or some random error on usb this is ur fix  
You can also use it with other keyboards 
Just update the detector file to select your keyboard instead 
It is meant to be instaled on systemd driven unix systems  
Copy the .service file in /etc/systed/system and the .sh in /usr/local/bin
To be sure it works as intended add sudo rights sudo chmod 4555 to each file and set the owner root:root
Have fun and feel free to improve on it
it requires usbutils and xdotool to be instaled 

do not forget to do 

systemd daemon-reload 
systemd enable kb-monitor.service
systemd start kb-monitor.service

u can monitor the activity with 
journalctl -u kb-monitor.service -f

Enjoy why I created this well i could not sleep and had a keyboard issue 

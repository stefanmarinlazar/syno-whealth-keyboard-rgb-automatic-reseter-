#set  this file in usr/local/bin
#!/bin/bash
#requires xdotool
#requires usbutils
# 1. Auto-identify Keyboard
KB_ID=$(lsusb | grep -i "Sino Wealth" | head -n 1 | awk '{print $6}')

if [ -z "$KB_ID" ]; then
    exit 1
fi

echo "Monitoring Keyboard ID: $KB_ID"

# 2. Watch dmesg for errors
dmesg -w | while read -r line; do
    if echo "$line" | grep -qi "$KB_ID" && echo "$line" | grep -qEi "error -71|error -110|disconnect"; then
        echo "Crash detected. Clearing input buffer and resetting..."

        # --- ANTI-STUCK LOGIC START ---
        # 1. Force release all keys (requires xdotool)
        # Note: We use 'display :0' to target your desktop session from the root service
        DISPLAY=:0 XAUTHORITY=$(find /run/user/$(id -u $(stat -c '%U' /dev/tty1)) -name "Xauthority" | head -n 1) \
        xdotool keyup Enter Escape Control_L Alt_L Shift_L
        
        # 2. Flush the X11 keyboard state
        DISPLAY=:0 setxkbmap -layout $(DISPLAY=:0 localectl status | grep "X11 Layout" | awk '{print $3}')
        # --- ANTI-STUCK LOGIC END ---

        # Perform the actual hardware reset
        /usr/bin/usbreset "$KB_ID"
    fi
done


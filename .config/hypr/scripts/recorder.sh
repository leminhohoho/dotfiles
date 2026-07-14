#!/bin/bash
if pgrep -x "wf-recorder" > /dev/null
then
    pkill -INT -x wf-recorder
    notify-send "Screen Recording" "Recording stopped and saved"
else
    # Records the full screen
    # wf-recorder -f ~/Videos/$(date +%Y-%m-%d_%H-%m-%s).mp4
    
    # OR Records a selected area using slurp
    wf-recorder -g "$(slurp)" -f ~/Videos/$(date +%Y-%m-%d_%H-%m-%s).mp4
    
    notify-send "Screen Recording" "Recording started"
fi


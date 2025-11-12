#!/bin/bash

sudo pacman -S --needed alsa-utils pipewire pipewire-alsa pipewire-pulse wireplumber rtkit pavucontrol easyeffects --noconfirm

systemctl --user enable --now pipewire pipewire-pulse wireplumber
sleep 2

aplay -l
pactl list sinks short

echo "Enter sink name:"
read -r SINK_NAME

if [ -n "$SINK_NAME" ]; then
    pactl set-default-sink "$SINK_NAME"
    pactl set-sink-mute "$SINK_NAME" 0
    pactl set-sink-volume "$SINK_NAME" 80%
fi

systemctl --user restart pipewire pipewire-pulse wireplumber
sleep 2

pactl info | grep "Default Sink"

# alsamixer
# speaker-test -c 2 -t wav

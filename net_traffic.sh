#!/bin/sh

while :; do
vnstat -tr 2 | xargs | awk '{printf "%d%.1s %d%.1s", $16,$17,$21,$22}' > $HOME/.vnstat.log
sleep 5
done & 

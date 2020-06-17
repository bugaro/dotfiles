#!/bin/sh

function battery() {
	capacity=$(< /sys/class/power_supply/BAT0/capacity)
	if (($capacity >= 0 && $capacity <= 5))
	then echo -n "+@fn=1;1<"
	elif (($capacity > 5 && $capacity <= 25))
	then echo -n "+@fn=1;1<"
	elif (($capacity > 25 && $capacity <= 50))
	then echo -n "+@fn=1;1<"
	elif (($capacity > 50 && $capacity <= 75))
	then echo -n "+@fn=1;1<"
	else echo -n "+@fn=1;1<"
	fi
}
function vol() {
	vol=$(pactl list sinks | awk '$1=="Volume:" {print $5}')
	mute=$(pactl list sinks | awk '$1=="Mute:" {print $2}')
	if [[ $mute == "no" ]];
	then echo -n "+@fn=1;+@fn=0;+1<$vol+@fn=1;1<"
	else echo -n "+@fn=1;1<"
	fi
}

while :; do
	vol
	battery
	echo "+@fn=0;"
	
	sleep 1
done

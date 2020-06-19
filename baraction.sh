#!/bin/sh

function cpu() {
  read cpu a b c previdle rest < /proc/stat
  prevtotal=$((a+b+c+previdle))
  sleep .5 
  read cpu a b c idle rest < /proc/stat
  total=$((a+b+c+idle))
  cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
  echo -n "+@fn=1;+@fn=0;+1<$cpu%+@fn=1;1<"
}
function using_mem() {
	mem=$(free | awk '$1=="Mem:" {result = $3 / $2 * 100; printf "%.0f", result}')
	echo -n "+@fn=1;+@fn=0;+1<$mem%+@fn=1;1<"
}
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
	cpu
	using_mem	
	vol
	battery
	echo "+@fn=0;"
	
	sleep .5
done

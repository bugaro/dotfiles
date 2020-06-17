#
# ~/.bash_profile
#

if [[ "$(tty)" == '/dev/tty1' ]]; then
exec startx
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

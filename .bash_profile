#
# ~/.bash_profile
#
w # uptime information and who is logged in
echo "" # for spacing
df -h -x tmpfs -x udev # disk usage, minus def and swap

[[ -f ~/.bashrc ]] && . ~/.bashrc

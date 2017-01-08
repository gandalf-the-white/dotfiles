#
# ~/.bash_profile
#
echo "" # for spacing
w # uptime information and who is logged in
echo "" # for spacing
df -h -x tmpfs -x udev # disk usage, minus def and swap

echo "" # for spacing

[[ -f ~/.bashrc ]] && . ~/.bashrc

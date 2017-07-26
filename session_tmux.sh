#!/bin/sh 

# To put in the .local/bin directory

eval `ssh-agent`
ssh-add ~/.ssh/id_rsa

tmux new-session  -d -s 'the_hack' -n 'the hack' 'ssh the_hack'
tmux new-window   -n 'the maas' 'ssh the_maas'
tmux new-window   -n 'the openstack' 'ssh the_openstack'
#tmux split-window -v 'python'
#tmux split-window -h
#tmux new-window 'top'
tmux -2 attach-session -d 

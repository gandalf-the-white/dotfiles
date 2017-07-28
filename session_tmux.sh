#!/bin/sh 

# To put in the .local/bin directory

eval `ssh-agent`
ssh-add ~/.ssh/id_rsa

tmux new-session  -d -s 'Cowboy Bebop' -n 'faye'
tmux split-window -h
tmux split-window -v
tmux new-window -n 'the hack' 'ssh the_hack'
tmux new-window -n 'the maas' 'ssh the_maas'
tmux new-window -n 'the openstack' 'ssh the_openstack'
tmux new-window -n 'the cdpweather' 'ssh the_cdpweather'
tmux new-window -n 'the database' 'ssh the_database'

tmux -2 attach-session -d 

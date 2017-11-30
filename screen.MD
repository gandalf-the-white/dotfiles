# How to share a session on the same account
Firtsly, we'll crete a detached session
```
screen -d -m -S shared
```
In second, we attach on this session
```
screen -ls
screen -x shared
```

And finally, on a other terminal, with the same account of course
```
screen -x shared
```

Et voila


# To install my home computer
## Introduction
This document describes the installation of main important softwares on my computer.
- imaps server dovecot 
- getmail to pull emails
- mutt to read my emails
- libgtop11dotnet to read my pki usb key
- weechat and bitlbee to connect on the sipe internal server
- many simple tools ....
- and my home environment

## Dovecot
### Simple install
Before to start and for security reason, we have to create a new user to store the mails from many users. [ref01]
```sh
# groupadd -g 5000 vmail
# useradd -u 5000 -g vmail -s /usr/bin/nologin -d /home/vmail -m vmail
```
let'get copying the right files on the dovecot directory
```sh
# cp /etc/ssl/dovecot-openssl.cnf{.sample,} .
```
modify with my favorite editor 
```sh
# vi /etc/ssl/dovecot-openssl.cnf
```
and execute to generate the certificates
```sh
# /usr/lib/dovecot/mkcert.sh
```
now we drun
```sh
# cp /etc/ssl/certs/dovecot.pem /etc/ca-certificates/trust-source/anchors/dovecot.crt
```
and validate by
```sh
# trust extract-compat
```
It's time to modify the core of dovecot.
First, we copy the basic configuration files
```sh
# cp /usr/share/doc/dovecot/example-config/dovecot.conf /etc/dovecot
# cp -r /usr/share/doc/dovecot/example-config/conf.d /etc/dovecot
```
and let's begin to adapt our environment.
```sh
# cat 10-auth.conf
...
auth_mechanisms = plain
passdb {
  driver = passwd-file
  args = /etc/dovecot/passwd
}
userdb {
  driver = static
  args = uid=vmail gid=vmail home=/home/vmail/%u
}
...
```
```sh
cat 10-ssl.conf
...
ssl = yes
ssl_cert = </etc/ssl/certs/dovecot.pem
ssl_key = </etc/ssl/private/dovecot.pem
...
```
### PAM authentication
To configure PAM for dovecot, create /etc/pam.d/dovecot with the following content:
```sh
# cat /etc/pam.d/dovecot
...
auth    required        pam_unix.so nullok
account required        pam_unix.so 
...
```
### getmail
We need to config files
* deliver
* getmail.bebop
So write theses files in your $HOME/.getmail directory
```sh
# cat ~/.getmail/deliver
retriever]
type = SimpleIMAPSSLRetriever
server = XXXX
username = XXXX
password = XXXX
mailboxes = ("INBOX",)
port = 993

[destination]
type = MDA_external
path = /usr/lib/dovecot/deliver
arguments = ("-e", "-f", "%(sender)", "-d", "spike")
user = vmail
group = vmail

[options]
received = false
delivered_to = false
read_all = false
verbose = 2
message_log = deliver.log
message_log_verbose = true
delete = true
```
and 
```sh
# cat ~/.getmail/getmail.bebop
[retriever]
type = SimpleIMAPSSLRetriever
server = bebop
mailboxes = ("Inbox", ) # optional - leave this line out to just grab inbox
username = XXXX
password = XXXX
port = 993

[destination]
type = MDA_external
path = /usr/bin/procmail
arguments = ("-f", "%(sender)", "-m", "/home/spike/.procmailrc")

[options]
verbose = 2
message_log = ~/.getmail/gmail.log
read_all = false
delete = true
```
The first config file will be execute by root to update dovecot and the second to move in my home directory **~/Maildir**

The collect is started every 10mn with a simple cron on root and me

For root
```sh
# crontab l
*/10 * * * *	/usr/bin/getmail -g /home/spike/.getmail/ -r deliver
```
and for me (spike)
```sh
# crontab -l
*/10  *  *  *  *  /usr/bin/getmail --rcfile getmail.bebop
```
### procmail
Don't forget to install procmail and create a config file
```sh
# cat ~/.procmailrc
PATH=/bin:/usr/bin
MAILDIR=$HOME/Mail/
DEFAULT=$MAILDIR
LOGFILE=$HOME/.getmail/procmail.log
SHELL=/bin/bash

:0 w
$MAILDIR/Inbox/
```
### mutt
The most important element of mutt configuration is the muttrc describing the folder and so one
```sh
# cat ~/.mutt/muttrc
...
set mbox_type  = Maildir
set folder     = "~/Mail/"
set spoolfile  = "+Inbox"
set record     = "+Sent"
set postponed  = "+Drafts"
...
```
Of course, the mailboxes has to represent the directories ~/Mail/
```sh
# cat ~/.mutt/mailboxes
...
mailboxes +Inbox
mailboxes +bebop
mailboxes +bebop.administratif
mailboxes +bebop.linuxsupport
...
```
## IM messenger
I propose to use the couple weechat/bitlbee, weechat for the simplicity and bitlbee to adapt multi protocols.


[ref01]: <https://wiki.archlinux.org/index.php/Virtual_user_mail_system>

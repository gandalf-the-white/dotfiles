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
## Getmail
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

[ref01]: <https://wiki.archlinux.org/index.php/Virtual_user_mail_system>

# Dillinger

Dillinger is a cloud-enabled, mobile-ready, offline-storage, AngularJS powered HTML5 Markdown editor.

  - Type some Markdown on the left
  - See HTML in the right
  - Magic

You can also:
  - Import and save files from GitHub, Dropbox, Google Drive and One Drive
  - Drag and drop files into Dillinger
  - Export documents as Markdown, HTML and PDF

Markdown is a lightweight markup language based on the formatting conventions that people naturally use in email.  As [John Gruber] writes on the [Markdown site][df1]

> The overriding design goal for Markdown's
> formatting syntax is to make it as readable
> as possible. The idea is that a
> Markdown-formatted document should be
> publishable as-is, as plain text, without
> looking like it's been marked up with tags
> or formatting instructions.

This text you see here is *actually* written in Markdown! To get a feel for Markdown's syntax, type some text into the left window and watch the results in the right.

### Version
3.2.7

### Tech

Dillinger uses a number of open source projects to work properly:

* [AngularJS] - HTML enhanced for web apps!
* [Ace Editor] - awesome web-based text editor
* [markdown-it] - Markdown parser done right. Fast and easy to extend.
* [Twitter Bootstrap] - great UI boilerplate for modern web apps
* [node.js] - evented I/O for the backend
* [Express] - fast node.js network app framework [@tjholowaychuk]
* [Gulp] - the streaming build system
* [keymaster.js] - awesome keyboard handler lib by [@thomasfuchs]
* [jQuery] - duh

And of course Dillinger itself is open source with a [public repository][dill]
 on GitHub.

### Installation

Dillinger requires [Node.js](https://nodejs.org/) v4+ to run.

You need Gulp installed globally:

```sh
$ npm i -g gulp
```

```sh
$ git clone [git-repo-url] dillinger
$ cd dillinger
$ npm i -d
$ NODE_ENV=production node app
```

### Plugins

Dillinger is currently extended with the following plugins

* Dropbox
* Github
* Google Drive
* OneDrive

Readmes, how to use them in your own application can be found here:

* [plugins/dropbox/README.md] [PlDb]
* [plugins/github/README.md] [PlGh]
* [plugins/googledrive/README.md] [PlGd]
* [plugins/onedrive/README.md] [PlOd]

### Development

Want to contribute? Great!

Dillinger uses Gulp + Webpack for fast developing.
Make a change in your file and instantanously see your updates!

Open your favorite Terminal and run these commands.

First Tab:
```sh
$ node app
```

Second Tab:
```sh
$ gulp watch
```

(optional) Third:
```sh
$ karma start
```

### Docker
Dillinger is very easy to install and deploy in a Docker container.

By default, the Docker will expose port 80, so change this within the Dockerfile if necessary. When ready, simply use the Dockerfile to build the image.

```sh
cd dillinger
docker build -t <youruser>/dillinger:latest .
```
This will create the dillinger image and pull in the necessary dependencies. Once done, run the Docker and map the port to whatever you wish on your host. In this example, we simply map port 80 of the host to port 80 of the Docker (or whatever port was exposed in the Dockerfile):

```sh
docker run -d -p 80:80 --restart="always" <youruser>/dillinger:latest
```

Verify the deployment by navigating to your server address in your preferred browser.

### N|Solid and NGINX

More details coming soon.

#### docker-compose.yml

Change the path for the nginx conf mounting path to your full path, not mine!

### Todos

 - Write Tests
 - Rethink Github Save
 - Add Code Comments
 - Add Night Mode

License
----

MIT


**Free Software, Hell Yeah!**

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [dill]: <https://github.com/joemccann/dillinger>
   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [john gruber]: <http://daringfireball.net>
   [@thomasfuchs]: <http://twitter.com/thomasfuchs>
   [df1]: <http://daringfireball.net/projects/markdown/>
   [markdown-it]: <https://github.com/markdown-it/markdown-it>
   [Ace Editor]: <http://ace.ajax.org>
   [node.js]: <http://nodejs.org>
   [Twitter Bootstrap]: <http://twitter.github.com/bootstrap/>
   [keymaster.js]: <https://github.com/madrobby/keymaster>
   [jQuery]: <http://jquery.com>
   [@tjholowaychuk]: <http://twitter.com/tjholowaychuk>
   [express]: <http://expressjs.com>
   [AngularJS]: <http://angularjs.org>
   [Gulp]: <http://gulpjs.com>

   [PlDb]: <https://github.com/joemccann/dillinger/tree/master/plugins/dropbox/README.md>
   [PlGh]:  <https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md>
   [PlGd]: <https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md>
   [PlOd]: <https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md>

#!/bin/bash

#http://ubuntuforums.org/showthread.php?t=159661

fw_start() {
   fw_clear

   iptables -t filter -P INPUT DROP
   iptables -t filter -P OUTPUT DROP
   iptables -t filter -P FORWARD DROP

   iptables -t filter -A INPUT -i lo -j ACCEPT
   iptables -t filter -A OUTPUT -o lo -j ACCEPT

   iptables -t filter -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
   iptables -t filter -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

   ### SNMP SERVICE
   iptables -t filter -A INPUT -p icmp -j DROP
   iptables -t filter -A OUTPUT -p icmp -j ACCEPT

   ### MYSQL
   #iptables -A OUTPUT -p tcp -m tcp --dport 3306 -j ACCEPT

   ### SSH
   iptables -t filter -A OUTPUT -o wlp12s0 -p tcp -m tcp --dport 22 -j ACCEPT
   iptables -t filter -A INPUT -i wlp12s0 -p tcp  --dport 1984 -j ACCEPT

   ### HTTP HTTPS
   iptables -t filter -A OUTPUT -p tcp -m multiport --dports 80,443,8000 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
   #iptables -t filter -A INPUT -p tcp -m multiport --sports 80,443,8000 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
   iptables -t filter -A INPUT -p tcp -m multiport --dports 80,443,8000 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
   #iptables -A INPUT -i eth0 -p tcp -m tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT 
   #iptables -A OUTPUT -o eth0 -p tcp -m tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT

   ### DHCP
   #iptables -A INPUT -i eth0 -p udp --sport 67 --dport 68 -j ACCEPT
   iptables -A INPUT -p udp --sport 67 --dport 68 -j ACCEPT
   #iptables -A OUTPUT -o eth0 -p udp --sport 68 --dport 67 -j ACCEPT
   iptables -A OUTPUT -p udp --sport 68 --dport 67 -j ACCEPT
   
   ### DNS
   iptables -t filter -A OUTPUT -p udp -m udp --dport 53 -m conntrack --ctstate NEW,RELATED,ESTABLISHED -j ACCEPT
   iptables -t filter -A INPUT -p udp -m udp --sport 53 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

   ### SMTP
   #iptables -A OUTPUT -p tcp -m tcp --dport 25 -j ACCEPT
   #iptables -A OUTPUT -p tcp -m tcp --dport 110 -j ACCEPT
   #iptables -A OUTPUT -p tcp -m tcp --dport 2525 -j ACCEPT

   ### NTP
   #iptables -A OUTPUT -p udp -m udp --dport 123 -j ACCEPT

   ### OPENVPN
   #iptables -A OUTPUT -p udp -m udp --dport 1194 -j ACCEPT

   ### MAIL
   #iptables -A OUTPUT -p tcp -m tcp --dport 2525 -j ACCEPT
   #iptables -A OUTPUT -p tcp -m tcp --dport 993 -j ACCEPT
   #iptables -A OUTPUT -p tcp -m tcp --dport 389 -j ACCEPT
   
   ### MESSENGER
   #iptables -A OUTPUT -p tcp -m tcp --dport 5060:5061 -j ACCEPT
   #iptables -A INPUT -p tcp -m tcp --sport 6667 -j ACCEPT
   #iptables -A OUTPUT -p tcp -m tcp --dport 6667 -j ACCEPT

   ### IP DENIED
   #iptables -A INPUT -s 192.168.0.200 -j DROP
}

fw_stop() {
   iptables -F
   iptables -X

   iptables -P INPUT ACCEPT
   iptables -P OUTPUT ACCEPT
   iptables -P FORWARD ACCEPT

   iptables -L -n
}

fw_clear() {

   iptables -t nat -F
   iptables -t mangle -F
   iptables -t raw -F

   iptables -P INPUT DROP
   iptables -P OUTPUT DROP
   iptables -P FORWARD DROP

}

case "$1" in
   start)
      fw_start
      ;;
   stop)
      fw_stop
      ;;
   restart)
      fw_stop
      fw_start
      ;;
   *)
      echo "Usage: iptables.sh {start|stop|restart}" >&2
      exit 1
      ;;
esac

exit 0

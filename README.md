# This image is currently in development!

## How to use:

docker run --name freepbx -d -p 5060:5060/udp -p 8080:80 adito/freepbx

### Publish dynamic ports manually

You need to publish a range of [UDP Ports for RTP](https://wiki.freepbx.org/display/PPS/Ports+used+on+your+PBX). By default this range is set to 10000-20000.

Docker got huge problems with publishing multiple thousand ports. Docker will create one iptables rule per port instead of one rule with a range of ports.

```
iptables -L | grep sip
```

After starting the container use the iptables command to get the container ip. Now create the following rules with the ip from the command before (replace 172.17.0.2).

```
iptables -A DOCKER -t nat -p udp -m udp --dport 10000:20000 -j DNAT --to-destination 172.17.0.2:10000-20000
iptables -A DOCKER -d 172.17.0.2/32 ! -i docker0 -o docker0 -p udp -m udp --dport 10000:20000 -j ACCEPT
iptables -A POSTROUTING -t nat -s 172.17.0.2/32 -d 172.17.0.2/32 -p udp -m udp --dport 10000:20000 -j MASQUERADE
```


## ToDo

- creating a concept to save for persistent configuration
- use supervisord
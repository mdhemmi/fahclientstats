# How to create a config.json file - WORK IN PROGRESS

```
nmap 192.168.0.0/24 -p36330 --open -oG - | awk '/36330\/open/{print $2}'
```

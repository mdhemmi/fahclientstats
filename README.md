# Folding at Home client stats

Command line based container to collect stats from each FaH client in your network 

  - create a folder fahclientstats

# For example on Linux
```
mkdir /opt/fahclientstats
```

- create a config.json file equal to the example below (host1 would be the hostname of the client)

```
vi /opt/fahclientstats/config.json
```
```
{
   "hosts":{
      "host1":"192.168.0.10",
      "host2":"192.168.0.20",
      "host3":"192.168.0.30",
      "host4":"192.168.0.40",
      "host5":"192.168.0.50"
   },
   "password":"VMware1!"
}
```
# Run the container

```
docker run --rm -v /opt/fahclientstats/config.json:/opt/fahclientstats/config.json --name fahclientstats mdhemmi/fahclientstats
```

# For example on MacOS
```
mkdir ~/Document/fahclientstats
```
  - create a config.json file equal to the example below (host1 would be the hostname of the client)
```
vi ~/Document/fahclientstats/config.json
```
```
{
   "hosts":{
      "host1":"192.168.0.10",
      "host2":"192.168.0.20",
      "host3":"192.168.0.30",
      "host4":"192.168.0.40",
      "host5":"192.168.0.50"
   },
   "password":"VMware1!"
}
```
# Run the container

```
docker run --rm -v ~/Document/fahclientstats/config.json:/opt/fahclientstats/config.json --name fahclientstats mdhemmi/fahclientstats
```
# Example ouput  

```
host1 - State: DOWNLOAD Percent done: 0.00% PPD: 0 TPF: 0.00 secs ETA:  0.00 secs SLOT: 00 Creditestimate: 0
host2 - State: DOWNLOAD Percent done: 0.00% PPD: 0 TPF: 0.00 secs ETA:  0.00 secs SLOT: 00 Creditestimate: 0
host3 - State: DOWNLOAD Percent done: 0.00% PPD: 0 TPF: 0.00 secs ETA:  0.00 secs SLOT: 01 Creditestimate: 0
host3 - State: RUNNING Percent done: 49.37% PPD: 699237 TPF: 2 mins 02 secs ETA:  1 hours 42 mins SLOT: 00 Creditestimate: 98735
host4 - State: RUNNING Percent done: 61.20% PPD: 3728 TPF: 4 mins 02 secs ETA:  2 hours 36 mins SLOT: 01 Creditestimate: 1044
host4 - State: DOWNLOAD Percent done: 0.00% PPD: 0 TPF: 0.00 secs ETA:  0.00 secs SLOT: 00 Creditestimate: 0
host5 - State: RUNNING Percent done: 11.04% PPD: 59525 TPF: 6 mins 32 secs ETA:  9 hours 41 mins SLOT: 01 Creditestimate: 27007
```

# open topics

- collection speed using the expect script
- extend functionality to send the stats to an InfluxDB

# Please provide feedback and ideas for further improvements



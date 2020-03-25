# InfluxDb setup

Requirement:

  - running InfluxDB system

Create Influx database

```
influx -precision rfc3339

create database folding
```

Extend the config.json file with a influxdb section:

```
{
   "hosts":{
      "host1":"192.168.0.10",
      "host2":"192.168.0.20",
      "host3":"192.168.0.30",
      "host4":"192.168.0.40",
      "host5":"192.168.0.50"
   },
   "influxdb":{
      "ip":"192.168.0.5",
      "port":"8086",
      "db":"folding"
   },
   "password":"VMware1!"
}
```

That's all what is necessary to send the following metrics to a influxdb.

  - percentdone
  - creditestimate
  - pp

  - percentdone
  - creditestimate
  - ppd

# Example setup on MacOS

```
mkdir ~/Documents/fahclientstats
```
  - create a config.json file equal to the example below (host1 would be the hostname of the client)
```
vi ~/Documents/fahclientstats/config.json
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
Run the container

```
docker run --rm -v ~/Documents/fahclientstats/config.json:/opt/fahclientstats/config.json --name fahclientstats mdhemmi/fahclientstats
```

# Redirect
Easily expose ports on live/running containers

This image can be used to expose live container ports

This command to Expose a container
```
docker run --privileged -v /proc:/host/proc -e HOST_PORT=10056 -e DEST_IP=172.17.0.2 -e DEST_PORT=3306 -e OPERATION=A wlan0/redirect:latest
```

This command to remove the expose
```
docker run --privileged -v /proc:/host/proc -e HOST_PORT=10056 -e DEST_IP=172.17.0.2 -e DEST_PORT=3306 -e OPERATION=D wlan0/redirect:latest
```

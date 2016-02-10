
https://github.com/gogits/gogs/tree/master/docker

To keep your data out of Docker container, we do a volume(/var/gogs -> /data) here, and you can change it based on your situation.

# Pull image from Docker Hub.
$ docker pull gogs/gogs

# Create local directory for volume.
$ mkdir -p /var/gogs

# Use `docker run` for the first time.
$ docker run --name=gogs -p 10022:22 -p 10080:3000 -v /var/gogs:/data gogs/gogs

# Use `docker start` if you have stopped it.
$ docker start gogs


[![](https://images.microbadger.com/badges/image/ksobolev/yourkit.svg)](https://microbadger.com/images/ksobolev/yourkit "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/ksobolev/yourkit.svg)](https://microbadger.com/images/ksobolev/yourkit "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/ksobolev/yourkit.svg)](https://microbadger.com/images/ksobolev/yourkit "Get your own license badge on microbadger.com")

# YourKit Docker image
Docker image for running [YourKit](https://www.yourkit.com) profiler remotely, based on [consol/centos-xfce-vnc](https://hub.docker.com/r/consol/centos-xfce-vnc/).

Image comes without YourKit license, you will have to provide your own or request a trial.

Primary use case is opening large Java heap dumps on a beefy AWS EC2 instance.

# Sample steps
- create a EC2 instance with enough RAM, depending on your snapshot size
- run `ssh -i <private_key> -L 5901:localhost:5901 -L6901:localhost:6901 ec2-user@<external_ip> 'curl -o- https://raw.githubusercontent.com/eprst/yourkit_docker/master/amzn2_install.sh | bash'` where `<private_key>` is a path to the private key and `<external_ip>` is instance external IP
- connect to VNC at `localhost:5901` or in a browser at [localhost:6901/vnc.html](http://localhost:6901/vnc.html), password is `vnc`

Storage on `/dev/nvme0n1` will be mounted to `~/Snapshots` if present, this is an ephemeral volume usually. In any case make sure to have enough disk space for the snapshots.

# Running manually
- ssh to your instance with VNC port forwarding: `ssh -i <private_key> -L 5901:localhost:5901 -L6901:localhost:6901 ec2-user@<external_ip>`
- make sure Docker is installed and running
- do a `docker run -d -p 5901:5901 -p 6901:6901 ksobolev/yourkit`

# Extra configuration
Docker environment variables:
- `VNC_COL_DEPTH`, default: `24`
- `VNC_RESOLUTION`, default: `1400x768`
- `VNC_PW`, default: `vnc`

Example:
```
docker run -d -p 5901:5901 -p 6901:6901 -e VNC_PW=mypassword ksobolev/yourkit
```

YourKit Java process is configured to use 12G of RAM by default. This can be configured in `~/.yjp/ui.ini` inside the container. Don't give it too much as there's also an off-heap process involved. 

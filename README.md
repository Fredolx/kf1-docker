# kf1-docker

First, download the game using steamcmd (you can use the docker image)
```
@sSteamCmdForcePlatformType windows
force_install_dir /data/data-windows
login youruser
app_update 215350
```

Then you need to copy the DLLs from the windows version of steamcmd to the `System` folder of Killing Floor

```
cp steamcmd/steamclient.dll kfserver/System
cp steamcmd/tier0_s.dll kfserver/System
cp steamcmd/vstdlib_s.dll kfserver/System
```

Create a podman user using the provided script `create-podman.sh podman-kf1`

Then login to it using
```
sudo machinectl shell podman-kf1@ /bin/bash
```

Install and modify the `kf1.container` to `.config/containers/systemd`

Refresh services
```
systemctl --user daemon-reload
```

Enable auto updates

```
systemctl --user enable podman-auto-update.timer
```

Start the server
```
systemctl --user start kf1
```



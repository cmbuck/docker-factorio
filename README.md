# docker-factorio

A small, simple containerized Factorio server. Suitable for local and hosted servers. Simple, low-configuration and highly customizable. Forked from sover02/docker-factorio to support custom server-settings files and SIGINT/SIGTERM from native docker commands.

## Building the image
```bash
docker build -t docker-factorio .
```

## Running
On x86 machines:
```bash
docker run --name docker-factorio -itp 34197:34197/udp 6davids/docker-factorio
docker run --name docker-factorio -itdp 34197:34197/udp 6davids/docker-factorio # runs detached
```

On m1 Macs:
```bash
docker run --name docker-factorio -itp 34197:34197/udp --platform linux/amd64 6davids/docker-factorio # ctrl-c kills server
docker run --name docker-factorio -itdp 34197:34197/udp --platform linux/amd64 6davids/docker-factorio # runs detached
```

## Server Commands

Interactive:
```bash
david@focus docker-factorio % docker attach docker-factorio
 250.157 Info ServerMultiplayerManager.cpp:943: updateTick(15117) received stateChanged peerID(1) oldState(ConnectedDownloadingMap) newState(ConnectedLoadingMap)
 250.341 Info ServerMultiplayerManager.cpp:943: updateTick(15127) received stateChanged peerID(1) oldState(ConnectedLoadingMap) newState(TryingToCatchUp)
 250.342 Info ServerMultiplayerManager.cpp:943: updateTick(15127) received stateChanged peerID(1) oldState(TryingToCatchUp) newState(WaitingForCommandToStartSendingTickClosures)
 250.355 Info GameActionHandler.cpp:4996: UpdateTick (15127) processed PlayerJoinGame peerID(1) playerIndex(0) mode(connect) 
 250.407 Info ServerMultiplayerManager.cpp:943: updateTick(15131) received stateChanged peerID(1) oldState(WaitingForCommandToStartSendingTickClosures) newState(InGame)
2022-04-09 06:08:43 [JOIN] david joined the game
sup
2022-04-09 06:08:51 [CHAT] <server>: sup
2022-04-09 06:09:46 [CHAT] david: lol
/kick david lol
```


## Starting, Stopping, Restarting the Server

Starting and stopping can be done with docker commands

```bash
david@focus docker-factorio % docker stop docker-factorio
david@focus docker-factorio % docker start docker-factorio
```


## Saved Games

By default the container creates a new game and then uses it from then on. If you'd like to use your own games, create two mounts when running the container:
- `/app/factorio/saves/`
- `/app/factorio/last-game.txt`

Drop your save files in the `saves/` directory, and then enter the name of the save file you'd to use into `last-game.txt` 

Example: 
```bash
david@focus docker-factorio % cp my-cool-saved-game.zip ~/factorio-stuffs/saved-games/ 
david@focus docker-factorio % echo "my-cool-saved-game.zip" > ~/factorio-stuffs/last-game.txt 
david@focus docker-factorio % # Start the container detached, with ports mounted, and the two binds mentioned above
david@focus docker-factorio % docker run --name docker-factorio -it \
> -d
> -p 34197:34197/udp \
> --mount type=bind,source=~/factorio-stuffs/saved-games,target=/app/factorio/saves \
> --mount type=bind,source=~/factorio-stuffs/last-game.txt,target=/app/factorio/last-game.txt \
> 6davids/docker-factorio
abdac7023091
david@focus docker-factorio % # We're ready to go
```

## Custom Settings

Specifying custom server settings is optional. If specified, they managed the same way that saved games are.  This is the same example as above with the addition of a custom server-settings file.
```bash
david@focus docker-factorio % cp my-cool-saved-game.zip ~/factorio-stuffs/saved-games/ 
david@focus docker-factorio % echo "my-cool-saved-game.zip" > ~/factorio-stuffs/last-game.txt 
david@focus docker-factorio % # Start the container detached, with ports mounted, and the two binds mentioned above
david@focus docker-factorio % docker run --name docker-factorio -it \
> -d
> -p 34197:34197/udp \
> --mount type=bind,source=~/factorio-stuffs/saved-games,target=/app/factorio/saves \
> --mount type=bind,source=~/factorio-stuffs/last-game.txt,target=/app/factorio/last-game.txt \
> --mount type=bind,source=~/factorio-stuffs/server-settings.json,target=/app/factorio/server-settings.json \
> docker-factorio
abdac7023091
david@focus docker-factorio % # We're ready to go
```

## To-Do

## Links

- Repository: https://github.com/cmbuck/docker-factorio
- Forked from: https://github.com/sover02/docker-factorio

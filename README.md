# pulseaudio-docker
Base image for GUI apps that play audio through the host's sound server.

It extends `nvidia-gui-app` with the PulseAudio client library (`libpulse0`) and
tools (`pactl`, `paplay`). No sound server runs in the container: apps connect
as clients to the host's server (PulseAudio, or PipeWire through
`pipewire-pulse`) via its UNIX socket, mounted at `/tmp/pulse/native`.

## Build args
| Arg | Default | Description |
|---|---|---|
| `BASE_IMAGE` | `nvidia-gui-app:26.04` | Base image to extend (e.g. the `-graphics` variant or plain `gui-app`) |

## Build
```bash
docker build -t pulseaudio:26.04 .
```

## Run
```bash
./run.sh pactl info                                   # should show the host server
./run.sh paplay /usr/share/sounds/alsa/Front_Center.wav   # if the file exists
```

`run.sh` mounts `$XDG_RUNTIME_DIR/pulse/native` read-only and passes its
arguments as the command. Child images only need the same socket mount.

## Notes
* `pulse-client.conf` points libpulse at the mounted socket, disables
  autospawning a server and disables SHM (`shm_open() failed` otherwise).
* Apps that only speak ALSA get no sound. If one needs it, install
  `libasound2-plugins` plus an `asound.conf` routing `default` to `pulse` in
  that app's image (~150MB, it pulls ffmpeg).
* Qt Multimedia apps log `Couldn't load pipewire-0.3 library` and fall back to
  PulseAudio; this is expected.

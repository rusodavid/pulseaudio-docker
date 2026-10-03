ARG BASE_IMAGE=nvidia-gui-app:26.04
FROM ${BASE_IMAGE}
ARG DEBIAN_FRONTEND=noninteractive

ENV XDG_RUNTIME_DIR=/tmp

# PulseAudio client only: apps talk to the host server (PulseAudio or
# pipewire-pulse) through the socket mounted at /tmp/pulse/native
RUN apt-get update && \
    apt-get install -y --no-install-recommends libpulse0 pulseaudio-utils && \
    rm -rf /var/lib/apt/lists/*

COPY pulse-client.conf /etc/pulse/client.conf

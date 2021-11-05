FROM nvidia-gui-app:latest 

ARG USER=pulseaudio 

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --yes alsa-base alsa-utils pulseaudio

# Set up the user
#RUN export USER=$USER UID=1001 GID=1001 && \
#    mkdir -p "/home/${USER}" && \
#    echo "${USER}:x:${UID}:${GID}:${USER} User,,,:/home/${USER}:/bin/bash" >> /etc/passwd && \
#    echo "${USER}:x:${UID}:" >> /etc/group && \
#    mkdir -p /etc/sudoers.d && \
#    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
#    chmod 0440 /etc/sudoers.d/${USER} && \
#    chown ${UID}:${GID} -R /home/${USER} && \
#    gpasswd -a ${USER} audio

COPY pulse-client.conf /etc/pulse/client.conf

VOLUME ["/tmp/pulse", "/usr/local/etc/pulse"]

#USER $USER
#ENV HOME /home/pulseaudio

# run
#CMD ["pulseaudio", "-vvvv", "/dev/urandom"]

FROM ubuntu:noble

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=debian_user
ARG PASS=ansible

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  dbus \
  git \
  gnupg \
  lsb-release \
  snapd \
  software-properties-common \
  sudo \
  systemd \
  systemd-sysv \
  vim && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean

RUN useradd --create-home -m -s /bin/bash $USER && \
  echo "$USER:$PASS" | chpasswd && \
  touch /home/$USER/.bashrc && \
  chown -R $USER:$USER /home/$USER && \
  echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apt-add-repository -y ppa:ansible/ansible && \
  apt-get update && \
  apt-get install -y --no-install-recommends ansible && \
  apt-get clean && rm -rf /var/lib/apt/lists/*
RUN ansible-galaxy collection install community.general

COPY --chown=$USER:$USER . /home/$USER/
WORKDIR /home/$USER

ENV USER=$USER
USER $USER

STOPSIGNAL SIGRTMIN+3
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/sbin/init"]

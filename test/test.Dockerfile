FROM ubuntu:noble

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=bazel_user

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  git \
  gnupg \
  lsb-release \
  software-properties-common \
  sudo \
  rm -rf /var/lib/apt/lists/* /tmp/core_packages && \
  apt-get clean

RUN useradd --create-home -m -s /bin/bash $USER && \
  touch /home/$USER/.bashrc && \
  chown -R $USER:$USER /home/$USER && \
  echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apt-add-repository -y ppa:ansible/ansible && \
  apt-get update && \
  apt-get install -y --no-install-recommends ansible && \
  apt-get clean && rm -rf /var/lib/apt/lists/*
RUN ansible-galaxy collection install community.general community.docker

COPY --chown=$USER:$USER . /home/$USER/
WORKDIR /home/$USER

ENV USER=$USER
USER $USER

CMD ["/bin/bash"]


FROM archlinux:base-devel-20250803.0.394512

ARG USER=arch_user

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN pacman -Syu --noconfirm && \
  pacman -S --noconfirm \
  ansible \
  base-devel \
  ca-certificates \
  curl \
  git \
  python \
  python-pip \
  sudo \
  systemd \
  vim \
  which && \
  update-ca-trust && \
  pacman -Scc --noconfirm

RUN useradd --create-home -m -s /bin/bash $USER && \
  echo "$USER:ansible" | chpasswd && \
  touch /home/$USER/.bashrc && \
  chown -R $USER:$USER /home/$USER && \
  echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN ansible-galaxy collection install community.general

COPY --chown=$USER:$USER . /home/$USER/
WORKDIR /home/$USER

ENV USER=$USER
USER $USER

CMD ["/bin/bash"]

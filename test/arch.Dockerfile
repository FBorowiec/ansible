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
  vim \
  which && \
  update-ca-trust && \
  pacman -Scc --noconfirm

RUN useradd --create-home -m -s /bin/bash $USER && \
  touch /home/$USER/.bashrc && \
  chown -R $USER:$USER /home/$USER && \
  echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN ansible-galaxy collection install community.general

USER $USER
COPY --chown=$USER:$USER . /home/$USER/
ENV USER=$USER
WORKDIR /home/$USER

CMD ["/bin/bash"]

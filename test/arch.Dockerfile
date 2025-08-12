FROM archlinux:base-devel-20250803.0.394512

ARG USER=arch_user

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN pacman -Syu --noconfirm && \
  pacman -S --noconfirm \
  ansible \
  base-devel \
  curl \
  git \
  python \
  python-pip \
  sudo \
  vim \
  which && \
  pacman -Scc --noconfirm

RUN useradd --create-home -m -s /bin/bash $USER && \
  touch /home/$USER/.bashrc && \
  chown -R $USER:$USER /home/$USER && \
  echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN ansible-galaxy collection install community.general community.docker kewlfft.aur

USER $USER
WORKDIR /tmp
RUN git clone https://aur.archlinux.org/yay.git && \
  cd yay && makepkg -si --noconfirm && \
  cd / && rm -rf /tmp/yay

COPY --chown=$USER:$USER . /home/$USER/
WORKDIR /home/$USER

ENV USER=$USER
USER $USER

CMD ["/bin/bash"]

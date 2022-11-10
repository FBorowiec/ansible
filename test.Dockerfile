FROM ubuntu:focal AS base

WORKDIR /usr/local/bin

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-add-repository -y ppa:neovim-ppa/unstable && \
    apt update && \
    apt install -y curl git ansible build-essential neovim sudo gsettings-desktop-schemas

RUN echo 'root:root' | chpasswd
ARG USER=ansible_tester
ARG PASS="ansible"
RUN useradd --create-home -m -s /bin/bash $USER && echo "$USER:$PASS" | chpasswd && adduser $USER sudo

USER $USER
WORKDIR /home/$USER
RUN mkdir /home/$USER/Downloads
COPY . .

USER root
RUN chown -R $USER /home/$USER
USER $USER
ENV USER=$USER

RUN ln -sf /bin/bash /bin/sh
CMD ["/bin/bash"]

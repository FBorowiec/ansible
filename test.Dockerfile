FROM ubuntu:focal AS base
ARG TAGS
WORKDIR /usr/local/bin
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-add-repository -y ppa:neovim-ppa/unstable && \
    apt update && \
    apt install -y curl git ansible build-essential neovim sudo gsettings-desktop-schemas
RUN ln -sf /bin/bash /bin/sh
RUN echo 'root:ansible_root' | chpasswd
ARG USER=ansible_tester
ARG PASS="ansible"
RUN useradd --create-home -m -s /bin/bash $USER && echo "$USER:$PASS" | chpasswd && adduser $USER sudo
USER ansible_tester
WORKDIR /home/$USER
RUN mkdir /home/$USER/Downloads
COPY . .
USER root
RUN chown -R ansible_tester /home/ansible_tester
USER ansible_tester
ENV USER=$USER
CMD ["sh", "-c", "ansible-playbook $TAGS local.yml --ask-become-pass"]

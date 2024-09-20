# Using Ubuntu Focal as the base image
FROM ubuntu:noble AS base

# Avoid prompting from apt
ARG DEBIAN_FRONTEND=noninteractive

# Create a non-root user for better security
ARG USER=ansible_tester
ARG PASS="ansible"

# Setting the work directory
WORKDIR /home/$USER

# Setting the default shell to bash
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install required packages and add repositories in one layer to reduce image size,
# clean up the apt cache to reduce image size
RUN apt-get update && \
  apt-get install -y software-properties-common curl git sudo gsettings-desktop-schemas && \
  apt-add-repository -y ppa:ansible/ansible && \
  apt-add-repository -y ppa:neovim-ppa/unstable && \
  apt-get update && \
  apt-get install -y ansible build-essential neovim && \
  echo 'root:root' | chpasswd && \
  useradd --create-home -m -s /bin/bash $USER && \
  echo "$USER:$PASS" | chpasswd && \
  adduser $USER sudo && \
  mkdir -p /home/$USER/Downloads && \
  chown -R $USER:$USER /home/$USER && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Copying the application files
COPY . /home/$USER/

# Change ownership of the copied files
RUN chown -R $USER:$USER /home/$USER

# Changing the user to non-root
USER $USER

# Setting the environment variable
ENV USER=$USER

# Setting the default command
CMD ["/bin/bash"]

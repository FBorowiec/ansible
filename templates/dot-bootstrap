#!/usr/bin/env bash

set -e

set -eif ! [ -x "$(command -v ansible)" ]; then
    sudo apt-get update && sudo apt-get install -y git ansible
fi

# Dotfiles' project root directory
ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Host file location
HOSTS="$ROOTDIR/hosts"
# Main playbook
PLAYBOOK="$ROOTDIR/dotfiles.yml"

# Installs ansible

# Runs Ansible playbook using our user.
ansible-playbook -i "$HOSTS" "$PLAYBOOK" --ask-become-pass

if command -v terminal-notifier 1>/dev/null 2>&1; then
    terminal-notifier -title "dotfiles: Bootstrap complete" -message "Successfully set up dev environment."
fi

exit 0

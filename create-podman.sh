#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <username>"
    exit 1
fi

USERNAME=$1

if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root or with sudo."
    exit 1
fi

echo "Creating user '$USERNAME' with no login shell..."
useradd -m -s /usr/sbin/nologin "$USERNAME"

echo "Enabling lingering for '$USERNAME'..."
loginctl enable-linger "$USERNAME"

echo "Creating Podman Quadlet directories for '$USERNAME'..."

su -s /bin/bash "$USERNAME" -c "mkdir -p ~/.config/containers/systemd/"

echo "Adding systemd environment variables to .bashrc..."
BASHRC_PATH="/home/$USERNAME/.bashrc"

echo 'export XDG_RUNTIME_DIR="/run/user/$(id -u)"' >> "$BASHRC_PATH"
echo 'export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"' >> "$BASHRC_PATH"

chown "$USERNAME":"$USERNAME" "$BASHRC_PATH"

echo "Success! User '$USERNAME' is fully configured for rootless Podman."
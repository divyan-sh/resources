#!/bin/bash

# Prompt for email to associate with the SSH key
read -p "Enter your GitHub email: " github_email

# Prompt for the filename to save the SSH key
read -p "Enter the filename for the SSH key (default: github_key): " key_filename

# Set default filename if none is provided
key_filename=${key_filename:-github_key}

# Generate SSH key
ssh-keygen -t ed25519 -C "$github_email" -f ~/.ssh/$key_filename -q -N ""

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add the key to the SSH agent
ssh-add --apple-use-keychain ~/.ssh/$key_filename

# Add the host configuration to ~/.ssh/config
ssh_config_file=~/.ssh/config
if [ ! -f "$ssh_config_file" ]; then
    touch "$ssh_config_file"
fi

echo -e "\nHost github.com" >> "$ssh_config_file"
echo "  HostName github.com" >> "$ssh_config_file"
echo "  User git" >> "$ssh_config_file"
echo "  IdentityFile ~/.ssh/$key_filename" >> "$ssh_config_file"
echo "  UseKeychain yes" >> "$ssh_config_file"

# Print the public key
echo "Your SSH public key is:"
cat ~/.ssh/$key_filename.pub

# Instructions to add the key to GitHub
echo "Copy the above key and add it to your GitHub account: https://github.com/settings/keys"

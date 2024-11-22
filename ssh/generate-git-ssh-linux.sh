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

# Add the new key to the SSH agent

ssh-add ~/.ssh/$key_filename

# Print the public key

echo "Your SSH public key is:"
cat ~/.ssh/$key_filename.pub

# Instructions to add the key to GitHub

echo "Copy the above key and add it to your GitHub account: https://github.com/settings/keys"

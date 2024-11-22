### How to Use:

1. Save the script as `generate_github_ssh.sh` and make it executable:
   ```bash
   chmod +x generate_github_ssh.sh
   ```
2. Run the script:
   ```bash
   ./generate_github_ssh.sh
   ```
3. During execution:
   - Enter your GitHub email when prompted.
   - Provide a custom filename (e.g., `my_custom_key`) or press Enter to use the default (`github_key`).
   - The script will generate the SSH key, add it to the SSH agent, and display the public key.

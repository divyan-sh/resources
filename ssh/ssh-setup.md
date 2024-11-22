Here are the step-by-step commands for setting up SSH keys for GitHub on macOS, including configuring the SSH agent, adding the key to the Keychain, and setting up `~/.ssh/config`:

---

### **Step 1: Generate an SSH Key**

```bash
ssh-keygen -t ed25519 -C "your-email@example.com" -f ~/.ssh/github_key -q -N ""
```

- Replace `your-email@example.com` with your GitHub email.
- Replace `github_key` with your preferred filename, or leave it as is.

---

### **Step 2: Start the SSH Agent**

```bash
eval "$(ssh-agent -s)"
```

---

### **Step 3: Add the SSH Key to the SSH Agent and Keychain**

(For MacOS)

```bash
ssh-add --apple-use-keychain ~/.ssh/github_key
```

(For Linux)

```bash
ssh-add ~/.ssh/github_key
```

---

### **Step 4: Configure GitHub in the SSH Config** (Optional only for mac users)

1. Open the SSH configuration file:

   ```bash
   nano ~/.ssh/config
   ```

2. Add the following lines:

   ```
   Host github.com
     HostName github.com
     User git
     IdentityFile ~/.ssh/github_key
     UseKeychain yes
   ```

3. Save and exit the file (`CTRL+O`, `Enter`, `CTRL+X`).

---

### **Step 5: Copy the Public Key**

```bash
cat ~/.ssh/github_key.pub
```

- Copy the output and add it to your GitHub account:
  - Go to [GitHub SSH Settings](https://github.com/settings/keys).
  - Click **New SSH Key**.
  - Paste the key and save.

---

### **Step 6: Test the SSH Connection**

```bash
ssh -T git@github.com
```

- If successful, you should see:
  ```
  Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
  ```

---

These commands ensure the SSH key is properly configured for GitHub and seamlessly integrated with macOS Keychain.

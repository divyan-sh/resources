Here’s a detailed cheat sheet for NGINX installation, commands, and configurations tailored for **Amazon Linux**, **Amazon Linux 2**, and **Ubuntu**, along with information on file structure differences.

---

## **NGINX Installation Cheat Sheet**

### **Amazon Linux**

1. **Amazon Linux 2023**

   ```bash
   sudo dnf update -y
   sudo dnf install -y nginx
   sudo systemctl start nginx
   sudo systemctl enable nginx
   ```

2. **Amazon Linux 2**
   ```bash
   sudo yum update -y
   sudo amazon-linux-extras enable nginx1
   sudo yum install -y nginx
   sudo systemctl start nginx
   sudo systemctl enable nginx
   ```

---

### **Ubuntu**

1. **Update and Install NGINX**

   ```bash
   sudo apt update
   sudo apt install -y nginx
   sudo systemctl start nginx
   sudo systemctl enable nginx
   ```

2. **Verify Installation**
   ```bash
   nginx -v
   ```

---

## **Basic NGINX Commands**

| Command                        | Description                                |
| ------------------------------ | ------------------------------------------ |
| `sudo systemctl start nginx`   | Start the NGINX service.                   |
| `sudo systemctl stop nginx`    | Stop the NGINX service.                    |
| `sudo systemctl restart nginx` | Restart the NGINX service.                 |
| `sudo systemctl reload nginx`  | Reload configuration without restarting.   |
| `sudo systemctl enable nginx`  | Enable NGINX to start on boot.             |
| `sudo systemctl disable nginx` | Disable NGINX from starting on boot.       |
| `sudo nginx -t`                | Test the NGINX configuration for errors.   |
| `sudo nginx -s reload`         | Reload NGINX (alternative to `systemctl`). |

---

## **NGINX File Structure and Configuration**

### **Amazon Linux & Amazon Linux 2**

1. **Main Configuration File**:

   - Located at: `/etc/nginx/nginx.conf`

2. **Default Site Config**:

   - Located at: `/etc/nginx/conf.d/default.conf`

3. **Log Files**:

   - Access Logs: `/var/log/nginx/access.log`
   - Error Logs: `/var/log/nginx/error.log`

4. **Web Root Directory**:

   - Default web directory: `/usr/share/nginx/html`

5. **Custom Site Configs**:
   - Create custom site configurations in `/etc/nginx/conf.d/`.

---

### **Ubuntu**

1. **Main Configuration File**:

   - Located at: `/etc/nginx/nginx.conf`

2. **Site Configuration Files**:

   - Located in `/etc/nginx/sites-available/` and linked to `/etc/nginx/sites-enabled/`.
   - Use `ln -s` to enable site configurations:
     ```bash
     sudo ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
     ```

3. **Log Files**:

   - Access Logs: `/var/log/nginx/access.log`
   - Error Logs: `/var/log/nginx/error.log`

4. **Web Root Directory**:

   - Default web directory: `/var/www/html`

5. **Custom Site Configs**:
   - Create new configuration files in `/etc/nginx/sites-available/`.

---

## **Common NGINX Configurations**

1. **Reverse Proxy**:
   Example configuration for forwarding `/api` requests to a Node.js backend running on port `3000`:

   ```nginx
   server {
       listen 80;
       server_name example.com;

       location /api/ {
           proxy_pass http://localhost:3000;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }

       location / {
           root /usr/share/nginx/html;
           index index.html;
           try_files $uri /index.html;
       }
   }
   ```

2. **Serving a Static Website**:

   ```nginx
   server {
       listen 80;
       server_name example.com;

       root /var/www/example.com;
       index index.html;

       location / {
           try_files $uri /index.html;
       }
   }
   ```

3. **Basic SSL Setup**:
   Use a free SSL certificate from Let's Encrypt with Certbot:

   ```bash
   sudo apt install -y certbot python3-certbot-nginx
   sudo certbot --nginx -d example.com -d www.example.com
   ```

4. **Load Balancing**:
   Example for round-robin load balancing:

   ```nginx
   upstream backend {
       server backend1.example.com;
       server backend2.example.com;
   }

   server {
       listen 80;
       server_name example.com;

       location / {
           proxy_pass http://backend;
       }
   }
   ```

---

## **Differences in Folder Structure**

| Component               | Amazon Linux / Amazon Linux 2    | Ubuntu                               |
| ----------------------- | -------------------------------- | ------------------------------------ |
| **Main Config File**    | `/etc/nginx/nginx.conf`          | `/etc/nginx/nginx.conf`              |
| **Site Configs**        | `/etc/nginx/conf.d/`             | `/etc/nginx/sites-available/`        |
| **Default Config File** | `/etc/nginx/conf.d/default.conf` | `/etc/nginx/sites-available/default` |
| **Logs**                | `/var/log/nginx/`                | `/var/log/nginx/`                    |
| **Web Root**            | `/usr/share/nginx/html`          | `/var/www/html`                      |

---

This cheat sheet provides everything you need for installing and managing NGINX across different environments, including configuration examples for common use cases.

---

To rewrite routes in NGINX by adding a prefix (e.g., `/api`) to requests but removing it when passing the request to the backend, you can use the `rewrite` directive or `proxy_pass` with the appropriate handling. Here's an example configuration:

---

### **NGINX Configuration File with Route Rewrite**

```nginx
server {
    listen 80;
    server_name example.com;

    # Rewrite /api to the backend without the /api prefix
    location /api/ {
        rewrite ^/api/(.*)$ /$1 break;
        proxy_pass http://localhost:3000/;  # Backend server
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # Serve static files for the frontend
    location / {
        root /usr/share/nginx/html;  # Adjust to your web root
        index index.html;
        try_files $uri /index.html;
    }
}
```

---

### **Explanation of Key Directives**

1. **`rewrite ^/api/(.*)$ /$1 break;`**:

   - This removes the `/api` prefix from the incoming request.
   - For example, `/api/users` becomes `/users` before being passed to the backend.

2. **`proxy_pass http://localhost:3000/;`**:

   - Forwards the rewritten request to the backend server running on port 3000.

3. **`proxy_set_header`**:

   - Ensures headers like `Host` and `Connection` are properly set for the backend.

4. **`try_files $uri /index.html;`**:
   - For frontend single-page applications, this serves `index.html` when the requested file doesn’t exist.

---

### **When to Use This**

- If your backend application does not natively expect the `/api` prefix but your frontend or API gateway uses it.
- Useful for seamless integration without needing code changes in the backend.

---

### **Testing the Rewrite**

1. Save the configuration file (e.g., `/etc/nginx/conf.d/your-site.conf` or `/etc/nginx/sites-available/your-site`).
2. Test the configuration:
   ```bash
   sudo nginx -t
   ```
3. Reload NGINX:
   ```bash
   sudo systemctl reload nginx
   ```
4. Access your endpoint:
   - Request: `http://example.com/api/users`
   - Backend receives: `/users`

This configuration ensures a clean and functional rewrite for your routes!

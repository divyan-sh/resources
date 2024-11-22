Here's a step-by-step guide to deploy your MERN stack application on Amazon Linux 2, excluding MongoDB setup (since you’re using MongoDB Atlas) and including all NGINX commands:

---

### **1. Launch EC2 Instance and Connect**

1. Launch an **Amazon Linux 2** instance.
2. Open necessary ports in the security group:
   - HTTP (80)
   - HTTPS (443)
   - Custom TCP (if required for your application).
3. Connect to your EC2 instance using SSH:
   ```bash
   ssh -i "your-key.pem" ec2-user@your-ec2-public-ip
   ```

---

### **2. Update System and Install Required Tools**

Update the system and install essential tools:

```bash
sudo yum update -y
sudo yum install -y git curl wget nginx
```

---

### **3. Install Node.js Using nvm**

1. Install **nvm**:
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
   source ~/.bashrc
   ```
2. Install Node.js:
   ```bash
   nvm install 16
   nvm alias default 16
   ```
3. Verify installation:
   ```bash
   node -v
   npm -v
   ```

---

### **4. Clone Your Repository**

Clone your MERN stack application's repository:

```bash
git clone https://github.com/your-repo/your-monorepo.git
cd your-monorepo
```

---

### **5. Install Dependencies**

Install backend and frontend dependencies:

- **Backend**:
  ```bash
  cd backend
  npm install
  ```
- **Frontend**:
  ```bash
  cd ../frontend
  npm install
  npm run build
  ```

---

### **6. Configure Environment Variables**

1. **Backend**:
   Create a `.env` file in the `backend` directory:

   ```bash
   cd ../backend
   nano .env
   ```

   Example `.env`:

   ```env
   PORT=5000
   MONGO_URI=mongodb+srv://username:password@cluster.mongodb.net/dbname
   JWT_SECRET=your_jwt_secret
   ```

2. Save and exit (`Ctrl + O`, `Enter`, `Ctrl + X`).

---

### **7. Install and Configure PM2**

1. Install PM2 globally:
   ```bash
   sudo npm install -g pm2
   ```
2. Start the backend server with PM2:
   ```bash
   cd backend
   pm2 start server.js --name "mern-backend"
   ```
3. Save PM2 processes:
   ```bash
   pm2 save
   pm2 startup
   ```
4. Follow the output instructions to enable PM2 on boot.

---

### **8. Configure NGINX**

1. Edit the NGINX configuration file:
   ```bash
   sudo nano /etc/nginx/nginx.conf
   ```
2. Replace the default server block with the following:

   ```nginx
   server {
       listen 80;

       server_name your-domain.com;

       # Frontend
       location / {
           root /path-to-your-monorepo/frontend/build;
           index index.html;
           try_files $uri /index.html;
       }

       # Backend
       location /api/ {
           proxy_pass http://localhost:5000/;
           proxy_http_version 1.1;
           proxy_set_header Upgrade $http_upgrade;
           proxy_set_header Connection 'upgrade';
           proxy_set_header Host $host;
           proxy_cache_bypass $http_upgrade;
       }
   }
   ```

   Replace `/path-to-your-monorepo/frontend/build` with the actual path to your frontend build directory.

3. Test NGINX configuration:
   ```bash
   sudo nginx -t
   ```
4. Restart NGINX:
   ```bash
   sudo systemctl restart nginx
   sudo systemctl enable nginx
   ```

---

### **9. Set Up Domain and SSL (Optional)**

1. Update your domain DNS to point to the EC2 instance's public IP.
2. Install Certbot for SSL:
   ```bash
   sudo yum install certbot python3-certbot-nginx -y
   sudo certbot --nginx
   ```
3. Follow the Certbot prompts to configure SSL for your domain.
4. Enable auto-renewal:
   ```bash
   echo "0 0 * * * root certbot renew --quiet" | sudo tee -a /etc/crontab > /dev/null
   ```

---

### **10. Verify Deployment**

- Access your application via your domain or EC2 public IP:
  - Frontend: `http://your-domain.com`
  - Backend API: `http://your-domain.com/api`

This setup ensures that your MERN stack application is deployed using **MongoDB Atlas** and served via **NGINX** with reverse proxy for the backend and static file serving for the frontend.

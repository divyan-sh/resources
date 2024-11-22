### **PM2 Cheatsheet**

PM2 is a powerful process manager for Node.js applications that can be used to manage, monitor, and deploy applications.

---

### **PM2 Installation**

```bash
npm install -g pm2
```

---

### **Basic PM2 Commands**

| Command              | Description                                                    |
| -------------------- | -------------------------------------------------------------- | --------------------------------------------------- |
| `pm2 start <app.js>` | Start a Node.js application.                                   |
| `pm2 list`           | List all running processes.                                    |
| `pm2 stop <id        | name>`                                                         | Stop a specific process.                            |
| `pm2 restart <id     | name>`                                                         | Restart a specific process.                         |
| `pm2 delete <id      | name>`                                                         | Delete a process from PM2.                          |
| `pm2 logs <id        | name>`                                                         | View logs for a specific process.                   |
| `pm2 monit`          | Monitor live metrics for all processes.                        |
| `pm2 save`           | Save the current process list for auto-restart on system boot. |
| `pm2 startup`        | Generate and configure the startup script for PM2.             |
| `pm2 reload <id      | name>`                                                         | Reload an app (zero downtime for cluster mode).     |
| `pm2 show <id        | name>`                                                         | Show detailed information about a specific process. |
| `pm2 kill`           | Stop all processes and the PM2 daemon.                         |

---

### **Starting Different Projects with PM2**

#### **1. Starting a Frontend React/Next.js Project**

- For a **React project** (after building it):

  ```bash
  pm2 serve build 3000 --name "frontend-react"
  ```

  - `serve`: Serves a static folder.
  - `build`: Folder containing the React build files.
  - `3000`: Port on which the app will run.

- For a **Next.js project**:
  ```bash
  pm2 start npm --name "frontend-nextjs" -- start
  ```
  - Starts the Next.js project in production mode (`npm start`).

---

#### **2. Starting an Express.js Server**

```bash
pm2 start app.js --name "backend-express"
```

- Replace `app.js` with the entry point of your Express application.
- Use the `--watch` flag to auto-restart on file changes during development:
  ```bash
  pm2 start app.js --name "backend-express" --watch
  ```

---

#### **3. Starting Multiple Projects with an Ecosystem File**

Create a file named `ecosystem.config.js`:

```javascript
module.exports = {
  apps: [
    {
      name: "frontend-nextjs",
      script: "npm",
      args: "start",
      cwd: "/path/to/nextjs/project", // Project directory
      env: {
        NODE_ENV: "production",
      },
    },
    {
      name: "backend-express",
      script: "app.js",
      cwd: "/path/to/express/project",
      env: {
        NODE_ENV: "production",
        PORT: 5000,
      },
    },
  ],
};
```

Start all applications defined in the ecosystem file:

```bash
pm2 start ecosystem.config.js
```

---

#### **4. Starting a Cluster Mode Application**

To utilize all available CPU cores (useful for high-performance backend apps):

```bash
pm2 start app.js -i max --name "backend-cluster"
```

- `-i max`: Runs the app in cluster mode with the maximum number of instances.

---

### **Advanced Commands**

| Command                     | Description                                        |
| --------------------------- | -------------------------------------------------- |
| `pm2 restart all`           | Restart all running processes.                     |
| `pm2 reload all`            | Reload all apps with zero downtime (if supported). |
| `pm2 delete all`            | Delete all processes from PM2.                     |
| `pm2 logrotate`             | Enable log rotation for PM2-managed applications.  |
| `pm2 flush`                 | Clear all logs.                                    |
| `pm2 install pm2-logrotate` | Install log rotation module.                       |
| `pm2 update`                | Update PM2 to the latest version.                  |

---

### **Setting PM2 to Auto-Start on Reboot**

```bash
pm2 startup
pm2 save
```

---

### **Viewing Logs**

- View logs for a specific application:
  ```bash
  pm2 logs <app-name>
  ```
- View all logs:
  ```bash
  pm2 logs
  ```

---

### **Restarting Applications**

- Restart a single application:
  ```bash
  pm2 restart <app-name>
  ```
- Restart all applications:
  ```bash
  pm2 restart all
  ```

---

### **Monitoring Applications**

```bash
pm2 monit
```

- Displays a live dashboard with CPU, memory, and other metrics for all running processes.

---

This PM2 cheatsheet should cover most of your needs for managing your Node.js applications, whether frontend or backend!

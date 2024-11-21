## Node.js Challanges/Task::

### 1. **File System Module Challenge**

**Description**:  
Create a Node.js script that takes a folder path as an input and lists all the files and directories in that folder. Additionally, provide options to create, delete, and rename files or directories using the built-in `fs` module.

**Key Skills**:

- File operations (`fs` module)
- Handling command-line arguments (`process.argv`)

---

### 2. **Basic HTTP Server**

**Description**:  
Build a basic HTTP server that serves static HTML pages. Create different routes like `/`, `/about`, and `/contact` that serve different HTML files. Use `fs` to read and serve the HTML files.

**Key Skills**:

- `http` module for creating a server
- File reading with `fs`

---

### 3. **Custom Event Emitter**

**Description**:  
Create a custom event emitter using Node.js's built-in `events` module. For example, create an emitter that emits events like `data-received`, `error`, or `finished` and handle them with listeners.

**Key Skills**:

- Understanding and using the `events` module
- Asynchronous programming concepts

---

### 4. **Command-Line Calculator**

**Description**:  
Build a simple calculator application that takes mathematical expressions as command-line arguments (e.g., `node calculator.js 5 + 3`). Parse the arguments and perform the calculation.

**Key Skills**:

- Parsing `process.argv`
- Basic arithmetic operations

---

### 5. **JSON File Reader and Writer**

**Description**:  
Write a script that reads a JSON file, modifies its content (e.g., adds or updates a key-value pair), and then writes it back to the file.

**Key Skills**:

- File operations (`fs` module)
- Working with JSON data

---

### 6. **Simple Logging System**

**Description**:  
Create a logging system that writes log messages to a file. Each log entry should include a timestamp and the log level (e.g., `INFO`, `WARN`, `ERROR`). Allow users to specify the log level through a command-line argument.

**Key Skills**:

- File writing with `fs`
- Date and time handling

---

### 7. **Basic Template Engine**

**Description**:  
Build a simple template engine that replaces placeholders in a string or file with actual values. For example, `Hello, {{name}}!` should be transformed into `Hello, John!` if the name is provided.

**Key Skills**:

- String manipulation
- File reading and writing

---

### 8. **Static File Server**

**Description**:  
Create a basic HTTP server that serves static files (e.g., `.html`, `.css`, `.js`) from a specific directory. If the requested file does not exist, return a 404 page.

**Key Skills**:

- `http` module for server
- Reading file paths dynamically
- MIME type handling

---

### 9. **Node.js Timer Application**

**Description**:  
Write a script that takes a number as input and prints a countdown timer in the console. For example, `node timer.js 10` should count down from 10 to 0 and display "Time's up!" when the countdown ends.

**Key Skills**:

- Timers (`setInterval`, `setTimeout`)
- Handling command-line input

---

### 10. **Environment Variables Reader**

**Description**:  
Create a script that reads environment variables and prints them to the console. Allow users to pass a variable name to retrieve its value (e.g., `node env-reader.js PATH`).

**Key Skills**:

- Accessing environment variables (`process.env`)
- Command-line input handling

---

### 11. **Stream-Based File Copier**

**Description**:  
Write a program that copies a large file from one location to another using streams to handle large files efficiently.

**Key Skills**:

- Understanding streams (`fs.createReadStream` and `fs.createWriteStream`)
- File handling

---

### 12. **Simple Chat Server (Terminal-Based)**

**Description**:  
Build a simple chat server that allows multiple clients to connect and exchange messages using TCP sockets.

**Key Skills**:

- `net` module for TCP socket programming
- Handling multiple connections

---

### 13. **Recursive Directory Tree Viewer**

**Description**:  
Write a script that prints the directory structure of a given path in a tree-like format. For example:

```
- folder
  - file1.txt
  - subfolder
    - file2.txt
```

**Key Skills**:

- Recursive file system traversal (`fs` and `path` modules)
- Console formatting

---

### 14. **Basic CLI Quiz Application**

**Description**:  
Create a command-line quiz application that asks users multiple-choice questions, collects answers, and calculates their score.

**Key Skills**:

- Reading input from the terminal (`readline` module)
- Managing state in Node.js

---

### 15. **Simple Zip File Generator**

**Description**:  
Write a script that compresses a given file or folder into a `.zip` file.

**Key Skills**:

- Working with Node.js `zlib` module
- File system handling

---

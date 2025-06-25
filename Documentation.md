# Simple Webserver Documentation

As per the requirement for Techinical Test, created a code base for AWS resources and This document describes how to set up a simple webserver using **Node.js** as the backend and **Nginx** as a Web Front end reverse proxy.

## Prerequisites

> Node server [Node.js](https://nodejs.org/) installed for bjavascript runtime as a backend using package management and npm as package manager 
> Nginx web server [Nginx](https://nginx.org/) installed using the apt-get

## Project Structure

```
hex-webserver/
├── server.js
├── nginx/
│   └── default
└── webserver.md
```

## 1. Node.js Server

Create a simple HTTP server in `server.js`:

```js
const http = require('http');

const PORT = 8080;

const server = http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Hello from Node.js server!\n');
});

server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
```

Start the server:

```sh
node server.js
```

## 2. Nginx Reverse Proxy Configuration

Edit your Nginx configuration (e.g., `/etc/nginx/sites-available/default`):

```nginx
server {
        listen 80;
        server_name your_domain_or_ip;

        location / {
                proxy_pass http://localhost:8080;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
        }
}
```

How to Reload Nginx to apply changes:

```sh
sudo nginx -s reload # restart
```

## 3. Accessing the Webserver

Visit `http://AWSVMdomain_or_ip/` in your browser. You should see:

```
ok
```

## 4. Notes

- Ensure the Node.js server is running before accessing via Nginx.
- Update `server_name` in the Nginx config to match your domain or IP. This line is necessary for Nginx to know which requests to handle, especially if you are hosting multiple sites or using a domain name. If you are only using an IP address or for local testing, you can set it to your server's IP or use `_` as a wildcard.

## References

- [Nginx Reverse Proxy Guide](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
- [Node.js HTTP Module](https://nodejs.org/api/http.html)

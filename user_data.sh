#!/bin/bash
# Package management pdate and install Node.js and NGINX
apt-get update -y
apt-get install -y nodejs npm nginx

# Create Node.js App
cat <<EOF > /home/ubuntu/server.js
const { createServer } = require('http');
const port = 8080;
createServer(function (req, res) {
  if (req.url === '/hello' && req.method === 'GET') {
    res.writeHead(200);
    res.end('OK');
  } else {
    res.writeHead(404);
    res.end();
  }
}).listen(port);
console.log("Node server running on port 8080");
EOF

# Start Node.js App
nohup node /home/ubuntu/server.js > /home/ubuntu/server.log 2>&1 &

# Frontend - Configure NGINX Reverse Proxy
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    location /hello {
        proxy_pass http://localhost:8080;
    }
}
EOF

# Restart NGINX to apply config
systemctl restart nginx

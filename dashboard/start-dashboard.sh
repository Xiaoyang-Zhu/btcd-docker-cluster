#!/bin/bash
if which node 2>/dev/null; then
  node server.js
else
  apt-get install npm -y
  npm install
  npm run build
  node server.js
fi

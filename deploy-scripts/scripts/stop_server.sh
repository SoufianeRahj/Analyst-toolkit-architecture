#!/bin/bash
. ~/.nvm/nvm.sh

cd /var/www/analyst-toolkit  
if pm2 info server.js >/dev/null 2>&1; then
    pm2 stop server.js
fi

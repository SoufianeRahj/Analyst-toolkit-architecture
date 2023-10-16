#!/bin/bash
cd /var/www/analyst-toolkit/
. ~/.nvm/nvm.sh
pm2 start server.js

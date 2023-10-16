#!/bin/bash
cd /var/www/analyst-toolkit/
sudo chown -R ssm-user:ssm-user /var/www/analyst-toolkit/
. ~/.nvm/nvm.sh
npm i

#!/bin/bash

# Check if nvm is installed, if not install it
if [ ! -d "~/.nvm" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    nvm install 18
fi
. ~/.nvm/nvm.sh

# Check if pm2 is installed, if not install it
if ! command -v pm2 &> /dev/null; then
    npm install -g pm2
fi

# Retrieve secrets from SSM Parameter Store
apiKeyPath="/path/api-key"
orgPath="/path/org"
apiKey=$(aws ssm get-parameter --name "$apiKeyPath" --with-decryption --query "Parameter.Value" --output text)
org=$(aws ssm get-parameter --name "$orgPath" --with-decryption --query "Parameter.Value" --output text)
export ORG="$org"
export OPENAI_API_KEY="$apiKey"

# Ensure directory structure
sudo mkdir -p /var/www/analyst-toolkit
sudo chown -R $(whoami):$(whoami) /var/www/analyst-toolkit
sudo rm -rf /var/www/analyst-toolkit/*


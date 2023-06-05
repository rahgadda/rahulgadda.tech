#!/bin/bash

# -- Install depencies
sudo su
yum install nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install v16.17.1
node --version

# -- Creating node project
cd /home/opc/setup/helloworld/
npm init -y
npm install express dotenv --save
npm start

# -- Publishing Docker Image
docker build --no-cache --tag rahgadda/helloworld .
sudo docker push rahgadda/helloworld
docker run rahgadda/helloworld
docker rmi --force rahgadda/helloworld
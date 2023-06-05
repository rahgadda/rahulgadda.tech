FROM node:alpine
WORKDIR /usr/app
RUN apk update && apk add libstdc++ && apk add build-base && apk add python3 && apk add bash && apk add curl
COPY . .
RUN rm -rf install.sh
RUN rm -rf testing.rest
RUN rm -rf hello-world.yaml
CMD ["npm", "run", "start"]
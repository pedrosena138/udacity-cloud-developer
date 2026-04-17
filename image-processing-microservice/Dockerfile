FROM node:24-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package.json ./
COPY pnpm-lock.yaml ./

RUN npm install


COPY . .
EXPOSE 8080
CMD [ "node", "src/server.js" ]
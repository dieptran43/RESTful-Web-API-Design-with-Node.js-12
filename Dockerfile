# retrieve base image for Node 12 (use LTS alpines in prod)
FROM node:lts-alpine

# set app directory insode container
WORKDIR /server

# copy manifest files (be sure to include package-lock.json)
COPY ./package*.json ./
# dependency installation for CI environments
RUN npm ci --production

# install PM2 production process manager (multi-threading)
RUN npm install pm2 -g

# copy the project folder inside container
COPY ./ ./

# Run the image as a non-root user
# RUN adduser -D myuser
# USER myuser

# set primary command for server startup when container starts
CMD npm start --port $PORT

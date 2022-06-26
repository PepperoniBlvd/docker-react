# FROM node:alpine as builder

# USER node

# RUN mkdir -p /home/node/app
# WORKDIR  /home/node/app

# COPY --chown=node:node ./package.json ./
# RUN npm install
# COPY --chown=node:node ./ ./
# RUN npm run build

# FROM nginx
# EXPOSE 80
# COPY --from=builder /home/node/app/build /usr/share/nginx/html
# Build Phase
# loading alpine as base image and tag it with builder
FROM node:alpine as builder  
# setting work directory in the container
WORKDIR '/app'
# copying 
COPY package.json .
# installing dependencies
RUN npm install
# copying rest of the files
COPY . .
# running the default command
RUN npm run build 

# Run phase by loading nginx as production container
FROM nginx
EXPOSE 80
# conpying the builder to production container
COPY --from=builder /app/build /usr/share/nginx/html
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


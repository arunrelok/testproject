# refer https://sysdig.com/blog/dockerfile-best-practices/ for Dockerfile best practices
# Each instruction creates one layer:   
# FROM creates a layer from the ubuntu:18.04 Docker image.
# COPY adds files from your Docker client’s current directory.
# RUN builds your application with make.
# CMD specifies what command to run within the container.

FROM node:lts-alpine3.16 AS build
ENV SSO_URL "http://localhost:4000"
ENV BE_IP_PORT "http://localhost:8000"
WORKDIR /app
# COPY package.json ./
# COPY package-lock.json ./
COPY ./ ./
RUN npm install
RUN npm run build

# FOR MAC/LINUX
#FROM nginxinc/nginx-unprivileged:latest

# FOR WINDOWS 
FROM nginx:latest

ENV SSO_URL "http://localhost:4000"
ENV BE_IP_PORT "http://localhost:8000"
#COPY app contents
COPY --from=build --chown=nginx:nginx app/build  /usr/share/nginx/html/realoq-ui

#create a file to be used in http healthcheck probe
# RUN touch /usr/share/nginx/html/realoq-ui/healthcheck

#Copy entrypoint script
COPY --chown=nginx:nginx docker/scripts/docker-entrypoint.sh /docker-entrypoint.d/99-docker-entrypoint.sh

RUN touch /usr/share/nginx/html/realoq-ui/healthcheck                                  \
    && chmod +x /docker-entrypoint.d/99-docker-entrypoint.sh

#workdir
WORKDIR /usr/share/nginx/html/realoq-ui

#ENTRYPOINT and CMD is inherited from the base image

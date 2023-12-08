# Use a multi-stage build for a smaller image
ARG NODE_VERSION=18                     #example 18.16.0 #node 18 highest supported version of code-server

# Stage 1: Build stage
FROM node:${NODE_VERSION}-alpine AS build-stage

# Install Python3 and build-essentials
RUN apk --no-cache add python3 krb5-dev build-base && \
    npm add -g code-server --unsafe-perm --legacy-peer-deps --omit=dev && \
    apk del python3 krb5-dev build-base

# Stage 2: Runtime stage
FROM oven/bun:alpine

# Copy code-server
COPY --from=build-stage /usr/local/lib/node_modules/code-server /usr/local/lib/node_modules/code-server

# Install necessary packages
# python3, build-base and krb5-dev are need for remote code-server to build using npm 
RUN apk --no-cache add doas bash libstdc++ curl grep openssh git nodejs && \
    ln -s /usr/local/lib/node_modules/code-server/out/node/entry.js /usr/local/bin/code-server

# Create a non-root user
ARG USER=coder
RUN printf "\n\n" | adduser -g ${USER} ${USER} -H -s /bin/bash && addgroup ${USER} wheel && \
    echo "permit setenv { PS1=$DOAS_PS1 SSH_AUTH_SOCK } :wheel" > /etc/doas.d/${USER}.conf && \

USER ${USER}
WORKDIR /home/${USER}

## ADD PATH OF BUN BIN

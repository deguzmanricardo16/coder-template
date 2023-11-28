# Use a multi-stage build for a smaller image
ARG NODE_VERSION=18                     #example 18.16.0

FROM node:${NODE_VERSION}-alpine

# Install necessary packages
RUN apk --no-cache add doas bash gcompat libstdc++ curl grep openssh git && \
    npm install -g npm pnpm

# Create a non-root user
ARG USER=coder
RUN printf "\n\n" | adduser -g ${USER} ${USER} -H -s /bin/bash && addgroup ${USER} wheel \
    && echo "permit setenv { PS1=$DOAS_PS1 SSH_AUTH_SOCK } :wheel" > /etc/doas.d/${USER}.conf

USER ${USER}
WORKDIR /home/${USER}

## 
ARG NODE_VERSION=18			#example 18.16.0 / code-server need <= 18.xx.x
FROM node:${NODE_VERSION}-alpine

## Some scripts
#COPY ./scripts/generate-dropbear-key.sh /usr/local/bin/
#COPY ./scripts/setup.sh /usr/local/bin/setup.sh

## Or Just copy the whole script folder
ADD ./scripts ./scripts

ARG USER=coder

# Run the shell script with the specified arguments
RUN ./scripts/setup.sh ${USER}

USER ${USER}
WORKDIR /home/${USER}/www

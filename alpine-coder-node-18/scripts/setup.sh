#!/bin/sh

USER=$1

mv scripts/generate-dropbear-key.sh /usr/local/bin/

# Install necessary packages
apk --no-cache add doas bash gcompat libstdc++ curl grep dropbear-scp dropbear dropbear-ssh git

# Install Node.js and npm packages
npm install -g npm pnpm

## pnpm setup
cat <<EOF >> /etc/profile.d/pnpm.sh
# pnpm start
export PNPM_HOME="/home/${USER}/.local/share/pnpm"
export PATH="\$PNPM_HOME:\$PATH"
# pnpm end
EOF

# Add user and group
printf "\n\n" | adduser -g ${USER} ${USER} -s /bin/bash
addgroup ${USER} wheel

# Configure doas
echo "permit setenv { PS1=$DOAS_PS1 SSH_AUTH_SOCK } :wheel" > /etc/doas.d/${USER}.conf

## Clean files
rm -rf ~/.npm
rm -rf $(pwd)/scripts

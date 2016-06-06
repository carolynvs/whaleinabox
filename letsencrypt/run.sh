#!/bin/sh
set -euo pipefail

# Install the docker client
echo "Checking for the Docker client"
if [ ! -f "/usr/local/bin/docker" ]; then
  echo "Installing Docker $DOCKER_VERSION..."
  curl https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz -o /tmp/docker-$DOCKER_VERSION.tgz
  tar -xzf /tmp/docker-$DOCKER_VERSION.tgz -C /tmp
  cp /tmp/docker/docker /usr/local/bin/docker
fi

# Wait for nginx as our Let's Encrypt challenge is served by it
echo "Waiting for nginx to start..."
until $(curl --output /dev/null --silent --head --fail --insecure https://$DOMAIN); do
    printf '.'
    sleep 5
done
echo ""

# Generate a Let's Encrypt certificate
echo "Checking for a Let's Encrypt certificate"
if [ ! -f "/etc/letsencrypt/live/$DOMAIN/privkey.pem" ]; then
  /generate-certificate.sh
fi

echo "Whale in a Box Initialization Complete!"
echo "Starting the Let's Encrypt cron job"
# Start CRON
exec /usr/sbin/crond -f -d 8

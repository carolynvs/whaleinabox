#!/bin/bash
set -euo pipefail

# Configure nginx
if [ ! -f "/etc/nginx/conf.d/default.conf" ]; then
  mv /etc/nginx/conf.d/template.conf /etc/nginx/conf.d/default.conf
  sed -i "s/DOMAIN/${DOMAIN}/g" /etc/nginx/conf.d/default.conf
fi

# Generate a self-signed certificate
echo "Checking for an existing TLS certificate"
if [ ! -f /etc/certs/jupyterhub.key ]; then
  echo "Generating a self-signed certificate..."
  touch /etc/certs/jupyterhub.key
  openssl req -x509 -newkey rsa:2048 -days 365 -nodes -batch \
    -keyout /etc/certs/jupyterhub.key \
    -out /etc/certs/jupyterhub.crt
fi

# Generate strong Diffie-Hellman parameters
echo "Checking for existing Diffie-Hellman parameters"
if [ ! -f "/etc/certs/dhparams.pem" ]; then
  echo "Generating Diffie-Hellman parameters. This will take a few minutes..."
  openssl dhparam -out /etc/certs/dhparams.pem 2048
fi

echo "Starting nginx"
exec /usr/sbin/nginx -g "daemon off;"

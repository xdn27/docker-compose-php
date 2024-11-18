#!/bin/sh

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
PARENT_DIR=$(dirname "$SCRIPT_PATH")

# echo "Script path: $SCRIPT_PATH"
# echo "Parent directory: $PARENT_DIR"

# Get path of root caddy cert
CADDY_CERT_PATH="$PARENT_DIR/data/caddy/data/caddy/pki/authorities/local"
CADDY_ROOT_CERT="$CADDY_CERT_PATH/root.crt"
CADDY_CERT_PEM="$CADDY_CERT_PATH/root-local.pem"

LOCAL_CERT_PATH="/etc/pki/ca-trust/source/anchors/"

if [ -e "$CADDY_ROOT_CERT" ]; then
    echo "Caddy root cert found"

    # Covert to PEM file
    openssl x509 -in $CADDY_ROOT_CERT -out $CADDY_CERT_PEM -outform PEM

    if [ -e "$CADDY_CERT_PEM" ]; then
        echo "Cert converted to PEM exist, moved to host cert path"
        # Move PEM file to host cert path
        mv $CADDY_CERT_PEM $LOCAL_CERT_PATH

        update-ca-trust
    else
        echo "PEM file not found"
    fi
    
else
    echo "Caddy root cert not found"
fi

echo "Done"
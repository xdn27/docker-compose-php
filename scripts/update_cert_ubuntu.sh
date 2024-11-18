#!/bin/sh

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
PARENT_DIR=$(dirname "$SCRIPT_PATH")

# Get path of root caddy cert
CADDY_CERT_PATH="$PARENT_DIR/data/caddy/data/caddy/pki/authorities/local"
CADDY_ROOT_CERT="$CADDY_CERT_PATH/root.crt"

LOCAL_CERT_PATH="/usr/local/share/ca-certificates/root-local.crt"

if [ -e "$CADDY_ROOT_CERT" ]; then
    echo "Caddy root cert found"

    cp $CADDY_ROOT_CERT $LOCAL_CERT_PATH

    if [ -e "$LOCAL_CERT_PATH" ]; then
        echo "Cert exist, moved to host cert path"

        update-ca-certificates

    else
        echo "Cert file not found"
    fi
    
else
    echo "Caddy root cert not found"
fi

echo "Done"
#!/bin/sh

# Define the directory to scan
# WWW_DIR="/mnt/4440FB6640FB5CDC/Projects/web/app"

SCRIPT_PATH=$(dirname "$(readlink -f "$0")")
PARENT_DIR=$(dirname "$SCRIPT_PATH")

ROOT_DIR=$PARENT_DIR
WWW_DIR="$ROOT_DIR/projects"

# Define the IP address to use for the entries
IP_ADDRESS="127.0.0.1"

DOMAINS=""

# Clear the existing entries (optional)
# This will remove all entries that match the pattern "127.0.0.1 subdir.local"
sed -i '/^127\.0\.0\.1\s.*\.local$/d' /etc/hosts

# Loop through the subdirectories in the www directory
for SUBDIR in $(find "$WWW_DIR" -maxdepth 1 -type d -not -name "projects" -not -name "."); do
    # Extract the subdirectory name
    SUBDIR_NAME=$(basename "$SUBDIR")
    
    # Create the entry in the /etc/hosts file
    echo "$IP_ADDRESS $SUBDIR_NAME.local" | tee -a /etc/hosts
  
    if [ "$SUBDIR_NAME.local" != "pma.local" ] && [ "$SUBDIR_NAME.local" != "pgadmin.local" ] && [ "$SUBDIR_NAME.local" != "adminer.local" ]; then
      if [ -z "$DOMAINS" ]; then
          DOMAINS="$SUBDIR_NAME.local"
      else
          DOMAINS="$DOMAINS, $SUBDIR_NAME.local"
      fi
    fi
    # echo "$IP_ADDRESS $SUBDIR_NAME.local"
done

sed -i '/DOMAIN=/d' "$ROOT_DIR/.env"

echo "Entries added to /etc/hosts."
echo "DOMAIN=$DOMAINS" >> "$ROOT_DIR/.env"

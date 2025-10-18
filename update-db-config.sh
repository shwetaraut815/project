#!/bin/bash

set -e  # exit immediately on error

# Absolute path to WAR file
WAR_FILE="$WORKSPACE/target/LoginWebApp.war"

if [ ! -f "$WAR_FILE" ]; then
    echo "WAR file not found: $WAR_FILE"
    exit 1
fi

# Temporary directory for extraction
TMP_DIR="$WORKSPACE/tmp-war"
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

# Extract WAR
unzip -o "$WAR_FILE" -d "$TMP_DIR"

# Update DB config inside extracted WAR
DB_USER="admin"
DB_PASS="admin1234"
DB_HOST="database-1.cevyoqyq8e62.us-east-1.rds.amazonaws.com"

# Path inside extracted WAR
CONFIG_FILE="$TMP_DIR/userRegistration.jsp"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Config file not found: $CONFIG_FILE"
    exit 1
fi

# Replace values
sed -i "s/\"username\"/\"$DB_USER\"/g" "$CONFIG_FILE"
sed -i "s/\"password\"/\"$DB_PASS\"/g" "$CONFIG_FILE"
sed -i "s/localhost/$DB_HOST/g" "$CONFIG_FILE"

# Repackage WAR
cd "$TMP_DIR"
zip -r "$WAR_FILE" ./*
cd "$WORKSPACE"

# Cleanup
rm -rf "$TMP_DIR"

echo "WAR updated successfully: $WAR_FILE"

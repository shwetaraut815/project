#!/bin/bash
set -e  # Exit immediately if any command fails

# Path to WAR file
WAR="target/LoginWebApp.war"

# Temporary folder for extraction
TMP="tmp-dir"

# Clean and create temp folder
rm -rf $TMP
mkdir $TMP

# Extract WAR
unzip -q "$WAR" -d $TMP

# Update DB config in JSP file
CONFIG="$TMP/LoginWebApp/src/main/webapp/userRegistration.jsp"

sed -i 's/"username"/"admin"/g' "$CONFIG"
sed -i 's/"password"/"admin1234"/g' "$CONFIG"
sed -i 's/localhost/database-1.cevyoqyq8e62.us-east-1.rds.amazonaws.com/g' "$CONFIG"

# Repack WAR
cd $TMP
zip -qr "../LoginWebApp.war" *
cd ..

# Clean up
rm -rf $TMP

echo "WAR updated with DB config!"

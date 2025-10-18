

#!/bin/bash

set -e #immediately exit if any command fails

war_path="target/LoginWebApp.war"

rm -rf tmp-dir
mkdir tmp-dir
cd tmp-dir

unzip -o "$war_path" -d tmp-dir   #extract war 

#update db config 

user=admin
pass=admin1234
localhost=database-1.cevyoqyq8e62.us-east-1.rds.amazonaws.com

config_file=LoginWebApp/src/main/webapp/userRegistration.jsp

sed -i 's/"username"/"admin"/g' $config_file
sed -i 's/"password"/"admin1234"/g' $config_file
sed -i 's/localhost/$localhost/g' $config_file

zip -r "$war_path" *   #updated war

cd ..



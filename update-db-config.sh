

#!/bin/bash

set -e #immediately exit if any command fails

war-path="target/LoginWebApp.war"

rm -rf tmp-dir
mkdir tmp-dir
cd tmp-dir

jar -xvf ../war-path   #extract war 

#update db config 

user=admin
pass=admin1234
localhost=database-1.cevyoqyq8e62.us-east-1.rds.amazonaws.com

config-file=LoginWebApp/src/main/webapp/userRegistration.jsp

sed -i 's/"username"/"admin"/g' $config-file
sed -i 's/"password"/"admin1234"/g' $config-file
sed -i 's/localhost/$localhost/g' $config-file

jar -cvf ../LoginWebApp   #updated war

cd ..



docker_username=""
db_image_name="app"
db_container_name="web"
db_password=""
ENCRYPTOR_PASSWORD=super-secret
port1=8080
port2=8080
#
#echo "## Automation docker-database build and run ##"
#
## remove container
echo "=> Remove previous container..."
docker rm -f ${db_container_name}
#
## remove image
echo "=> Remove previous image..."
docker rmi -f ${db_image_name}

#
## new-build/re-build docker image
echo "=> Build new image..."
docker build --tag ${db_image_name} -f Dockerfile .

# Run container
echo "=> Run container..."
docker run -d -e ENCRYPTOR_PASSWORD=${ENCRYPTOR_PASSWORD} -p ${port1}:${port2}  --name ${db_container_name} ${db_image_name}
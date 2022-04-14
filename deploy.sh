#!/bin/sh
echo "Move stuff around"
sudo chown -R ubuntu:ubuntu /home/ubuntu/webapps/WebGoat.net
sudo rm -rf /home/ubuntu/WebGoat.net.tar.gz
echo "Start containers"
cd /home/ubuntu/webapps/WebGoat.net/
sudo docker-compose up -d
sleep 25
echo "Curl URLS"
sudo curl --silent --output /dev/null -X GET "http://webgoatnet.qa.contrast.pw/"
sudo curl --silent --output /dev/null -X GET "http://webgoatnet.qa.contrast.pw/#/basket"
sudo curl --silent --output /dev/null -X GET "http://webgoatnet.qa.contrast.pw/#/search"
sleep 10

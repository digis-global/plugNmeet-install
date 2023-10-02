#!/bin/bash -e

if [ $EUID != 0 ]; then echo "You must run this script as root."; fi

WORK_DIR=/opt/plugNmeet

## https://github.com/mynaparrot/plugNmeet-client/releases/latest/download/client.zip
CLIENT_DOWNLOAD_URL="https://github.com/mynaparrot/plugNmeet-client/releases/latest/download/client.zip"
RECORDER_DOWNLOAD_URL="https://github.com/mynaparrot/plugNmeet-recorder/releases/latest/download/recorder.zip"
UPDATED_CONFIG_FILE="https://raw.githubusercontent.com/inme-digital-services/plugNmeet-install/main/updated.config.js"
UPDATED_INDEX_FILE="https://raw.githubusercontent.com/inme-digital-services/plugNmeet-install/main/updated.index.html"

if [ ! -d "$WORK_DIR" ]; then
  echo "Didn't find working directory. exiting.."
  exit 1
fi

cd $WORK_DIR
apt update && apt upgrade -y && apt dist-upgrade -y
service plugnmeet stop

## update containers
## https://stackoverflow.com/a/61362893/1281864
printf "\nupdating docker images\n"
sleep 1
docker compose pull
docker compose up -d --remove-orphans
docker system prune -f -a --volumes

## client update
# let's take backup first
printf "\nupdating client\n"
sleep 1
# remove previous backup
if [ -d "client_bk" ]; then
  rm -rf client_bk
fi

# take backup
mv -f client client_bk
wget $CLIENT_DOWNLOAD_URL -O client.zip
unzip -o client.zip

cp -f client_bk/dist/assets/config.js client/dist/assets/config.js
rm -rf client.zip
config_file="updated.config.js"
if [ -f $config_file ]; then
  sudo rm -rf $config_file
fi
wget $UPDATED_CONFIG_FILE
cp $config_file client/dist/assets/config.js

index_file="updated.index.html"
if [ -f $index_file ]; then
  sudo rm -rf $index_file
fi
wget $UPDATED_INDEX_FILE
cp $index_file client/dist/index.html


# wait until plugNmeet api ready
while ! nc -z localhost 8080; do
  docker compose logs --tail=1
  sleep 3 # wait before check again
done

## now restart service
service plugnmeet restart

## recorder update
if [ -d "recorder" ]; then
  printf "\nupdating recorder\n"
  sleep 1
  service plugnmeet-recorder stop

  # remove previous backup
  if [ -d "recorder_bk" ]; then
    rm -rf recorder_bk
  fi

  # take backup
  mv -f recorder recorder_bk
  wget $RECORDER_DOWNLOAD_URL -O recorder.zip
  unzip -o recorder.zip

  cp -f recorder_bk/config.yaml recorder/config.yaml
  npm install --ignore-scripts --omit=dev -C recorder
  rm -rf recorder.zip

  # make sure redis is up
  while ! nc -z localhost 6379; do
    docker compose logs --tail=1
    sleep 1 # wait before check again
  done

  service plugnmeet-recorder start
fi

printf "\n\nupdate completed!\n"

#!/bin/bash

SERVER=$1

if [ -z $SERVER ]; then
  echo Please supply the server IP to connect to.
  exit 1
fi

rpcbind

mkdir $VOLUME_MOUNT_PATH
mount -t nfs $SERVER:$SERVER_VOLUME_PATH $VOLUME_MOUNT_PATH
mkdir -p $VOLUME_MOUNT_PATH/smf

echo  Possible operations for SMF:
echo \$SMF --operation create
echo \$SMF --operation read
echo \$SMF --operation append
echo \$SMF --operation rename
echo \$SMF --operation delete

bash

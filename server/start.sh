#!/bin/bash
set -e

rpcbind
glusterd

head -n1 /etc/hosts

case $1 in
create)
  if [ $GLUSTER_PEER ]; then
    MY_IP=$(head -n1 /etc/hosts | awk '{print $1}')
    PEER_IP=$GLUSTER_PEER

    echo "Probing peer $GLUSTER_PEER ($PEER_IP)"
    gluster peer probe $PEER_IP

    echo "Waiting for peer to join cluster"
    while [[ -z $(gluster peer status | grep "Peer in Cluster") ]]; do sleep 1; done

    #echo "Syncing volumes with $GLUSTER_PEER"
    #gluster volume sync $PEER_IP
  fi

  if [[ -z $(gluster volume status $VOLUME_NAME) ]]; then
    echo Creating volume
    gluster volume create $VOLUME_NAME replica 2 $MY_IP:$VOLUME_PATH $PEER_IP:$VOLUME_PATH force

    echo Starting volume
    gluster volume start $VOLUME_NAME
    gluster volume set $VOLUME_NAME nfs.disable off

    echo Volume status:
    gluster volume status
  else
    echo "Volume already exists"
  fi
  ;;
esac

exec bash

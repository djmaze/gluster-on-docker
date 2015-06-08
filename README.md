# Docker image for testing a Gluster setup

## Usage

Run a new server:

    docker-compose run server bash

In a new terminal, run a second server, connecting to the first one:

    docker-compose run -e GLUSTER_PEER=$IP_OF_FIRST_SERVER server create

In a new terminal, start a third node:

    docker-compose run server bash

From the first or second node's terminal, add the third node:

    gluster peer probe $IP_OF_THIRD_NODE
    gluster volume add-brick $VOLUME_NAME $IP_OF_THIRD_NODE:$VOLUME_PATH

## Connect a client

Run a client, giving the IP of any gluster server:

    docker-compose run client $IP_OF_ANY_SERVER

The volume is now mounted at `/mnt/gluster-volume`.

## Replace a server

To replace `$OLD_HOST` in a volume with `$NEW_HOST`, run (on one of the servers):

    OLD_HOST=172.17.0.12
    NEW_HOST=172.17.0.13

    gluster peer probe $NEW_HOST
    gluster volume replace-brick $VOLUME_NAME $OLD_HOST:$VOLUME_PATH $NEW_HOST:$VOLUME_PATH commit force
    gluster peer detach $OLD_HOST
    gluster volume rebalance $VOLUME_NAME start

## References

See [this post](https://www.gluster.org/pipermail/gluster-users/2012-October/011502.html) for how to replace bricks in volumes.

FROM ubuntu:trusty

RUN apt-get update
RUN apt-get -y install nfs-common wget

RUN cd /usr/local \
 && wget https://forge.gluster.org/smallfile-performance-testing/smallfile-performance-testing/archive-tarball/master \
 && tar xzf master \
 && rm master

ENV SERVER_VOLUME_PATH /gluster-volume
ENV VOLUME_MOUNT_PATH /mnt/gluster-volume

WORKDIR /usr/local/smallfile-performance-testing-smallfile-performance-testing
ENV SMF "./smallfile_cli.py --top $VOLUME_MOUNT_PATH/smf --threads 8 --file-size 4 --files 1000 --response-times Y "

ADD start.sh /
ENTRYPOINT ["/start.sh"]

FROM ubuntu:trusty

RUN apt-get update
RUN apt-get install -y python-software-properties software-properties-common
RUN add-apt-repository -y ppa:gluster/glusterfs-3.5 \
 && apt-get update \
 && apt-get install -y glusterfs-server

ADD /start.sh /
ENTRYPOINT ["/start.sh"]

ENV VOLUME_NAME gluster-volume
ENV VOLUME_PATH /home/gluster-volume
#VOLUME $VOLUME_PATH

EXPOSE 2049


#!/bin/bash
#demarrer le server nfs du raspberry pi

sudo /etc/init.d/nfs-kernel-server start && \
sudo /etc/init.d/nfs-kernel-server reload && \
sudo exportfs -ra && \

sleep 5

done

#fin du script

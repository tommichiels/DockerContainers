#!/bin/bash

if [ -z ${NAMENODE+x} ]; then
    NAMENODE=master
fi

sed s/HOSTNAME/$NAMENODE/ /root/hue/desktop/conf/pseudo-distributed.ini.template > /root/hue/desktop/conf/pseudo-distributed.ini;

/root/hue/build/env/bin/hue runserver 0.0.0.0:8000


sleep 1

# tail log directory
tail -n 1000 -f /root/hue/logs/*.log

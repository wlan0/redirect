#!/bin/bash

if [ ! -d /host/proc ]; then
    echo "Exiting. Please mount host proc fs to /host/proc. i.e. add -v /proc:/host/proc to docker run"
    exit 1
fi

if [ -z ${HOST_PORT} ]; then 
    echo "Exiting. HOST_PORT environment var is not set"
    exit 1
fi

if [ -z ${DEST_IP} ]; then 
    echo "Exiting. DEST_IP environment var is not set"
    exit 1
fi

if [ -z ${DEST_PORT} ]; then 
    echo "Exiting. DEST_PORT environment var is not set"
    exit 1
fi

OP=${OPERATION:-A}
# DEST_IP=${ping -c 1 ${DEST_IP} 2>&1 | grep 'from ' | cut -d: -f1 | awk '{print $4}'}

echo "Adding redirect from ${HOST_PORT} -> ${DEST_IP}:${DEST_PORT}"
echo "iptables -t nat -${OP} DOCKER ! -i docker0 -p tcp --dport ${HOST_PORT} -j DNAT --to-destination ${DEST_IP}:${DEST_PORT}"
./nsenter --net=/host/proc/1/ns/net -- iptables -t nat -${OP} DOCKER ! -i docker0 -p tcp --dport ${HOST_PORT} -j DNAT --to-destination ${DEST_IP}:${DEST_PORT}

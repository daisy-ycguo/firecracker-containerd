#!/bin/bash

set -ex

IMAGE=$1
NAME=template$(date +%s)
THINPOOL_NAME=784
THINPOOL_NUM=849

# Clean environment
kill -9 $(ps -aux | grep api-sock | grep firecracker | awk '{print $2}') || true
firecracker-ctr --address /run/firecracker-containerd/containerd.sock containers rm $(sudo firecracker-ctr --address /run/firecracker-containerd/containerd.sock containers ls | awk '{print $1}') || true
rm -rf /var/lib/firecracker-containerd/shim-base/default*

dmsetup remove fc-dev-thinpool-snap-$THINPOOL_NAME || true
dmsetup message /dev/mapper/fc-dev-thinpool 0 "delete $THINPOOL_NUM" || true

# Create snapshot
firecracker-ctr --address /run/firecracker-containerd/containerd.sock images pull --snapshotter devmapper $IMAGE
mv /home/daisy/snapshot /home/daisy/snapshot.1 || true
screen -dmS containerd bash -c "firecracker-ctr --address /run/firecracker-containerd/containerd.sock run --snapshotter devmapper --runtime aws.firecracker --net-host $IMAGE $NAME"
sleep 10

pushd $(pwd)
cd /var/lib/firecracker-containerd/shim-base/default#*
curl --unix-socket firecracker.sock -i \
    -X PATCH 'http://localhost/vm' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
            "state": "Paused"
    }'

curl --unix-socket firecracker.sock -i \
    -X PUT 'http://localhost/snapshot/create' \
    -H  'Accept: application/json' \
    -H  'Content-Type: application/json' \
    -d '{
            "snapshot_type": "Full",
            "snapshot_path": "./snapshot_file",
            "mem_file_path": "./mem_file"
    }'

# Create thinpool device
DEVICE=/dev/mapper/$(grep -aPo 'fc-dev-thinpool-snap-[0-9][0-9][0-9]' snapshot_file)
TABLE_INFO=$(dmsetup table --target thin $DEVICE)
TABLE_PART=$(echo $TABLE_INFO | awk 'match($0, /^.*:[0-9]*/) {print substr($0,RSTART,RLENGTH)}')
TABLE_NUMBER=$(echo $TABLE_INFO | awk 'match($0, /[0-9]*$/, arr) {print substr($0,RSTART,RLENGTH)}')
dmsetup suspend $DEVICE
dmsetup message /dev/mapper/fc-dev-thinpool 0 "create_snap $THINPOOL_NUM $TABLE_NUMBER"
dmsetup resume $DEVICE
dmsetup create fc-dev-thinpool-snap-$THINPOOL_NAME --table "$TABLE_PART $THINPOOL_NUM"

# Recofig snapshot file and move to snapshot folder
sed -i "s/fc-dev-thinpool-snap-[0-9][0-9][0-9]/fc-dev-thinpool-snap-$THINPOOL_NAME/g" snapshot_file
cp mem_file /home/daisy/snapshot.1/
cp snapshot_file /home/daisy/snapshot.1/
popd

mv /home/daisy/snapshot.1 /home/daisy/snapshot || true

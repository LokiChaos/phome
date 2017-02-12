#!/usr/bin/env bash
# Author: LokiChaos ©2016 Released under the ISC License
# USE: phinit [USR] [DEVICE]

USR="$1"
DEVICE="$2"

# Magic UID/GID for the actual drive fs
MUID=31337
MGID=31337

# Get UUID of block device
UUID=$(blkid $DEVICE -sUUID -ovalue)

echo "UUID of phome device = \'$UUID\'"

GRP=$(id -gn)

echo "Creating ~/.phome config"
mkdir /home/$USR/.phome
mkdir /home/$USR/.phome/mount
mkdir /home/$USR/.phome/bind

echo "UUID=\"$UUID\""  >> /home/$USR/.phome/config
echo "MUID=$MUID"     >> /home/$USR/.phome/config
echo "MGID=$MGID"     >> /home/$USR/.phome/config
echo "OVERLAY=()"     >> /home/$USR/.phome/config

chown -R $USR:$GRP /home/$USR/.phome

echo "Installing phome to /usr/local/bin"
cp ./bin/phome /usr/local/bin/phome
chown root:root /usr/local/bin/phome
chmod 755 /usr/local/bin/phome

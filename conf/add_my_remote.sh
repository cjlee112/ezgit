#!/bin/sh

REMOTENAME=$1
PUBKEYFILE=$2
REMOTES_INDEX=$3
USERID=`cut -d' ' -f3 $PUBKEYFILE`
MYNAME=`grep "^$USERID" $REMOTES_INDEX|cut -f2`
REMOTE_URL=`grep "^$USERID" $REMOTES_INDEX|cut -f3`

git config user.name "$MYNAME"
git config user.email "$USERID"
git remote add "$REMOTENAME" "$REMOTE_URL"

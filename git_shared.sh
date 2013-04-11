#!/bin/bash

function getIp() {
  ip=`ifconfig | grep inet | grep -v inet6 | grep -v 127.0.0.1 | awk -F" " '{print $2}' | tail -1`
  echo $ip
}

function shareProject() {
  path=/tmp/git_share
  your_src_path=$1
  your_share_name=$2
  
  if [ -x $path ]
  then
    rm -rf $path
  fi
  mkdir -pv $path
  kill `pgrep -f git_share`
  git daemon --export-all --base-path=$path &
  echo "create tmp path"
  ln -s  $your_src_path  $path/$your_share_name
  echo "create soft link from $your_src_path to $path/$your_share_name"
}

if [[ $# == 1 ]]
then
  ip=`getIp`
  your_share_name=dest.git
  shareProject $1 $your_share_name
  echo "git clone git://${ip}/${your_share_name}"
else
  echo "git_shared.sh /tmp/abc"
fi


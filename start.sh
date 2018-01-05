#!/bin/bash
echo "xvfb"
set +x
set -e
# export LC_ALL=en_US
# export LANG="$LC_ALL"
export DISPLAY=:99
Xvfb -screen 0 1920x1080x24 :99 &
until xset -q
do
	echo "Waiting for X server to start..."
	sleep 1;
done
echo "sikuli"
java -jar target/SikuliLibrary.jar 1000 .

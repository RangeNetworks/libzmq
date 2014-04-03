#!/bin/bash

VERSION=3.2.2

# git clone https://github.com/zeromq/cppzmq.git
# zmq.hpp version 235803740753312576495301ebf5b8ed76407173

sayAndDo () {
	echo $@
	eval $@
	if [ $? -ne 0 ]
	then
		echo "ERROR: command failed!"
		exit 1
	fi
}

installIfMissing () {
	dpkg -s $@ > /dev/null
	if [ $? -ne 0 ]; then
		echo " - oops, missing $@, installing"
		sudo apt-get install $@
	else
		echo " - $@ ok"
	fi
	echo
}

if [ ! -f zeromq-$VERSION.tar.gz ]
then
	sayAndDo wget http://download.zeromq.org/zeromq-$VERSION.tar.gz
fi

if [ -d zeromq-$VERSION ]
then
	sayAndDo rm -rf zeromq-$VERSION
fi

rm range-libzmq*
sayAndDo tar zxf zeromq-$VERSION.tar.gz
sayAndDo mkdir zeromq-$VERSION/debian
sayAndDo cp debian/* zeromq-$VERSION/debian/
sayAndDo cd zeromq-$VERSION
sayAndDo dpkg-buildpackage -us -uc


#!/usr/bin/env bash

if [[ ! -r go1.4.3 ]]; then
	wget -c https://dl.google.com/go/go1.4.3.linux-amd64.tar.gz
	tar zxf go1.4.3.linux-amd64.tar.gz
	mv go go1.4.3
fi


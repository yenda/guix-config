.PHONY: all configure guix

all: guix

configure:
	cp .xsession ~/
	cp -r .i3 ~/.i3

guix:
	cp ./config.scm /etc/config.scm
	guix system reconfigure /etc/config.scm

default: all

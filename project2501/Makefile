.PHONY: all configure guix

all: guix

configure:
	cp .xsession ~/.xsession
	chmod +x ~/.xsession

guix:
	cp ./config.scm /etc/config.scm
	guix system reconfigure /etc/config.scm

default: all

.PHONY: all x11 guix

all: x11 guix

x11:
	mkdir -p /etc/X11
	mkdir -p /etc/X11/xorg.conf.d
	cp ../10-evdev.conf /etc/X11/xorg.conf.d/10-evdev.conf

guix:
	cp ./config.scm /etc/config.scm
	guix system reconfigure /etc/config.scm

default: all

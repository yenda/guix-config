;; This is an operating system configuration template
;; for a "desktop" setup with X11.

(use-modules (gnu) (gnu system nss) (linux-nonfree))
(use-service-modules desktop)
(use-package-modules wicd avahi xorg certs suckless i3)

(operating-system
  (host-name "project2501")
  (timezone "Europe/Paris")
  (locale "en_US.UTF-8")

  (kernel linux-nonfree)
  (firmware (cons* radeon-RS780-firmware-non-free %base-firmware))

  ;; Assuming /dev/sdX is the target hard disk, and "root" is
  ;; the label of the target root file system.
  (bootloader (grub-configuration (device "/dev/sda")))
  (file-systems (cons* (file-system
                        (device "root")
                        (title 'label)
                        (mount-point "/")
                        (type "ext4"))
		       (file-system
                        (device "home")
                        (title 'label)
                        (mount-point "/home")
                        (type "ext4"))
                       (file-system
                        (device "/dev/sdb1")
                        (mount-point "/mnt/Monster1")
                        (type "ext4"))
                      %base-file-systems))

  (swap-devices '("/dev/sda2"))
  (groups (cons (user-group (name "nixbld")) %base-groups))
  (users (list (user-account
                (name "yenda")
                (comment "Lisp rocks")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"
					"nixbld"))
                (home-directory "/home/yenda"))))

  ;; Add Xfce and Ratpoison; that allows us to choose
  ;; sessions using either of these at the log-in screen.
  (packages (cons* i3-wm i3status dmenu		     ;desktop environments
                   xterm wicd avahi  ;useful tools
                   nss-certs         ;for HTTPS access
		   xorg-server xf86-input-evdev
		   xf86-video-fbdev
		   xf86-video-modesetting
		   xf86-video-ati
                   %base-packages))

  ;; Use the "desktop" services, which include the X11
  ;; log-in service, networking with Wicd, and more.
  (services (cons* (console-keymap-service "fr")
  		   %desktop-services))
  ;;(services %desktop-services)
  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))

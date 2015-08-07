;; This is an operating system configuration template
;; for a "desktop" setup with X11.

(use-modules (gnu) (gnu system nss))
(use-service-modules desktop)
(use-package-modules xfce ratpoison wicd avahi xorg certs)

(operating-system
  (host-name "project2501")
  (timezone "Europe/Paris")
  (locale "en_US.UTF-8")

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
                      %base-file-systems))

  (swap-devices '("/dev/sda2"))

  (users (list (user-account
                (name "yenda")
                (comment "Lisp rocks")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video"))
                (home-directory "/home/yenda"))))

  ;; Add Xfce and Ratpoison; that allows us to choose
  ;; sessions using either of these at the log-in screen.
  (packages (cons* xfce ratpoison    ;desktop environments
                   xterm wicd avahi  ;useful tools
                   nss-certs         ;for HTTPS access
                   %base-packages))

  ;; Use the "desktop" services, which include the X11
  ;; log-in service, networking with Wicd, and more.
  (services (cons* (console-keymap-service "fr")
  		   %desktop-services))
  ;;(services %desktop-services)
  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
(setq gc-cons-threshold most-positive-fixnum)

(setq native-comdeffered-compilation nil
      native-comp-jit-compilation nil)

(setq package-enable-at-startup nil)

(setq use-package-enable-imenu-support t)

(setq load-prefer-newer noninteractive)

(set-language-environment 'Chinese-GB)
(setq locale-coding-system 'utf-8)

(setq frame-inhibit-implied-resize t)

(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(when (featurep 'ns)
  (push '(ns-transparent-titleber . t) default-frame-alist))

(setq mode-line-format nil)

(provide 'early-init)

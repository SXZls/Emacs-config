(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(setq gc-cons-threshold most-positive-fixnum)

(setq auto-mode-case-fold nil)

(unless (or (daemonp) noninteractive init-file-debug)
  (let ((default-handlers file-name-handler-alist))
    (setq file-name-handler-alist nil)
    (add-hook 'emacs-startup-hook
	      (lambda ()
		(setq file-name-handler-alist
		      (delete-dups(append file-name-handler-alist default-handlers))))
	      101)))

(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)


(setq jit-lock-defer-time 0)

(defun update-load-path (&rest _)
  "Update the `load-path` to prioritize personal configurations."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

;; Add subdirectories inside "site-lisp" to `load-path`
(defun add-subdirs-to-load-path (&rest _)
  "Recursively add subdirectories in `site-lisp` to `load-path`.

Avoid placing large files like EAF in `site-lisp` to prevent slow startup."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

;; Ensure these functions are called after `package-initialize`
(advice-add #'package-initialize :after #'update-load-path)
(advice-add #'package-initialize :after #'add-subdirs-to-load-path)

;; Initialize load paths explicitly
(update-load-path)

;; Requisites
(require 'init-const)
(require 'init-custom)
(require 'init-funcs)

;; Packages
;; Without this comment Emacs25 adds (package-initialize) here
(require 'init-package)

(require 'init-scheme)
(require 'init-clisp)
(require 'init-racket)

(provide 'init)

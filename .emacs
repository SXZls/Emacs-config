(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-line-numbers-type 'relative)
 '(package-selected-packages '(geiser-chez paredit racket-mode sly))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Unifont" :foundry "outline" :slant normal :weight regular :height 139 :width normal)))))
;; Default dark theme
(set-background-color "black")
(set-foreground-color "white")
;;;;;;;;;;;;;;;;;;
;; package source
;;;;;;;;;;;;;;;;;;
(require 'package)
(setq package-archives '(("gnu"."https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa"."https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
			 ("nongnu"."https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
			 ("org"."https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))
(package-initialize)
(unless(package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;;save page
(desktop-save-mode 1)
(setq desktop-path'("~/.emacs.d/desktop"))

;;revert
(global-auto-revert-mode t)

;;basic function
(electric-pair-mode 1)
(use-package which-key
  :ensure t
  :config (which-key-mode))


(require 'eglot)
;;;;;;;;;;;;;;;;
;; clang C/C++
;;;;;;;;;;;;;;;;
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

;;;;;;;;;;;;
;; paredit to lisp
;;;;;;;;;;;
(use-package paredit
  :ensure t
  :hook ((lisp-mode . paredit-mode)
	 (sly-mrepl-mode . paredit-mode)
	 (scheme-mode . paredit-mode)))
;;;;;;;;;;;;
;; Scheme 
;;;;;;;;;;;;

(use-package geiser
  :ensure t
  :config
  ;; default chez
  (setq geiser-default-implementation 'chez)
  (setq geiser-active-implementation '(chez))
  ;;chez path
  (setq geiser-chez-library "chez")
  ;; repl config
  (setq geiser-repl-history-filename "~/.emacs.d/history/chez-history")
  (setq geiser-mode-start-repl-p nil)
  (setq geiser-repl-query-on-kill-p nil)
  ;; chez start file
  (setq geiser-chez-init-file "~/.chezscheme.rc")
  (setq geiser-chez-extra-command-lin-parameters '("--optimize-level" "2")))
(use-package geiser-chez
  :ensure t
  :after geiser)
;; push scheme interpreter path to exec-path

;; scheme interpreter name
(setq scheme-program-name "scheme")

;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))

(defun switch-other-window-to-buffer (name)
    (other-window 1)
    (switch-to-buffer name)
    (other-window 1))

(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (split-window-vertically (floor (* 0.68 (window-height))))
    ;; (split-window-horizontally (floor (* 0.5 (window-width))))
    (switch-other-window-to-buffer "*scheme*"))
   ((not (member "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))))
    (switch-other-window-to-buffer "*scheme*"))))

(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))

(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

(add-hook 'scheme-mode-hook
  (lambda ()
    (paredit-mode 1)
    (define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
    (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)))

;;;;;;;;;;;
;; racket
;;;;;;;;;;;
(require 'racket-mode)
(setq racket-racket-program "racket")
(setq racket-raco-program "raco")
(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-x C-j") 'racket-run)))
(setq tab-always-indent 'complete)

;;;;;;;;;;;;;;;;
;; comman lisp
;;;;;;;;;;;;;;;;
(use-package sly
  :ensure t
  :config
  (setq sly-default-lisp 'sbcl)
  (setq sly-kill-without-query-p t)
  (setq sly-auto-start 'ask)
  (setq sly-quicklisp-load-setup-file "~/.config/commonlisp/source/quicklisp/setup.list")
  (sly-setup '(sly-fancy)))

(global-set-key (kbd "C-c s") 'sly)

(add-hook 'lisp-mode-hook
	  (lambda ()
	    (show-paren-mode 1)
	    (electric-pair-mode 1)))
(add-to-list 'auto-mode-alist '("\\.lisp\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.lsp\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.asd\\'" . lisp-mode))





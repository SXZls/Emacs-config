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

(provide 'init-clisp)

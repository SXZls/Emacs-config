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
(use-package paredit
  :ensure t
  :hook((elisp-mode . paredit)))

(display-battery-mode 1)

(provide 'init-funcs)

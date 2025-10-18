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

(provide 'init-scheme)

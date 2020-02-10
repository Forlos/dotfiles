;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;; TODO find a way to do this better
(load "~/.doom.d/keybinds.el")

;; Variables
(setq
 company-idle-delay 0.1
)

;; LSP config
(add-hook! lsp-mode #'lsp-ui-mode )
;; (add-hook! lsp-ui-mode #'lsp-ui-doc-mode)
(setq lsp-ui-doc-header t)
;; (setq-hook! lsp-ui-doc-mode
;;   lsp-ui-doc-delay 0.1
;;   lsp-ui-doc-max-width 150
;;   lsp-ui-doc-max-height 30)

(setq lsp-rust-server 'rust-analyzer)

;; Theme
(setq
 doom-font (font-spec
                 :family "GohuFont Nerd Font"
                 :size 16)
 doom-theme 'doom-city-lights
 ;; doom-theme 'doom-acario-dark
 ;; doom-theme 'doom-tomorrow-night
 ;; doom-theme 'doom-oceanic-next
 doom-themes-enable-bold t
 doom-themes-enable-italic t
 doom-modeline-major-mode-icon t
 doom-themes-treemacs-theme "doom-colors"
 display-line-numbers-type 'relative
 treemacs-show-cursor t
)
(doom-themes-treemacs-config)
(doom-themes-org-config)
(rainbow-delimiters-mode-enable)
(global-color-identifiers-mode)



;; ORG
(after! org
  (setq org-tags-column -80
        org-todo-keywords '((sequence "TODO" "PROGRESS" "NEXT" "WAITING" "STALLED" "CANCELED" "DONE"))
        org-todo-keyword-faces '(("TODO" :foreground "#dc752f")
                                 ("PROGRESS" :foreground "#4f97d7")
                                 ("NEXT" :foreground "#f0a0a0")
                                 ("WAITING" :foreground "#9f7efe")
                                 ("CANCELED" :foreground "#ff6480")
                                 ("STALLED" :foreground "#707070")
                                 ("DONE" :foreground "#86dc2f"))
        org-priority-faces '((?A :foreground "#e45659" :underline t)
                             (?B :foreground "#da8548")
                             (?C :foreground "#0098dd"))))
(def-package! org-fancy-priorities
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '((?A . "HIGH")
                                    (?B . "MID")
                                    (?C . "LOW"))))

;; Fullscreen at startup
(toggle-frame-maximized)

;; Toggle transparency
(set-frame-parameter (selected-frame) 'alpha '(90 . 60))
(add-to-list 'default-frame-alist '(alpha . (90 . 60)))

(defun toggle-transparency ()
 (interactive)
 (let ((alpha (frame-parameter nil 'alpha)))
   (set-frame-parameter
    nil 'alpha
    (if (eql (cond ((numberp alpha) alpha)
                   ((numberp (cdr alpha)) (cdr alpha))
                   ;; Also handle undocumented (<active> <inactive>) form.
                   ((numberp (cadr alpha)) (cadr alpha)))
             100)
        '(90 . 60) '(100 . 100)))))

;; File extensions
(add-to-list 'auto-mode-alist '("\\.ksy$" . yaml-mode))

(use-package! nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-save-place-file (concat doom-cache-dir "nov-places")))
;; SSH
(keychain-refresh-environment)

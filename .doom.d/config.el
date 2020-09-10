;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;; TODO find a way to do this better
(load "~/.doom.d/keybinds.el")

;; Variables
(setq
 company-minimum-prefix-length 1
 company-idle-delay 0.0
 )

;; Git
(after! magit
  (magit-todos-mode)
  (setq magit-todos-branch-list nil))

;; LSP config
(after! lsp
  (add-hook! lsp-mode #'lsp-ui-mode )
  (add-hook! lsp-ui-mode #'lsp-ui-doc-mode))

(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-header t
        lsp-ui-doc-include-signature t
        lsp-ui-doc-delay 1.0
        lsp-ui-sideline-delay 0.0
        lsp-ui-doc-max-width 150
        lsp-ui-doc-max-height 30
        lsp-ui-doc-alignment 'frame
        lsp-ui-doc-position 'top))

(after! rustic
  (setq rustic-lsp-server 'rust-analyzer
        rustic-format-on-save t
        rustic-format-display-method nil
        rustic-compile-display-method nil
        lsp-rust-analyzer-cargo-watch-command "clippy"))

(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))

;; Theme
(setq
 doom-font (font-spec
            :family "GohuFont Nerd Font"
            ;; :family "Cozette"
            :size 14)
 doom-theme 'doom-city-lights
 ;; doom-theme 'doom-horizon
 ;; doom-theme 'doom-acario-dark
 ;; doom-theme 'doom-tomorrow-night
 ;; doom-theme 'doom-oceanic-next
 doom-themes-enable-bold t
 doom-themes-enable-italic t
 doom-modeline-major-mode-icon t
 doom-themes-treemacs-theme "doom-colors"
 display-line-numbers-type 'relative
 treemacs-show-cursor t
 doom-themes-neotree-file-icons t
 )
(doom-themes-neotree-config)
(doom-themes-treemacs-config)
(doom-themes-org-config)
(add-hook 'after-init-hook 'global-color-identifiers-mode)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'format-all-mode)


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
(use-package! org-fancy-priorities
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

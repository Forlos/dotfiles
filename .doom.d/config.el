;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;; TODO find a way to do this better
(load "~/.doom.d/keybinds.el")

;; Variables
(setq company-idle-delay 0.3)

;; LSP config
(add-hook! lsp-mode #'lsp-ui-mode )
(add-hook! lsp-ui-mode #'lsp-ui-doc-mode)
(setq lsp-ui-doc-header t)
(setq-hook! lsp-ui-doc-mode
  lsp-ui-doc-delay 0.1
  lsp-ui-doc-max-width 150
  lsp-ui-doc-max-height 30)

(setq lsp-rust-server 'rust-analyzer)

;; Theme
(setq
 doom-font (font-spec
                 :family "GohuFont Nerd Font"
                 :size 16)
 doom-theme 'doom-city-lights
 doom-modeline-major-mode-icon t
 display-line-numbers-type 'relative
)

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

;; Setup indent
(defun setup-indent-global (n)
  (setq c-basic-offset n)
  (setq rust-indent-offset n)
  (setq javascript-indent-level n)
  (setq js-indent-level n)
  (setq js2-basic-offset n)
  (setq web-mode-markup-indent-offset n)
  (setq web-mode-css-indent-offset n)
  (setq web-mode-code-indent-offset n)
  (setq css-indent-offset n)
  (setq go-tab-width n)
  )

(setup-indent-global 2)

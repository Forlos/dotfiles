;;; ~/.doom.d/keybinds.el -*- lexical-binding: t; -*-

;; Window

;; TODO hone my lisp skills and do this in one function
(map! :leader
      :desc "Jump to left window" "w <left>" #'evil-window-left)

(map! :leader
      :desc "Jump to right window" "w <right>" #'evil-window-right)

(map! :leader
      :desc "Jump to right window" "w <down>" #'evil-window-down)

(map! :leader
      :desc "Jump to right window" "w <up>" #'evil-window-up)

(map! :leader
      :desc "Split window vertically" "w /" #'evil-window-vsplit)

(map! :leader
      :desc "Split window horizontally" "w -" #'evil-window-split)

;; Shell
(map! :leader
      :desc "Start eshell" "'" #'+vterm/toggle)

;; Misc
(map! :leader
      :desc "M-x" "SPC" #'counsel-M-x)

(map! :v [tab] #'indent-for-tab-command)

(map! :leader
      :desc "Toggle focus mode" "b f" #'focus-mode)

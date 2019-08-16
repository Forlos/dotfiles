;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------

     ;; Utility
     (colors :variables
             colors-colorize-identifiers 'variables
             colors-enable-nyan-cat-progress-bar (display-graphic-p))
     (auto-completion :variables
                      auto-completion-enable-help-tooltip 't
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'complete
                      auto-completion-idle-delay 0.1
                      auto-completion-enable-sort-by-usage t)
     (shell :variables
            shell-default-height 40
            shell-default-position 'bottom)
     helm
     syntax-checking
     emacs-lisp
     git
     markdown
     org
     themes-megapack
     docker

     ;; Programming
     (c-c++ :variables c-c++-enable-clang-support t)
     (rust)
     (go :variables
         go-use-golangci-lint t
         go-backend 'lsp
         godoc-at-point-function 'godoc-gogetdoc)
     asm
     python
     java
     lua
     lsp

     ;; Web dev
     javascript
     html

     ;; Data formats
     json
     yaml
     sql

     ;; Funtional
     erlang
     elixir
     ;; (clojure :variables
     ;;          clojure-enable-fancify-symbols t
     ;;          clojure-enable-sayid t
     ;;          clojure-enable-clj-refactor t)

     ;; Unused for now
     ;; spell-checking
     ;; semantic
     ;; selectric
     ;; xkcd
     ;; version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     all-the-icons
     base16-theme
     beacon
     dumb-jump
     doom-themes
     magit-todos
     rainbow-delimiters
     sublimity
     wttrin
     )
; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 8)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(doom-city-lights
                         badwolf
                         base16-atelier-cave
                         doom-one
                         doom-dracula
                         dracula
                         monokai)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("GohuFont Nerd Font"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.2)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'original
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 60
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative t
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers '(:t
                               :disabled-for-modes dired-mode
                               doc-view-mode
                               markdown-mode
                               org-mode
                               pdf-view-mode
                               )
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun setup-indent-global (n)
  ;; java/c/c++
  (setq c-basic-offset n)
  ;; web development
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode, in latest js2-mode, it's alias of js-indent-level
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n) ; css-mode
  (setq go-tab-width n)
  )

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  (setq pdf-view-incompatible-modes 'linum-mode)

  (setq theming-modifications
        '(
          (spolsky
           (default :background "#263647")
           (hl-line :background "#2e363f")
           (region :background "#2075c7")
           (mode-line :background "#00152b")
           (mode-inactive :background "#00152b")
           (fringe :background "#263647")
           (linum :background "#263647" :foreground "#4ec2f7")
           (powerline-active1 :foreground "#DEDEDE" :background "#2075c7" :inverse-video nil)
           (powerline-active2 :foreground "#EEDC82" :background "#151515" :inverse-video nil)
           )
          )
        )

  (setup-indent-global 4) ;tab = 4 spaces

  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  (magit-todos-mode)

  (setq wttrin-default-cities '("Kraków"))
  (setq wttrin-default-accept-language '("Accept-Language" . "en-US"))

  (use-package toml-mode)

  (setq lsp-enable-completion-at-point t)
  (setq lsp-ui-remap-xref-keybindings 1)

  ;; (setq rust-backend "lsp")
  ;; (add-hook 'rust-mode-hook #'lsp)
  ;; (nconc rust-mode-hook
  ;;        (list
  ;;         (lambda ()
  ;;           (add-to-list 'company-backends 'company-lsp))))

  (defconst jv-lsp-packages
    '(lsp-mode
      lsp-ui))

  (spacemacs|diminish lsp-mode " Ⓛ" " L")

  (require 'multiple-cursors)
  ;; NeoTree theme to show icons
  (setq neo-theme 'icons)

  ;; Start beacon mode to show a light when the cursor moves
  (beacon-mode t)

  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  ;; Auto start rainbow delimeters in most programming modes
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

  ;; Auto start aggressive indent in most programming modes
  ;; (add-hook 'prog-mode-hook #'aggressive-indent-mode)

  ;; Add some nice additions like italicized comments, etc.
  (set-face-attribute 'font-lock-comment-delimiter-face nil :slant 'italic)
  (set-face-attribute 'font-lock-comment-face nil :slant 'italic)
  (set-face-attribute 'font-lock-doc-face nil :slant 'italic)
  (set-face-attribute 'font-lock-keyword-face nil :weight 'bold)
  (set-face-attribute 'font-lock-builtin-face nil :weight 'bold)
  (set-face-attribute 'font-lock-preprocessor-face nil :weight 'bold)

  (require 'sublimity)
  (require 'sublimity-scroll)
  ;; (require 'sublimity-map) ;; experimental
  (require 'sublimity-attractive)

  (sublimity-mode 1)

  (setq sublimity-scroll-weight 15
        sublimity-scroll-drift-length 30)

  ;; (setq sublimity-map-size 20)
  ;; (setq sublimity-map-fraction 0.3)
  ;; (setq sublimity-map-text-scale -7)
  ;; (sublimity-map-set-delay 10)
  ;; (add-hook 'sublimity-map-setup-hook
  ;;           (lambda ()
  ;;             (setq buffer-face-mode-face '(:family "Monospace"))
  ;;             (buffer-face-mode)))

  (setq sublimity-attractive-centering-width nil)
  (sublimity-attractive-hide-bars)
  ;; (sublimity-attractive-hide-vertical-border)
  (sublimity-attractive-hide-fringes)
  ;; (sublimity-attractive-hide-modelines)

  (setq x86-lookup-pdf "/home/forlos/Documents/325383-sdm-vol-2abcd.pdf")
  ;; (setq x86-lookup-pdftotext-program "pdftotext")
  ;; Enable indent guide at startup
  ;; (spacemacs/toggle-indent-guide-globally-on)

  ;; (global-aggressive-indent-mode 1)
  ;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)


  ;; Elixir config
  (setq flycheck-elixir-credo-strict t)

  ;; Clojure config
  (setq clojure-enable-linters t)
  (spacemacs/toggle-evil-safe-lisp-structural-editing-on-register-hooks)

  ;; Look
  (spacemacs/toggle-transparency)
  (custom-set-faces
   '(company-tooltip-common
     ((t (:inherit company-tooltip :weight bold :underline nil))))
   '(company-tooltip-common-selection
     ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#3C3D37" t)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(line-number-mode nil)
 '(linum-format " %7i ")
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (omnisharp csharp-mode company-tabnine eglot flymake jsonrpc transient lv company-racer deferred company-lsp lsp-ui lsp-rust lsp-mode ht tabbar pdf-tools tablist base16-theme lua-mode undo-tree memory-usage sublimity toml-mode sql-indent racer flycheck-rust cargo rust-mode parrot doom-city-lights-theme doom-themes minimap adaptive-wrap tern beacon seq all-the-icons memoize treepy graphql c-eldoc disaster company-c-headers cmake-mode clang-format zenburn-theme zen-and-art-theme white-sand-theme web-mode web-beautify underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme tagedit sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smeargle slim-mode seti-theme scss-mode sass-mode reverse-theme rebecca-theme rainbow-mode rainbow-identifiers railscasts-theme purple-haze-theme pug-mode professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme orgit organic-green-theme org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme nasm-mode naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme magit-gitflow madhat2r-theme lush-theme livid-mode skewer-mode simple-httpd light-soap-theme less-css-mode json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc jbeans-theme jazz-theme ir-black-theme inkpot-theme htmlize heroku-theme hemisu-theme helm-gitignore helm-css-scss hc-zenburn-theme haml-mode gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gandalf-theme flatui-theme flatland-theme farmhouse-theme exotica-theme evil-magit magit magit-popup git-commit ghub let-alist with-editor espresso-theme emmet-mode dracula-theme django-theme darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme company-web web-completion-data company-tern company-emacs-eclim eclim color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized color-identifiers-mode coffee-mode clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme company-quickhelp yapfify xterm-color shell-pop pyvenv pytest pyenv-mode py-isort pip-requirements multi-term mmm-mode markdown-toc markdown-mode live-py-mode hy-mode dash-functional helm-pydoc helm-company helm-c-yasnippet gh-md fuzzy flycheck-pos-tip pos-tip flycheck eshell-z eshell-prompt-extras esh-help cython-mode company-statistics company-anaconda company auto-yasnippet yasnippet anaconda-mode pythonic ac-ispell auto-complete spinner evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline smartparens restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-unimpaired evil-search-highlight-persist evil-numbers evil-nerd-commenter evil goto-chg eval-sexp-fu highlight elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent ace-window ace-link ace-jump-helm-line helm avy helm-core popup async)))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
'(ansi-color-names-vector
  ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
'(custom-safe-themes
  (quote
   ("9108af90a0bd5c36b67973aea59a0f55ad7ae36c8bcc0d9145e91e5e290cac31" "a584e58e19f492cad36b361fc066da1e4d57fd360c77968edfabcdf77361126a" "e1c47ab9db37fccca2a2597b290d2aaac241967b8dcd73e02e244178cbd00c37" "823f4cfc17fccd45c42d1cd75214c73369bc5e3066bf4f9963c71aca36d94434" "6a13e8c06de875e6438445d0ff571d36a0de849e6a8b268c99ef771f907eea98" "cf45214bd141043f51c82bf4e340e72773ba2bf7cd1d1984de6d50e506d60cd5" "caf521e66311479f696ac7669692286c0ef6e102e4eaf4910462a52da4e54c39" "38132599432926fee460d42607fde769967ec814af16da3f406ac510306bff2e" "8b63fe87e15a2721eb208480bf0829b033ee568dd03bde040e4d53a1b2d071f9" "22a3a2a124792c635cef4e9b91eedcceccf5513de67a62b31ce96cc571e3d989" "c48551a5fb7b9fc019bf3f61ebf14cf7c9cdca79bcb2a4219195371c02268f11" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :foreground "#f8f6f2" :background "#1c1b1a"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-message-face (quote default))
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#3C3D37" t)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(line-number-mode nil)
 '(linum-format " %7i ")
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
    (cider phpunit phpcbf php-extras php-auto-yasnippets helm-gtags ggtags drupal-mode counsel-gtags company-php ac-php-core xcscope php-mode omnisharp csharp-mode company-tabnine eglot flymake jsonrpc transient lv company-racer deferred company-lsp lsp-ui lsp-rust lsp-mode ht tabbar pdf-tools tablist base16-theme lua-mode undo-tree memory-usage sublimity toml-mode sql-indent racer flycheck-rust cargo rust-mode parrot doom-city-lights-theme doom-themes minimap adaptive-wrap tern beacon seq all-the-icons memoize treepy graphql c-eldoc disaster company-c-headers cmake-mode clang-format zenburn-theme zen-and-art-theme white-sand-theme web-mode web-beautify underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme tagedit sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smeargle slim-mode seti-theme scss-mode sass-mode reverse-theme rebecca-theme rainbow-mode rainbow-identifiers railscasts-theme purple-haze-theme pug-mode professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme orgit organic-green-theme org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme nasm-mode naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme magit-gitflow madhat2r-theme lush-theme livid-mode skewer-mode simple-httpd light-soap-theme less-css-mode json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc jbeans-theme jazz-theme ir-black-theme inkpot-theme htmlize heroku-theme hemisu-theme helm-gitignore helm-css-scss hc-zenburn-theme haml-mode gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gandalf-theme flatui-theme flatland-theme farmhouse-theme exotica-theme evil-magit magit magit-popup git-commit ghub let-alist with-editor espresso-theme emmet-mode dracula-theme django-theme darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme company-web web-completion-data company-tern company-emacs-eclim eclim color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized color-identifiers-mode coffee-mode clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme company-quickhelp yapfify xterm-color shell-pop pyvenv pytest pyenv-mode py-isort pip-requirements multi-term mmm-mode markdown-toc markdown-mode live-py-mode hy-mode dash-functional helm-pydoc helm-company helm-c-yasnippet gh-md fuzzy flycheck-pos-tip pos-tip flycheck eshell-z eshell-prompt-extras esh-help cython-mode company-statistics company-anaconda company auto-yasnippet yasnippet anaconda-mode pythonic ac-ispell auto-complete spinner evil-visualstar evil-visual-mark-mode evil-tutor evil-surround evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline smartparens restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-unimpaired evil-search-highlight-persist evil-numbers evil-nerd-commenter evil goto-chg eval-sexp-fu highlight elisp-slime-nav dumb-jump f dash s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed aggressive-indent ace-window ace-link ace-jump-helm-line helm avy helm-core popup async)))
 '(paradox-github-token t)
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :foreground "#f8f6f2" :background "#1c1b1a"))))
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
)

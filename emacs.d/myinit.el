(setq
  inhibit-startup-screen t
  create-lockfiles nil
  make-backup-files nil
  auto-save-default nil
  column-number-mode t
  scroll-error-top-bottom t
  show-paren-delay 0.1
  use-package-verbose nil
  use-package-always-ensure t
  package-enable-at-startup nil
  sentence-end-double-space nil
  split-width-threshold nil
  split-height-threshold nil
  ring-bell-function 'ignore
  inhibit-startup-echo-area-message t
  frame-title-format '((:eval buffer-file-name))
  enable-local-variables :all
  mouse-1-click-follows-link t
  mouse-1-click-in-non-selected-windows t
  select-enable-clipboard t
  mouse-wheel-scroll-amount '(0.01)
  column-number-mode t
  confirm-kill-emacs (quote y-or-n-p)
  ns-use-native-fullscreen nil
  ns-pop-up-frames nil
  line-move-visual t)

(setq-default
  fill-column 70
  indent-tabs-mode nil
  truncate-lines t
  require-final-newline t
  fringe-mode '(4 . 2))

(defalias 'yes-or-no-p 'y-or-n-p)

(if window-system
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      (add-to-list 'initial-frame-alist '(width . 150))
      (add-to-list 'initial-frame-alist '(height . 50))
      (add-to-list 'default-frame-alist '(width . 150))
      (add-to-list 'default-frame-alist '(height . 50))))

(use-package cider
  :mode "\\.clj$"
  :init
    (add-hook 'clojure-mode-hook 'cider-jack-in))

(use-package js2-mode
  :mode "\\.js$"
  :init
    (add-hook 'js-mode-hook 'j2-minor-mode))

(use-package jsx-mode
  :mode "\\.jsx$")

(use-package json-mode
  :mode "\\.json$")

(use-package emmet-mode
  :mode "\\.html$"
  :init
    (add-hook 'html-mode-hook 'emmet-mode)
    (progn
      (setq emmet-expand-jsx-className? t)))

(use-package web-mode
  :mode "\\.html$"
  :init
    (setq web-mode-enable-auto-closing t)
    (setq web-mode-enable-auto-quoting t))

(setq py-python-command "python3")
(setq python-shell-interpreter "python3")

(use-package jedi
  :mode "\\.py$"
  :init
    (add-hook 'python-mode-hook 'jedi:setup)
    (add-hook 'python-mode-hook 'jedi:ac-setup))

(use-package auto-complete
  :init
    (progn
      (ac-config-default)
      (global-auto-complete-mode t)))

(use-package flycheck
  :init
    (global-flycheck-mode t))

(use-package dumb-jump
  :bind 
    (("C-c o" . dumb-jump-go)
     ("C-c p" . dumb-jump-back)
     ("C-c x" . dumb-jump-go-prefer-external)
     ("C-c z" . dumb-jump-go-prefer-external-other-window))
  :init
    (progn
      (dumb-jump-mode)))

(use-package yasnippet
  :init
    (yas-global-mode 1))

(use-package smartparens
  :init
    (smartparens-global-mode t))

(use-package magit)

(use-package git-gutter
  :config
    (global-git-gutter-mode))

(use-package ox-reveal
  :config
    (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
    (setq org-reveal-mathjax t))

(use-package dired+
  :config
    (require 'dired+))

(use-package linum
  :init
    (global-linum-mode 1)
    (setq linum-format "%4d "))

(use-package which-key
  :config
    (which-key-mode))

(use-package ido
  :init
    (progn
      (defun ido-M-x ()
        (interactive)
          (call-interactively
            (intern
              (ido-completing-read
                "M-x "
                  (all-completions "" obarray 'commandp)))))

  (ido-mode 1)
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point nil)
  (setq ido-create-new-buffer 'always)
  (setq ido-max-prospects 20)
  (setq ido-auto-merge-work-directories-length -1)))

(use-package ido-vertical-mode
  :init
    (progn
      (ido-vertical-mode 1)
        (defun bind-ido-keys ()
          (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
          (define-key ido-completion-map (kbd "C-p")   'ido-prev-match))
        (add-hook 'ido-setup-hook 'bind-ido-keys)))

(use-package base16-theme
  :init
    (load-theme 'base16-woodland t))

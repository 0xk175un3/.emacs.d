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

(blink-cursor-mode 0)
(global-hl-line-mode t)
(show-paren-mode t)
(delete-selection-mode 1)
(cua-mode 1)

(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :init
      (progn
        (exec-path-from-shell-initialize))))

(if window-system
    (progn
      (tool-bar-mode -1)
        (scroll-bar-mode -1)
        (add-to-list 'initial-frame-alist '(width . 150))
        (add-to-list 'initial-frame-alist '(height . 50))
        (add-to-list 'default-frame-alist '(width . 150))
        (add-to-list 'default-frame-alist '(height . 50))))

(use-package js2-mode
  :mode "\\.js$"
  :init
    (add-hook 'js-mode-hook 'js2-minor-mode))

(use-package smartparens
  :init
    (smartparens-global-mode t))

(use-package projectile
  :bind
  (:map projectile-mode-map
        ("C-c p f" . projectile-find-file)
        ("C-c p p" . projectile-switch-project))
  :init
  (progn
    (projectile-global-mode)
    (setq projectile-switch-project-action 'helm-projectile-find-file)
    (setq projectile-completion-system 'ido) ;; alternatively, 'helm
    (setq projectile-use-git-grep t)))

(use-package helm
  :init
  (progn
    (setq helm-follow-mode t)
    (setq helm-full-frame nil)
    ;; (setq helm-split-window-in-side-p nil)
    (setq helm-split-window-in-side-p t)
    (setq helm-split-window-default-side 'below)
    (setq helm-buffer-max-length nil)

    (setq helm-buffers-fuzzy-matching t)
    (setq helm-M-x-always-save-history nil)

    (setq helm-find-files-actions '
          (("Find File" . helm-find-file-or-marked)
           ("View file" . view-file)
           ("Zgrep File(s)" . helm-ff-zgrep)))

    (setq helm-type-file-actions
          '(("Find File" . helm-find-file-or-marked)
            ("View file" . view-file)
            ("Zgrep File(s)" . helm-ff-zgrep)))

    (add-to-list 'display-buffer-alist
                 `(,(rx bos "*helm" (+ anything) "*" eos)
                   (display-buffer-in-side-window)
                   (side            . bottom)
                   (window-height . 0.3)))))

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

(use-package magit)

(use-package git-gutter
  :config
    (global-git-gutter-mode))

(use-package ox-reveal
  :config
    (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
    (setq org-reveal-mathjax t))

(use-package linum
  :init
    (global-linum-mode 1)
    (setq linum-format "%4d "))

(use-package whitespace
  :diminish (global-whitespace-mode
             whitespace-mode
             whitespace-newline-mode)
  :config
  (progn
    (setq whitespace-style '(trailing tabs tab-mark face))
(global-whitespace-mode)))

(use-package which-key
  :config
    (which-key-mode))

(use-package evil
  :ensure t
  :init
    (progn
    (setq evil-default-cursor t))
  :config
    (evil-mode 1))

(use-package evil-leader
  :ensure t
  :init
    (global-evil-leader-mode
  (progn
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "g" 'magit-status ))))

(use-package evil-surround
  :ensure t
  :config
    (global-evil-surround-mode))

(use-package evil-escape
  :ensure t
  :init
    (setq-default evil-escape-key-sequence "jk")
  :config
    (evil-escape-mode))

(use-package evil-indent-textobject
  :ensure t)

(use-package evil-lion
  :ensure t
  :bind (:map evil-normal-state-map
    ("g l " . evil-lion-left)
    ("g L " . evil-lion-right)
    :map evil-visual-state-map
    ("g l " . evil-lion-left)
    ("g L " . evil-lion-right))
  :config
    (evil-lion-mode))

(use-package niflheim-theme
  :init
    (load-theme 'niflheim t))

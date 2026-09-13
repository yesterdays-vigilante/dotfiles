;;; ...  -*- lexical-binding: t -*-
;;;;;;;;;;;;;;;;;;;;
;; Package config ;;
;;;;;;;;;;;;;;;;;;;;

;; For local packages
(add-to-list 'load-path (expand-file-name "local" user-emacs-directory))

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;;;;;;;;;;;;;;;;;;;
;; Cosmetic stuff ;;
;;;;;;;;;;;;;;;;;;;;

(use-package color-theme-modern
  :ensure t
  :config
  (load-theme 'charcoal-black t t)
  (enable-theme 'charcoal-black))

(use-package powerline
  :ensure t
  :config
  (powerline-default-theme))

;; Font size
(set-face-attribute 'default nil :height 125)
;; Transparency
(set-frame-parameter (selected-frame) 'alpha '(98 98))
(add-to-list 'default-frame-alist '(alpha 98 98))
;; Turn off bell
(setq ring-bell-function 'ignore)

;;;;;;;;;;;;;;;;;;;;;;
;; Language support ;;
;;;;;;;;;;;;;;;;;;;;;;

;; Common Lisp
(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))

;; Clojure
(use-package clojure-mode
  :ensure t)

(use-package cider
  :ensure t)

;; Markdown
(use-package markdown-mode
  :ensure t)

;; YAML
(use-package yaml-mode
  :ensure t)

;; Ruby
;; Use ruby-mode for a bunch of other file types
(add-to-list 'auto-mode-alist
             '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . ruby-mode))

;; Dockerfile
(use-package dockerfile-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;
;; Productivity Stuff ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(use-package magit
  :ensure t
  :bind
  ("C-x M-s" . magit-status))

(use-package projectile
  :ensure t
  :bind
  ("s-f" . projectile-find-file))

(use-package flx-ido
  :ensure t
  :config
  ;; Enable IDO
  (ido-mode 1)
  (ido-everywhere 1)
  ;; Enable flx
  (flx-ido-mode 1)
  (setq ido-enable-flex-matching t)
  ;; Disable ido faces to see flx highlights
  (setq ido-use-faces nil))

(use-package ido-vertical-mode
  :ensure t
  :config
  (ido-vertical-mode))

(use-package newline-functions
  :bind
  ("<C-return>" . open-line-after)
  ("M-RET" . open-line-before))

;; Use spaces instead of tabs for indent everywhere
(setq-default indent-tabs-mode nil)
;; Line numbering
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
;; Disable backup/auto-save
(setq backup-inhibited t)
(setq auto-save-default nil)
;; Never save with trailing whitespace
(setq whitespace-style (list 'trailing 'indention))
(add-hook 'before-save-hook 'whitespace-cleanup)
;; Disable dangerous keybindings
(global-set-key (kbd "C-x C-z") nil)
(global-set-key (kbd "C-z") nil)
;; Basic housekeeping
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(global-auto-revert-mode t)
(electric-indent-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(cider dockerfile-mode flx-ido ido-vertical-mode json-mode linum-off
           magit markdown-mode powerline slime yaml-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

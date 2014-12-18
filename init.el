;;; init.el --- My init file
;; Copyright (C) 2014 Mattias Bengtsson

;; Author           : Mattias Bengtsson <mattias.jc.bengtsson@gmail.com>
;; Version          : 20141210
;; Keywords         : init
;; Package-Requires : ()
;; URL              : https://github.com/moonlite/.emacs.d
;; Compatibility    : GNU Emacs: 24.x

;;; The GNU GPLv2+ License:

;; gnome-emacs-starterkit is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by the
;; Free Software Foundation; either version 2 of the License, or (at your
;; option) any later version.

;; gnome-emacs-starterkit is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.

;; You should have received a copy of the GNU General Public License along
;; with gnome-emacs-starterkit; if not, write to the Free Software Foundation,
;; Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

;;; Commentary:

;;; Note:

;;; Code:

(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/cask/")

;; Use a separate customize file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;;;; Functions

(defun my/company-select-next-five ()
  "A bit more eager `company-select-next'."
  (interactive)
  (dotimes (number 5 nil) (company-select-next)))

(defun my/company-select-previous-five ()
  "A bit more eager `company-select-previous'."
  (interactive)
  (dotimes (number 5 nil) (company-select-previous)))

(defun my/preceding-char-match-p (pattern)
  "Match preceding char with PATTERN."
  (let ((str (string (preceding-char))))
    (string-match-p pattern str)))

(defun my/yas-expand ()
  "Perform a `yas-expand' but return nil on failure."
  (if (not (yas-minor-mode)) nil
    (let ((yas-fallback-behavior 'return-nil))
      (yas-expand))))

(defun my/tab-indent-or-complete ()
  "Tab indent or complete (using `company-mode') depending on context."
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (let ((old-indent (current-indentation)))
      (indent-for-tab-command)
      (if (and (= old-indent (current-indentation))
               (my/preceding-char-match-p "[a-zA-Z\-\.\>\_\/\:]")
               (null (my/yas-expand)))
          (company-complete-common)))))

;;;; Mode initializations

(add-hook 'c-mode-common-hook
          (lambda ()
            (require 'rtags)
            (unless rtags-process (rtags-restart-process))
            (setq-local rtags-completions-enabled t)
            (rtags-enable-standard-keybindings c-mode-base-map)
            (setq-local company-backends '((company-rtags)))
            ;; Work around a bug where c-mode-base-map doesn't
            ;; inherit from prog-mode-map
            (unless (keymap-parent c-mode-base-map)
              (set-keymap-parent c-mode-base-map prog-mode-map))))

;; Company
(add-hook 'company-mode-hook
          (lambda ()
            (define-key company-active-map (kbd "\C-n")    'company-select-next)
            (define-key company-active-map (kbd "\C-p")    'company-select-previous)
            (define-key company-active-map (kbd "<next>")  'my/company-select-next-five)
            (define-key company-active-map (kbd "<prior>") 'my/company-select-previous-five)
            (define-key company-active-map (kbd "\C-d")    'company-show-doc-buffer)
            (define-key company-active-map (kbd "\C-v")    'company-show-location)
            (define-key company-active-map (kbd "\C-g")    'company-abort)))

(add-hook 'flycheck-mode-hook
          (lambda()
            (require 'flycheck-jscs)
            (add-to-list 'flycheck-checkers 'javascript-jscs)))

(add-hook 'js2-mode-hook
          (lambda ()
            (require 'js2-refactor)
            (js2r-add-keybindings-with-prefix "C-c f")
            (setq-local company-backends '((company-dabbrev-code
                                            company-files
                                            company-keywords)))))

(add-hook 'nxml-mode-hook
          (lambda ()
            (setq-local company-backends '(company-nxml))))
(add-hook 'nxml-mode-hook 'my/prog-mode)

(defun my/prog-mode ()
  "My `prog-mode' hook."
  (setq-local indent-tabs-mode nil)
  (company-mode)
  (flycheck-mode)
  (define-key prog-mode-map (kbd "<tab>") 'my/tab-indent-or-complete))
(add-hook 'prog-mode-hook 'my/prog-mode)



;;;; Post-init

(defun init-ido ()
  "Initialize `IDO'."
  (interactive)

  (ido-mode)
  (ido-ubiquitous-mode)
  ;; Vertical IDO
  (ido-vertical-mode)
  ;; Fuzzy matching
  (flx-ido-mode)

  ;; smex is like ido but for M-x
  (global-set-key (kbd "M-x") 'smex))

(add-hook 'after-init-hook
          (lambda()
            (require 'cask)
            (cask-initialize)
            (pallet-mode t)
            (init-ido)
            (yas-global-mode)
            (projectile-global-mode)))



;;;; Other configuration

;; Integrate JHBuild and projectile
(dir-locals-set-class-variables
 'gnome-code
 '((nil . ((eval . (progn
                     (puthash (projectile-project-root)
                              "jhbuild make"
                              projectile-compilation-cmd-map)
                     (puthash (projectile-project-root)
                              "make check"
                              projectile-test-cmd-map)
                     ))))))

;; Change this path to your jhbuild checkoutroot
(dir-locals-set-directory-class "~/Code/gnome/" 'gnome-code)

(provide 'init)
;;; init.el ends here

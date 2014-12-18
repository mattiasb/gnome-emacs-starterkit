;;; custom.el --- My custom settings
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-auto-complete t)
 '(company-tooltip-align-annotations t)
 '(company-backends
   '(company-elisp company-nxml company-css company-eclim company-semantic company-rtags company-clang company-xcode company-ropemacs company-cmake
                   (company-gtags company-etags company-dabbrev-code company-keywords)
                   company-oddmuse company-files company-dabbrev company-yasnippet))
 '(compilation-scroll-output t)
 '(custom-buffer-done-kill t)
 '(delete-selection-mode t)
 '(electric-indent-mode t)
 '(electric-layout-mode t)
 '(electric-pair-mode t)
 '(gc-cons-threshold 20000000)
 '(global-company-mode t)
 '(inhibit-startup-screen t)
 '(ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
 '(js2-allow-keywords-as-property-names t)
 '(js2-basic-offset 4)
 '(js2-cleanup-whitespace t)
 '(js2-concat-multiline-strings t)
 '(js2-global-externs
   '("imports" "process" "setTimeout" "clearTimeout" "log"))
 '(js2-mirror-mode t)
 '(js2-skip-preprocessor-directives t)
 '(nxml-auto-insert-xml-declaration-flag t)
 '(nxml-slash-auto-complete-flag t)
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")))
 '(rng-schema-locating-files
   '("~/.emacs.d/schemas.xml" "/usr/share/emacs/24.3/etc/schema/schemas.xml" "schemas.xml"))
 '(rtags-autostart-diagnostics t)
 '(rtags-completions-enabled t)
 '(safe-local-variable-values
   '((eval progn
           (puthash
            (projectile-project-root)
            "jhbuild make" projectile-compilation-cmd-map)
           (puthash
            (projectile-project-root)
            "make check" projectile-test-cmd-map))))
 '(show-paren-mode t)
 '(tab-width 8)
 '(yas-also-auto-indent-first-line t)
 '(yas-trigger-key nil)
 '(yas-triggers-in-field t)
 '(yas-wrap-around-region t)
 '(yas-snippet-dirs '("~/.emacs.d/snippets"))
 )

(provide 'custom)
;;; custom.el ends here

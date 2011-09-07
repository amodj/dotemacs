;; User details

(setq user-full-name "Chinmay Kamat")
(setq user-mail-address "chinmaykamat@gmail.com")

;;Emacs load path
(let* ((my-lisp-dir "~/.emacs.d/")
       (default-directory my-lisp-dir)
       (orig-load-path load-path))
  (setq load-path (cons my-lisp-dir nil))
  (normal-top-level-add-subdirs-to-load-path)
  (nconc load-path orig-load-path))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1)) ;; no scroll-bar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1)) ;; no tool-bar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1)) ;; no menu-bar
;;use y-or-n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(global-font-lock-mode 1) ;; Colours
(show-paren-mode 1) ;;Show paren matching 
(setq inhibit-startup-screen 1)
(delete-selection-mode 1);;copy overwrite selected
(setq-default ispell-program-name "aspell");;spell checker
(setq require-final-newline t)
;; (setq debug-on-error t)
(setq visible-bell t)
(setq doc-view-continuous t)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;Emacs back up settings
(push '("." . "~/.emacs.d/.emacs-backups/") backup-directory-alist)
(setq version-control t
      kept-new-versions 15
      kept-old-versions 5
      delete-old-versions t
      backup-by-copying-when-linked t
      vc-make-backup-files t);;Make backup even if under version control
(add-hook 'before-save-hook  'force-backup-of-buffer)

;;Custom keybindings
(require 'misc-bindings)

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/cache/saveplace")

;;Custom functions and key bindings
(require 'utility-functions)

;;Org mode 
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;;settings for shell
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq comint-prompt-read-only t)
 
;;settings for yasnippet
(require 'yasnippet) ;; not yasnippet-bundle
(global-set-key (kbd "S-TAB") 'yas/trigger-key)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")

;;Cscope
(require 'cs-bindings)

;;Elisp mode
(require 'emacs-lisp-mode-config)

;;Ido mode
(require 'ido)
(require 'ido-mode-config)

;;Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; Color theme
(require 'color-theme-wombat)
(require 'folio)
(color-theme-wombat)
(add-hook 'after-make-frame-functions 'color-theme-wombat)

;; PKGBUILD mode
(autoload 'pkgbuild-mode "pkgbuild-mode.el" "PKGBUILD mode." t)
(setq auto-mode-alist (append '(("/PKGBUILD$" . pkgbuild-mode))
			       auto-mode-alist))

(require 'server)
;; (setq server-use-tcp t)
;; (setq server-host "serenity")
;; ;; Suppress error "directory
;; ;; ~/.emacs.d/server is unsafe"
;; (when (= emacs-major-version 23)
;;   (defun server-ensure-safe-dir (dir) "Noop" t))
;; (setq server-socket-dir "~/.emacs.d/")

(icomplete-mode)
(eval-after-load "icomplete" '(progn (require 'icomplete+)))

(require 'latex-mode-config)


;; Auto-complete mode
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/ac-dict")
(ac-config-default)
(setq ac-auto-start 3)
(setq ac-auto-show-menu 0.8)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

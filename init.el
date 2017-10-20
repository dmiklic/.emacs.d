(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((cmake-tab-width . 4)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; My customizations

;; This is used for starting the initial instance of emacs,
;; all subsequent files are opened within this instance
;; (or something like that :)
(server-start)

;; Customize font size
(set-face-attribute 'default nil :height 110)

;; Customize startup
(setq inhibit-startup-screen t)    ;; Don't show help menu on startup
(setq initial-scratch-message "")  ;; Don't show a message in the scrach buffer
(setq initial-major-mode 'text-mode) ;; Start in text mode
;(load-theme 'tango t)                ;; Load color theme
(load-theme 'adwaita)

;; Customize window size
;; The set-frame-size seems to be working right
;; Not sure about set-frame-position
(if (window-system)
  (set-frame-size (selected-frame) 100 55)
  (set-frame-position (selected-frame) 100 50))

;; Reopen buffers on startup
(desktop-save-mode 1)

;; Replace each tab by 4 spaces
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)))

;; Get a list of recently opened files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Enable package managers
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; Customize major modes
(global-linum-mode t)    ;; Show line numbers in all modes
(add-hook 'text-mode-hook 'turn-on-auto-fill) ;; Automatically wrap lines in text mode

;; Customize operations with LaTeX files
(setq TeX-PDF-mode t) ;; compile with pdfLaTeX

;; Set up stuff for Python development
(require 'python)
(setq
  python-shell-interpreter "ipython"
  python-shell-interpreter-args "--pylab"
  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
  python-shell-completion-setup-code
    "from IPython.core.completerlib import module_completion"
  python-shell-completion-module-string-code
    "';'.join(module_completion('''%s'''))\n"
  python-shell-completion-string-code
    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")
;;(require 'ipython)
;;(setq py-python-command-args '("--matplotlib" "--colors" "LightBG"))
;; My binding for running the python interpreter
(global-set-key (kbd "C-c !") 'run-python)

;; Load Octave mode for .m files
(setq auto-mode-alist
      (cons
       '("\\.m$" . octave-mode)
       auto-mode-alist))

;; Load xml mode for .launch files
(setq auto-mode-alist
      (cons
       '("\\.launch$" . nxml-mode)
       auto-mode-alist))

;; Set up stuff for C++ development
;; Mostly taken from http://wiki.ros.org/EditorHelp#Emacs
(setq c-default-style '((c++-mode . "stroustrup")))
(setq c-basic-offset 2)
(setq indent-tabs-mode nil)
(c-set-offset 'substatement-open 0)
(c-set-offset 'innamespace 0)
(c-set-offset 'case-label '+)
(c-set-offset 'statement-case-open 0)
(c-set-offset 'defun-block-intro 2)

;; In order to get namespace indentation correct, .h files must be opened in C++ mode
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))

;; All packages installed through package.el should be activated after
;; this section !!!

(setq package-enable-at-startup nil)
(package-initialize)

;; Major mode for editing Google .proto files
(require 'protobuf-mode)

;; Activate the neotree plugin and bind it to F8
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; Configure the dumb-jump package
;; It's useful for switching between definition/declaration etc.
;; More info: https://github.com/jacktasia/dumb-jump
(use-package dumb-jump
             :bind (("M-g o" . dumb-jump-go-other-window)
                    ("M-g j" . dumb-jump-go)
                    ("M-g b" . dumb-jump-back)
                    ("M-g q" . dumb-jump-quick-look))
             :config (setq dumb-jump-selector 'ivy)
             :ensure)

;; Should be at the end of init.el according to workgroups2 manual
;; Load workgroups package for improved management of windows
(require 'workgroups2)
(setq wg-prefix-key (kbd "C-c w")
      wg-session-file "~/.emacs.d/.emacs_workgroups")

;; Should be at the very end of init.el (?)
(workgroups-mode 1)

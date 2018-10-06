;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'default-frame-alist '(height . 90))
(add-to-list 'default-frame-alist '(width . 150))
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)

(add-to-list 'load-path "~/.emacs.d/perso/")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/local/bin/sbcl")
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))
(setq-default TeX-master "master")

(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/"))
(setq exec-path (append exec-path '(":/usr/local/bin/")))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(ansi-color-faces-vector
     [default default default italic underline success warning error])
  '(ansi-color-names-vector
     ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
  '(custom-enabled-themes (quote (adwaita)))
  '(global-linum-mode t)
  '(linum-format "%4d ")
  '(menu-bar-mode nil)
  '(package-archives
     (quote
       (("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/"))))
  '(package-selected-packages (quote (auctex ##)))
  '(safe-local-variable-values (quote ((TeX-command-extra-options . "-shell-escape")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  )

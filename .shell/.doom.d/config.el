
(add-to-list 'load-path "~/.doom.d")

(load "paths.el")


(xterm-mouse-mode 1)
;; (setq treemacs-width 20)
;; (treemacs)

(setq confirm-kill-emacs nil)

(defun al () (interactive) (find-file "~/.doom.d/config.el"))

(defun ev () (interactive) (eval-buffer))

(defun bu () (interactive) (find-file "~/.deps/build_tools/Build.py"))

(defun map-key (key func)
  (global-set-key (kbd key) func))

(map-key "M-<right>"   'windmove-right)
(map-key "M-<left>"    'windmove-left)


(setq user-full-name "Vladas Zakrevskis"
      user-mail-address "146100@gmail.com")

(setq doom-theme 'doom-one)
(setq org-directory "~/org/")
(setq display-line-numbers-type t)


(defalias 'ta   'treemacs-add-project-to-workspace)
(defalias 'tr   'treemacs-remove-project-from-workspace)
(defalias 'trn  'treemacs-rename)


(setq scroll-lines-count 4)

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!

;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Tom Passarelli"
      user-mail-address "tom.passarelli@protonmail.com")

; -------- FONT --------
(setq
  doom-font (font-spec :family "Hack" :size 16)
  doom-big-font (font-spec :family "Hack" :size 22)
  doom-variable-pitch-font (font-spec :family "Hack" :size 14))
;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; -------- THEME --------
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-vibrant)


;;; -- DEVELOPMENT CONFIG GLOBAL --
(setq projectile-project-search-path '("~/code/"))

;;(after! yasnippet
;;  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))

;; Treemacs (open file on specific window, etc_
(map! :after treemacs
      :map treemacs-mode-map
      "S-RET" #'treemacs-visit-node-ace)

;; ---------- LSP --------------
;(after! lsp-ui
; (setq lsp-ui-doc-mode t
;       lsp-ui-doc-enable t
;       lsp-ui-doc-max-width 180
;       lsp-ui-doc-max-height 60
;       lsp-ui-sideline-show-symbol t
;        lsp-ui-doc-use-childframe t))

;;; --------------------------------

;; ------- Javascript -------
(setq js-indent-level 2
      js2-basic-offset 2)

;; ------- Angular ----------
;; angular-language-server
(after! lsp-mode
  (setq lsp-clients-angular-language-server-command
  '("node"
    "/usr/local/lib/node_modules/@angular/language-server"
    "--ngProbeLocations"
    "/usr/local/lib/node_modules"
    "--tsProbeLocations"
    "/usr/local/lib/node_modules"
    "--stdio")))


;; ng-2 mode
;;(use-package! ng2-mode
;;  :defer t)
;;(with-eval-after-load 'typescript-mode
;;  (add-hook 'typescript-mode-hook #'lsp))

;; -------- Python -----------
;(after! lsp-python-ms
;  :ensure t
;  :hook (python-mode . (lambda ()
;                          (require 'lsp-python-ms)
;                          (lsp))))  ; or lsp-deferred

;;-------- ORG MODE -------------
;;(use-package org-fancy-priorities
;;  :hook
;;  (org-mode . org-fancy-priorities-mode)
;;  :config
;;  (setq org-fancy-priorities-list '("■" "■" "■")))
;;
;;

(use-package org
  :init (setq org-directory "~/org/")
  )

(after! org
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background nil)
  (set-face-attribute 'org-code nil
                      :foreground "#a9a1e1"
                      :background nil)
  (set-face-attribute 'org-date nil
                      :foreground "#5B6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      :foreground "steelblue2"
                      :background nil
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      :foreground "slategray2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :foreground "SkyBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :foreground "DodgerBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :foreground "SlateGray1"
                      :background nil
                      :height 1.75
                      :weight 'bold)
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)
  (setq org-agenda-skip-scheduled-if-done t
        org-agenda-files (directory-files-recursively "~/org/" "\\.org$")
        ;;org-default-notes-file (concat org-directory "/driver/inbox.org")
        org-capture-templates
         '(("t" "fun" entry (file+headline "~/org/driver/inbox.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
           ("j" "Journal" entry (file+datetree "~/org/driver/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a"))
        org-bullets-bullet-list '("⁖")
        org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)"))
        org-todo-keyword-faces
        '(("TODO"       :foreground "#7c7c78" :weight normal :underline t)
          ("WAITING"    :foreground "#9f7efe" :weight normal :underline t)
          ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
          ("DONE"       :foreground "#50a14f" :weight normal :underline t)
          ("CANCELLED"  :foreground "#ff6480" :weight normal :underline t))
        org-priority-faces '((?A :foreground "#e45649")
                             (?B :foreground "#da8548")
                             (?C :foreground "#0098dd"))
        ))

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

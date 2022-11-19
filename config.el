;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Tom Passarelli"
      user-mail-address "tom.passarelli@protonmail.com")

; -------- Font and Spacing --------

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq
  doom-font (font-spec :family "Hack" :size 18)
  doom-big-font (font-spec :family "Hack" :size 22)
  doom-variable-pitch-font (font-spec :family "Hack" :size 16))

(setq doom-theme 'doom-solarized-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;;; -- DEVELOPMENT CONFIG GLOBAL --
(setq projectile-project-search-path '("~/code/"))

;;(after! yasnippet
;;  (push (expand-file-name "snippets/" doom-private-dir) yas-snippet-dirs))

;; Treemacs
(map! :after treemacs
      :map treemacs-mode-map
      "S-RET" #'treemacs-visit-node-ace)

;; ---------- LSP --------------

;; UI
;(after! lsp-ui
; (setq lsp-ui-doc-mode t
;       lsp-ui-doc-enable t
;       lsp-ui-doc-max-width 180
;       lsp-ui-doc-max-height 60
;       lsp-ui-sideline-show-symbol t
;        lsp-ui-doc-use-childframe t))


;; ------- Javascript -------

(setq js-indent-level 2
      js2-basic-offset 2)

;;; ------- Angular --------------

;;; angular-language-server
;; (after! lsp-mode
;;   (setq lsp-clients-angular-language-server-command
;;   '("node"
;;     "/usr/local/lib/node_modules/@angular/language-server"
;;     "--ngProbeLocations"
;;     "/usr/local/lib/node_modules"
;;     "--tsProbeLocations"
;;     "/usr/local/lib/node_modules"
;;     "--stdio")))

;; -------- Python  -------------

;(after! lsp-python-ms
;  :ensure t
;  :hook (python-mode . (lambda ()
;                          (require 'lsp-python-ms)
;                          (lsp))))  ; or lsp-deferred


;;-------- ORG MODE -------------

(add-to-list 'doom-large-file-excluded-modes 'org-mode)
;; (add-to-list 'exec-path "~/sqlite/sqlite3")
(use-package org
  :init
  (setq org-directory "~/Nextcloud/org")
  (setq org-roam-directory "~/Nextcloud/org/notes"))
(after! org
  (setq visual-fill-column-mode t
        visual-line-mode t)
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)
  (custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.3))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
  )
  (setq org-log-done '(time)
        org-hide-emphasis-markers '(t)
        org-use-tag-inheritance '(nil)
        ;;org-bullets-bullet-list '("⁖")
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "INPROGRESS(i)" "WAITING(w)" "HOLD(h)"  "|" "DONE(d)" "PASS(p)" "SOMEDAY-MAYBE(s)")
                            (sequence "[ ](T)" "[N](N)" "[-](I)" "[~](W)" "[H](H)"  "|" "[X](D)" "[P](P)" "[S]S"))
        org-todo-keyword-faces
        '(("TODO"       :foreground "#7c7c78" :weight normal :underline t)
          ("WAITING"    :foreground "#9f7efe" :weight normal :underline t)
          ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
          ("HOLD"       :foreground "#80808A" :weight normal :underline t)
          ("DONE"       :foreground "#50a14f" :weight normal :underline t)
          ("MISS"       :foreground "#ff6480" :weight normal :underline t)
          ("[-]"  . +org-todo-active)
          ("INPROGRESS" . +org-todo-active)
          ("[?]"  . +org-todo-onhold)
          ("UNDECIDED"  . +org-todo-onhold)
          ("WAITING" . +org-todo-onhold))
          org-priority-faces '((?A :foreground "#e45649")
                               (?B :foreground "#da8548")
                               (?C :foreground "#0098dd")))

;; https://old.reddit.com/r/emacs/comments/hnf3cw/my_orgmode_agenda_much_better_now_with_category/
 (use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-agenda-files (list org-roam-directory)
        ;;(see above for replacement) org-agenda-files (directory-files-recursively "~/org/" "\\.org$")
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        ;;org-agenda-skip-scheduled-if-done t
        org-agenda-todo-ignore-scheduled 'future
        org-agenda-tags-todo-honor-ignore-options t
        org-agenda-start-day "1d"
        org-agenda-span '7
        org-agenda-start-on-weekday 1
        org-super-agenda-groups '((:name "Today"  ; Optionally specify section name
                                         :time-grid t  ; Items that appear on the time grid
                                         :scheduled today ; Items that have this TODO keyword
                                  )
                                  (:name "Important"
                                         ;; Single arguments given alone
                                         :tag "bills"
                                         :priority "A")
                                  (:name "TODO AND scheduled in the past"
                                         :todo t
                                         :scheduled past
                                  )
                                  ;; (:name "Not Done"
                                  ;;        :todo t
                                  ;;        :scheduled past
                                  ;; )
                                  ;; (:name "Week"
                                  ;;        :todo t
                                  ;;        :scheduled past
                                  ;; )
                                  ;; Set order of multiple groups at once
                                  (:order-multi (2 (:name "Shopping in town" ;; Boolean AND group matches items that match all subgroups
                                                          :and (:tag "shopping" :tag "@town"))
                                                   (:name "Food-related" ;; Multiple args given in list with implicit OR
                                                          :tag ("food" "dinner"))
                                                   (:name "Personal"
                                                          :habit t
                                                          :tag "personal")
                                                   (:name "Space-related (non-moon-or-planet-related)"
                                                          ;; Regexps match case-insensitively on the entire entry
                                                          :and (:regexp ("space" "NASA")
                                                                        ;; Boolean NOT also has implicit OR between selectors
                                                                        :not (:regexp "moon" :tag "planet")))))
                                  ;; Groups supply their own section names when none are given
                                  (:todo "WAITING" :order 8)  ; Set order of this section
                                  (:todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
                                         ;; Show this group at the end of the agenda (since it has the
                                         ;; highest number). If you specified this group last, items
                                         ;; with these todo keywords that e.g. have priority A would be
                                         ;; displayed in that group instead, because items are grouped
                                         ;; out in the order the groups are listed.
                                         :order 9)
                                  (:priority<= "B"
                                               ;; Show this section after "Today" and "Important", because
                                               ;; their order is unspecified, defaulting to 0. Sections
                                               ;; are displayed lowest-number-first.
                                               :order 1)
                                  ;; After the last group, the agenda will display items that didn't
                                  ;; match any of these groups, with the default order position of 99
                                  ))
                                  (org-agenda nil "a"))
        :config
        (org-super-agenda-mode))


;; -- REFERENCE --
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

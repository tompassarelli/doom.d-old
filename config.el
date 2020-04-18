;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!

;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Tom Passarelli"
      user-mail-address "tom.passarelli@protonmail.com")

; -------- Font and Spacing --------
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

;;; -- Slack --

;; config.el
;; (use-package slack
;;   :commands slack-start
;;   :init
;;   (setq slack-buffer-emojify t) ;; if you want to enable emoji, default nil
;;   (setq slack-prefer-current-team t)
;;   :config
;;   (slack-register-team
;;    :name "emacs-slack"
;;    :default t
;;    :token "TODO pull from authsource"
;;    :subscribed-channels '(test-rename rrrrr)
;;    :full-and-display-names t)

;;   (slack-register-team
;;    :name "test"
;;    :token "TODO pull from authsource"
;;    :subscribed-channels '(rtc))

;;   (map! (:map slack-info-mode-map
;;           "u" #'slack-room-update-messages)
;;         (:map slack-mode-map
;;           "C-n" 'slack-buffer-goto-next-message
;;           "C-p" 'slack-buffer-goto-prev-message)
;;         (:localleader
;;           (:map slack-mode-map
;;             "c" 'slack-buffer-kill
;;             "ra" 'slack-message-add-reaction
;;             "rr" 'slack-message-remove-reaction
;;             "rs" 'slack-message-show-reaction-users
;;             "pl" 'slack-room-pins-list
;;             "pa" 'slack-message-pins-add
;;             "pr" 'slack-message-pins-remove
;;             "mm" 'slack-message-write-another-buffer
;;             "me" 'slack-message-edit
;;             "md" 'slack-message-delete
;;             "u" 'slack-room-update-messages
;;             "2" 'slack-message-embed-mention
;;             "3" 'slack-message-embed-channel)
;;           (:map slack-edit-message-mode-map
;;             "k" 'slack-message-cancel-edit
;;             "s" 'slack-message-send-from-buffer
;;             "2" 'slack-message-embed-mention
;;             "3" 'slack-message-embed-channel))))

;; (use-package alert
;;   :commands alert
;;   :init (setq alert-default-style 'notifier))

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

;; ------- Angular - To appease the google overlords ----------
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


;; ng-2 mode - no longer needed with lsp
;;(use-package! ng2-mode
;;  :defer t)
;;(with-eval-after-load 'typescript-mode
;;  (add-hook 'typescript-mode-hook #'lsp))

;; -------- Python - for when the unix commands aren't quite stronk enough -----------
;(after! lsp-python-ms
;  :ensure t
;  :hook (python-mode . (lambda ()
;                          (require 'lsp-python-ms)
;                          (lsp))))  ; or lsp-deferred

;;-------- ORG MODE -------------
;;
;; (use-package org-fancy-priorities
;;   :hook
;;   (org-mode . org-fancy-priorities-mode)
;;   :config
;;   (setq org-fancy-priorities-list '("■" "■" "■")))
;;
;;
;;(setq +org-capture-todo-file "driver/todo.org")
;;(setq +org-capture-changelog-file "driver/changelog.org")
;;(setq +org-capture-notes-file "driver/capture.org")
;;(setq +org-capture-journal-file "driver/journal.org")
;;(setq +org-capture-projects-file "driver/projects.org")

(use-package org
  :init
  (setq org-directory "~/org/"))

(after! org
  (setq org-log-done 'time)
  ;; (setq org-super-agenda-mode t)
  ;; (setq ((org-super-agenda-groups
  ;;      '(;; Each group has an implicit boolean OR operator between its selectors.
  ;;        (:name "Today"  ; Optionally specify section name
  ;;               :time-grid t  ; Items that appear on the time grid
  ;;               :todo "TODAY")  ; Items that have this TODO keyword
  ;;        (:name "Important"
  ;;               ;; Single arguments given alone
  ;;               :tag "bills"
  ;;               :priority "A")
  ;;        ;; Set order of multiple groups at once
  ;;        (:order-multi (2 (:name "Shopping in town"
  ;;                                ;; Boolean AND group matches items that match all subgroups
  ;;                                :and (:tag "shopping" :tag "@town"))
  ;;                         (:name "Food-related"
  ;;                                ;; Multiple args given in list with implicit OR
  ;;                                :tag ("food" "dinner"))
  ;;                         (:name "Personal"
  ;;                                :habit t
  ;;                                :tag "personal")
  ;;                         (:name "Space-related (non-moon-or-planet-related)"
  ;;                                ;; Regexps match case-insensitively on the entire entry
  ;;                                :and (:regexp ("space" "NASA")
  ;;                                              ;; Boolean NOT also has implicit OR between selectors
  ;;                                              :not (:regexp "moon" :tag "planet")))))
  ;;        ;; Groups supply their own section names when none are given
  ;;        (:todo "WAITING" :order 8)  ; Set order of this section
  ;;        (:todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
  ;;               ;; Show this group at the end of the agenda (since it has the
  ;;               ;; highest number). If you specified this group last, items
  ;;               ;; with these todo keywords that e.g. have priority A would be
  ;;               ;; displayed in that group instead, because items are grouped
  ;;               ;; out in the order the groups are listed.
  ;;               :order 9)
  ;;        (:priority<= "B"
  ;;                     ;; Show this section after "Today" and "Important", because
  ;;                     ;; their order is unspecified, defaulting to 0. Sections
  ;;                     ;; are displayed lowest-number-first.
  ;;                     :order 1)
  ;;        ;; After the last group, the agenda will display items that didn't
  ;;        ;; match any of these groups, with the default order position of 99
  ;;        )))
  ;; (org-agenda nil "a"))

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
        org-tags-exclude-from-inheritance '("c1_3")
        ;;org-agenda-files (directory-files-recursively "~/org/" "\\.org$")
        org-agenda-files (list org-directory)
        org-bullets-bullet-list '("⁖")
        org-todo-keywords '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)" "FAILED(f)"))
        org-todo-keyword-faces
        '(("TODO"       :foreground "#7c7c78" :weight normal :underline t)
          ("WAITING"    :foreground "#9f7efe" :weight normal :underline t)
          ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
          ("DONE"       :foreground "#50a14f" :weight normal :underline t)
          ("CANCELLED"  :foreground "#80808A" :weight normal :underline t)
          ("FAILED"     :foreground "#ff6480" :weight normal :underline t))
        org-priority-faces '((?A :foreground "#e45649")
                             (?B :foreground "#da8548")
                             (?C :foreground "#0098dd")))
  )


;; -- REFERENCE --
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

;;; halext-dashboard.el --- Dashboard for Emacs

;;; Commentary:

;; This layer provides a custom dashboard with higher density information,
;; including recent files, projects, bookmarks, and more.

;;; Code:

;; (defconst halext-dashboard-packages
;;   '((dashboard :location (recipe
;;                           :fetcher github
;;                           :repo "emacs-dashboard/emacs-dashboard")))
;;   "List of packages required by the halext-dashboard layer.")

(require 'all-the-icons)

(defun halext-dashboard/init-dashboard ()
  (interactive)
  (use-package dashboard
    :init
    (progn
      (setq dashboard-buffer-name "*Halext Dashboard*")
      (setq dashboard-startup-banner "~/Pictures/halext.png")
      (setq dashboard-banner-logo-title "Welcome to Halext.org Labs")
      (setq dashboard-projects-backend 'projectile)
      (setq dashboard-set-navigator t)
      (setq dashboard-icon-type 'all-the-icons)
      (setq dashboard-set-heading-icons t)
      (setq dashboard-set-file-icons t)
      (setq dashboard-center-content t)
      (setq dashboard-items '((agenda    . 5)
                              (recents   . 5)
                              (projects  . 5)
                              (bookmarks . 5)
                              (registers . 5)))

      (setq dashboard-item-shortcuts '((agenda    . "a")
                                       (recents   . "r")
                                       (projects  . "p")
                                       (bookmarks . "m")
                                       (registers . "x")))

      (setq dashboard-navigator-buttons `((("🏠"
                                            "halext.org"
                                            "Browse Halext Homepage"
                                            (lambda (&rest _) (browse-url "https://halext.org")))
                                           (
                                            ,(all-the-icons-octicon "mark-github" :height 1.0 :v-adjust 0.0)
                                            "github"
                                            "Browse scawful Github"
                                            (lambda (&rest _) (browse-url "https://github.com/scawful"))))))

      (setq dashboard-startupify-list '(dashboard-insert-newline
                                        dashboard-insert-banner-title
                                        dashboard-insert-newline
                                        dashboard-insert-navigator
                                        dashboard-insert-newline
                                        dashboard-insert-init-info
                                        dashboard-insert-items
                                        dashboard-insert-newline
                                        dashboard-insert-banner
                                        dashboard-insert-newline
                                        dashboard-insert-footer))
      (setq initial-buffer-choice t))
    :config
    (progn
      (dashboard-setup-startup-hook)
      (define-derived-mode halext-dashboard-mode special-mode "Halext-Dashboard"
        "Major mode for Halext Dashboard."
        (read-only-mode 1)
      )
      (spacemacs/set-leader-keys "o d" 'halext-dashboard/open))))

(defun halext-dashboard/open ()
  "Open the Halext Dashboard buffer."
  (interactive)
  (with-current-buffer (get-buffer-create "*Halext Dashboard*")
    (halext-dashboard-mode)
  (switch-to-buffer "*Halext Dashboard*")))

(provide 'halext-dashboard)

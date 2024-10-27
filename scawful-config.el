; scawful-config.el --- scawful emacs config

(load-file "/Users/scawful/Code/lisp/emacs/halext-dashboard.el")

(defun halext-ssh ()
  (interactive)
  (dired "/ssh:justin@144.202.52.126:/"))

(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(defun copilot-init ()
  "Initialize copilot.el"
  (require 'cl)
  (let ((pkg-list '(use-package
		                 s
		                 dash
		                 editorconfig
                     company)))
    (package-initialize)
    (when-let ((to-install (map-filter (lambda (pkg _) (not (package-installed-p pkg))) pkg-list)))
      (package-refresh-contents)
      (mapc (lambda (pkg) (package-install pkg)) pkg-list)))
  (load-file "/Users/scawful/Code/lisp/emacs/copilot.el/copilot-balancer.el")
  (load-file "/Users/scawful/Code/lisp/emacs/copilot.el/copilot.el")
  (require 'copilot)

  (add-to-list 'copilot-indentation-alist '(zAsar-mode 2))
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2))

  (global-set-key (kbd "s-i") 'copilot-mode)
  (define-key copilot-mode-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-mode-map (kbd "M-<tab>") 'copilot-next-completion)
  (define-key copilot-mode-map (kbd "M-S-<tab>") 'copilot-previous-completion))

(defun zelda-init ()
  (require 'rom-hacking)
  (require 'zAsar-mode)
  (add-to-list 'auto-mode-alist '("\\.asm\\'" . zAsar-mode))
  (add-to-list 'auto-mode-alist '("\\.s\\'" . zAsar-mode))
  (add-to-list 'auto-mode-alist '("\\.inc\\'" . zAsar-mode))
  (spacemacs/declare-prefix "oz" "zelda3")
  (evil-leader/set-key "ozp" 'asar-patch-rom)
  (evil-leader/set-key "ozo" 'asar-patch-oracle)
  (evil-leader/set-key "ozz" 'z3ed)
  (evil-leader/set-key "ozy" 'yaze)
  (add-hook 'zAsar-mode-hook (lambda () (setq olivetti-body-width 65))))

(defun run-config ()
  (global-visual-line-mode t)
  (setq cmake-ide-header-search-other-file nil)
  (setq cmake-ide-header-search-first-including nil)
  (setq lsp-enable-semantic-highlighting nil)

  (remove-hook 'helm-mode-hook 'helm-descbinds-mode)
  (add-hook 'dashboard-mode-hook (lambda () (olivetti-mode)))
  (add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode 1)))
  (add-hook 'dired-mode-hook (lambda () (olivetti-mode)))
  (add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
  (add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)
  (add-hook 'focus-out-hook 'garbage-collect)
  (add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))


  (setq-default olivetti-body-width 80)
  (add-hook 'dired-mode (lambda () (setq olivetti-body-width 100)))
  (spacemacs/set-leader-keys "wc" 'olivetti-mode)

  (evil-leader/set-key "oH" 'halext-ssh)
  (evil-leader/set-key "oi" 'imenu-list-minor-mode)
  (evil-leader/set-key "of" 'lsp-format-buffer)
  (evil-leader/set-key "oc" 'cmake-ide-compile)

  (spacemacs/declare-prefix "or" "replace")
  (evil-leader/set-key "ors" 'replace-string)
  (evil-leader/set-key "orx" 'replace-regexp)

  (spacemacs/declare-prefix "oh" "hide/show")
  (evil-leader/set-key "ohh" 'hs-hide-block)
  (evil-leader/set-key "ohs" 'hs-show-block)
  (evil-leader/set-key "ohc" 'hs-hide-level)
  (evil-leader/set-key "ohr" 'hs-hide-all)

  (spacemacs/declare-prefix "os" "spotify")
  (evil-leader/set-key "osg" 'helm-spotify-plus)
  (evil-leader/set-key "osn" 'spotify-next)
  (evil-leader/set-key "osp" 'spotify-previous)
  (evil-leader/set-key "oss" 'spotify-playpause)

  (which-key-remove-default-unicode-chars)
  (when (member "Symbola" (font-family-list))
    (set-fontset-font t 'unicode "Symbola" nil 'prepend))

  (zelda-init)

  (use-package all-the-icons-dired)
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

  (use-package ivy-rich
    :ensure t
    :init (ivy-rich-mode 1))

  (use-package all-the-icons-ivy-rich
    :ensure t
    :init (all-the-icons-ivy-rich-mode 1))

  (use-package all-the-icons-ibuffer)
  (add-hook 'ibuffer-mode-hook 'all-the-icons-ibuffer-mode)

  (require 'halext-dashboard)
  (halext-dashboard/init-dashboard)
  (add-hook 'dashboard-mode-hook (lambda () (setq olivetti-body-width 80)))

  (require 'gptel)
  (spacemacs/declare-prefix "og" "gptel")
  (evil-leader/set-key "ogg" 'gptel-menu)
  (evil-leader/set-key "oga" 'gptel-add)
  (evil-leader/set-key "ogc" 'gptel)

  ; Open 'scawful-config' in a new buffer
  (evil-leader/set-key "fes" (lambda () (interactive) (find-file "~/Code/lisp/emacs/scawful-config.el")))

  (copilot-init)

  (global-set-key (kbd "<backtab>") 'evil-shift-left-line)
)

(provide 'scawful-config)

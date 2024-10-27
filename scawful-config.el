; scawful-config.el --- scawful emacs config


(load-file "/Users/scawful/Code/lisp/emacs/halext-dashboard.el")

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

  (require 'rom-hacking)
  (require 'zAsar-mode)
  (add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))
  (add-to-list 'auto-mode-alist '("\\.asm\\'" . zAsar-mode))
  (add-to-list 'auto-mode-alist '("\\.s\\'" . zAsar-mode))
  (add-to-list 'auto-mode-alist '("\\.inc\\'" . zAsar-mode))
  (require 'gptel)

  (global-set-key (kbd "<backtab>") 'evil-shift-left-line)

  (setq-default olivetti-body-width 80)
  (add-hook 'zAsar-mode-hook (lambda () (setq olivetti-body-width 65)))
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

  (spacemacs/declare-prefix "oz" "zelda3")
  (evil-leader/set-key "ozp" 'asar-patch-rom)
  (evil-leader/set-key "ozo" 'asar-patch-oracle)
  (evil-leader/set-key "ozz" 'z3ed)
  (evil-leader/set-key "ozy" 'yaze)
  (which-key-remove-default-unicode-chars)
  (when (member "Symbola" (font-family-list))
    (set-fontset-font t 'unicode "Symbola" nil 'prepend))

  (require 'halext-dashboard)
  (halext-dashboard/init-dashboard)
)

(defun halext-ssh ()
  (interactive)
  (dired "/ssh:justin@144.202.52.126:/"))

(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(provide 'scawful-config)

(require 'lsp-mode)

(require 'company-lsp)
(push 'company-lsp company-backends)

(require 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
;; Hover over symbols would show doc
(setq lsp-ui-doc-enable nil)

(provide 'setup-lsp)

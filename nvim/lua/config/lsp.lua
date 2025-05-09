local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)       -- Go to definition
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)             -- Hover info
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)   -- Rename symbol
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts) -- Code actions
end

lspconfig.pyright.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

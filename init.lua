--Este es el primer archivo que carga el nvim. Indica los plugins que se "requeriran" del directorio nvim/lua
--Le puedo tirar require a cualquier cosa que este en /lua. Si tuviera subdirectorios en lua podria hacer "lua/dir"
require('remap')
require('plugins')
require('set')

-- NVIMTREE CONFIG disable netrw at the very start of your init.lua (recomendacion NVIM-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- LSP Zero configs
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-->>Config de mason y masonLspConfig
--It's important that you set up the plugins in the following order:
--mason.nvim
--mason-lspconfig.nvim
--Setup servers via lspconfig

require("mason").setup()

require("mason-lspconfig").setup()



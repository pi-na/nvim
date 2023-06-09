--Este es el primer archivo que carga el nvim. Indica los plugins que se "requeriran" del directorio nvim/lua
--Le puedo tirar require a cualquier cosa que este en /lua. Si tuviera subdirectorios en lua podria hacer "lua/dir"
require('remap')
require('plugins')
require('set')

-- NVIMTREE CONFIG disable netrw at the very start of your init.lua (recomendacion NVIM-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

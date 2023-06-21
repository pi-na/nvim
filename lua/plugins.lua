--En este archivo se configuran los plugins que se van a utilizar en neovim
--Se utiliza el plugin packer para la instalacion de los plugins

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

--La funcion que carga los plugins. Notar que el startup
--se deja abierto y no se cierra hasta el final.
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

-->>LSP Zero
--(configuracion de lsp)
use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {                                      -- Optional
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  }
}

-->>Mason (LSP Install manager)
use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
}

-->>Mason lsp config
--(amiga a mason con lspConfig)
use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
}

-->>auto-save
use({
	"Pocco81/auto-save.nvim",
	config = function()
		 require("auto-save").setup {
			-- your config goes here
			-- or just leave it empty :)
		 }
	end,
})

-->>Find files
--telescope
use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

--color.scheme
use({ 'rose-pine/neovim', as = 'rose-pine' })
vim.cmd('colorscheme rose-pine')

-->>Github copilot
use { 'github/copilot.vim' }

-->>tree-sitter 
--(colorcitos pero no me anda)
use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

-->>bar bar
--Barra de tabs!
-- These optional plugins should be loaded directly because of a bug in Packer lazy loading
use 'nvim-tree/nvim-web-devicons' -- OPTIONAL: for file icons
use 'lewis6991/gitsigns.nvim' -- OPTIONAL: for git status
use 'romgrk/barbar.nvim'

-->>nvim-tree
--(file explorer en la sidebar)
use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require("nvim-tree").setup {}
  end
}

end)


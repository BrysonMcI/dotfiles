--- the basics
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--- lazy package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_plugins = {
  'tpope/vim-fugitive', -- Git
  'tpope/vim-sleuth', -- tabstop/shiftwidth detection
  {
    --- LSP
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} }, -- LSP status updates
      'folke/neodev.nvim', -- neovim lua LSP support
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
  },
  { 'folke/which-key.nvim', opts = {} }, -- show what commands you could be trying to type
  { 'lewis6991/gitsigns.nvim' }, -- blame, git annotations, etc.
  { 'rebelot/kanagawa.nvim' }, -- color
  { 'nvim-lualine/lualine.nvim', opts = {  -- status line
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
        theme = 'auto',
      }
    }
  },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = { indent = { highlight = { 'Whitespace' } } } }, -- tab indicators
  { 
    'nvim-telescope/telescope.nvim', branch = '0.1.x', -- fuzzy finder
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'}, -- incremental parser
}
require('lazy').setup(lazy_plugins)

require('kanagawa').setup({
  theme = 'wave',
  background = {
    dark = 'wave',
    light = 'lotus'
  }
})

require('telescope').setup()

require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    }
  },
  rust_analyzer = {},
  pyright = {},
  tsserver = {},
  gopls = {},
}

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })
mason_lspconfig.setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
})

local cmp = require('cmp')
cmp.setup({
  completion = {
    compeleteopt = 'menu,menuone,noinsert',
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
  },
})

vim.opt.mouse = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false
vim.o.breakindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.o.clipboard = 'unnamedplus'

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'
vim.o.completeopt = 'menuone,noselect'
vim.o.updatetime = 50
vim.o.timeoutlen = 300

vim.opt.scrolloff = 10

vim.o.termguicolors = true
vim.o.background = 'dark'
vim.cmd('colorscheme kanagawa')

vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', { silent = true} )


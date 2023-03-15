-- This file can be loaded by calling `lua require('plugins')` from init.vim

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- File explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      {'nvim-tree/nvim-web-devicons', opt=true } -- for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- Autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup{}
    end
  }

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Treesitter interface
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {
      { 'nvim-lua/plenary.nvim' },
    }
  }

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- LSP format
  use "lukas-reineke/lsp-format.nvim"

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = { {'hrsh7th/cmp-nvim-lsp'} }
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)

-- This file can be loaded by calling `lua require('plugins')` from init.vim
-- Install packer
local install_path = vim.fn.stdpath 'data' ..
                         '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system {
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    }
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
            {'nvim-tree/nvim-web-devicons', opt = true} -- for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- Markdown Preview
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = {"markdown"} end,
        ft = {"markdown"}
    })

    -- Autopair
    use {
        'windwp/nvim-autopairs',
        config = function() require('nvim-autopairs').setup {} end
    }

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Treesitter interface
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            require('nvim-treesitter.install').update({with_sync = true})
        end
    }

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}}
    }

    -- Autocomplete
    use {
        'hrsh7th/nvim-cmp',
        requires = {{'hrsh7th/cmp-nvim-lsp'}, {'saadparwaiz1/cmp_luasnip'}}
    }

    -- LuaSnip (engine for cmp)
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v<CurrentMajor>.*",
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        requires = {
            "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"
        },
        config = function() require("_lsp").setup() end
    }

    -- LSP format
    use "lukas-reineke/lsp-format.nvim"

    -- null-ls
    use {
        "jose-elias-alvarez/null-ls.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = function() require("_null-ls") end
    }

    -- Colorscheme
    use 'rmehri01/onenord.nvim'

    -- LuaLine
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- tpope plugins for vim
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-sensible'

    -- easy align
    use 'junegunn/vim-easy-align'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if is_bootstrap then require('packer').sync() end
end)

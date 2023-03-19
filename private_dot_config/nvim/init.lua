--------------------------------------------------
-- Plugins
--------------------------------------------------
require('plugins')

--------------------------------------------------
-- Colorscheme Setup
--------------------------------------------------
local onenord_status_ok, onenord = pcall(require, 'onenord')
if not onenord_status_ok then return end

onenord.setup({theme = "dark", borders = true, fade_nc = true})

--------------------------------------------------
-- LuaLine Setup
--------------------------------------------------
local lualine_status_ok, lualine = pcall(require, 'lualine')
if not lualine_status_ok then return end

lualine.setup {options = {theme = 'onenord'}}

--------------------------------------------------
-- NvimTree Setup
--------------------------------------------------
local nvimtree_status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not nvimtree_status_ok then return end

-- Basic setup
nvim_tree.setup({
    sort_by = "case_sensitive",
    renderer = {group_empty = true},
    filters = {dotfiles = false},
    git = {enable = true, ignore = false}
})

--------------------------------------------------
-- Telescope Setup
--------------------------------------------------
local telescope_status_ok, telescope = pcall(require, 'telescope')
if not telescope_status_ok then return end
telescope.setup {defaults = {file_ignore_patterns = {"node_modules", ".git"}}}

local telebuiltin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telebuiltin.find_files, {})
vim.keymap.set('n', '<C-S-f>', telebuiltin.live_grep, {})
vim.keymap.set('n', '<C-S-b>', telebuiltin.buffers, {})

--------------------------------------------------
-- Tree-sitter Setup
--------------------------------------------------
local treesitter_status_ok, nvim_treesitter = pcall(require,
                                                    'nvim-treesitter.configs')
if not treesitter_status_ok then return end

-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
nvim_treesitter.setup {
    -- A list of parser names, or "all"
    ensure_installed = {
        'bash', 'c', 'cpp', 'css', 'html', 'javascript', 'json', 'lua',
        'python', 'rust', 'typescript', 'vim', 'yaml'
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    highlight = {
        -- `false` will disable the whole extension
        enable = true
    }
}

--------------------------------------------------
-- Autocomplete Setup
--------------------------------------------------
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then return end

cmp.setup {
    -- Load snippet support

    -- Completion settings
    completion = {
        -- completeopt = 'menu,menuone,noselect'
        keyword_length = 2
    },

    -- Key mapping
    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        -- Tab mapping
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    },

    -- Load sources, see: https://github.com/topics/nvim-cmp
    sources = {{name = 'nvim_lsp'}, {name = 'path'}, {name = 'buffer'}}
}

--------------------------------------------------
-- Markdown Preview
--------------------------------------------------
-- TODO:

--------------------------------------------------
-- Neovim LSP
--------------------------------------------------
-- Diagnostic settings:
-- see: `:help vim.diagnostic.config`
-- Customizing how diagnostics are displayed
vim.diagnostic.config({
    update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = ""
    }
})

-- Show line diagnostics automatically in hover window
vim.cmd([[
  autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
]])

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = {noremap = true, silent = true}
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

--------------------------------------------------
-- Settings options
--------------------------------------------------
local set = vim.opt
-- Set expand tab
set.expandtab = true

-- Set mouse
set.mouse = nil

-- Set clipboard
set.clipboard = 'unnamedplus'

-- Set highlight on search
set.hlsearch = false

-- Make line numbers default and show relative numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable break indent
set.breakindent = true

-- Save undo history
set.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
set.ignorecase = true
set.smartcase = true

-- Decrease update time
set.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set scrolloff
set.scrolloff = 15

-- Set globals
-- vim.g.python3_host_prog = '/usr/bin/python3'

--------------------------------------------------
-- Autocommands
--------------------------------------------------
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
augroup('YankHighlight', {clear = true})
autocmd('TextYankPost', {
    group = 'YankHighlight',
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({higroup = 'IncSearch', timeout = '300'})
    end
})

-- Prevent auto comment newline
autocmd('BufEnter', {pattern = '', command = 'set fo-=c fo-=r fo-=o'})

-- Set indentation to 2 spaces for some filetypes
augroup('setIndent', {clear = true})
autocmd('Filetype', {
    group = 'setIndent',
    pattern = {
        'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript',
        'json', 'yaml', 'lua'
    },
    command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2'
})

-- Set indentation to 4 spaces for some filetypes
autocmd('Filetype', {
    group = 'setIndent',
    pattern = {'python'},
    command = 'setlocal shiftwidth=4 tabstop=4 softtabstop=4'
})

--------------------------------------------------
-- Basic Keymaps
--------------------------------------------------
-- Set <space> as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Remap for dealing with word wraps
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk': 'k'",
               {expr = true, silent = true})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj': 'j'",
               {expr = true, silent = true})

-- Disable arrow keys
vim.keymap.set('', '<up>', '<nop>')
vim.keymap.set('', '<down>', '<nop>')
vim.keymap.set('', '<left>', '<nop>')
vim.keymap.set('', '<right>', '<nop>')

-- Change split orientation
vim.keymap.set('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
vim.keymap.set('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Reload configuration without restart nvim
vim.keymap.set('n', '<leader>r', ':so %<CR>')

-- delete all buffers and reopen the current one
vim.keymap.set('n', '<leader>bd', ':w|%bd|e#|bd#<CR>')
--------------------------------------------------
-- Applications and Plugins shortcuts
--------------------------------------------------
-- tpope Keymap Setup
local map = require('utils').map
-- vim-commentary
map('v', '<C-/>', ':Commentary<CR>')
map('n', '<C-/>', ':Commentary<CR>')

-- EasyAlign Keymap Setup
map('v', 'ga', '<Plug>(EasyAlign)', {noremap = false})
map('n', 'ga', '<Plug>(EasyAlign)', {noremap = false})

-- Terminal mappings
vim.keymap.set('n', '<C-t>', ':Term<CR>', {noremap = true}) -- open
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>') -- exit

-- NvimTree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>') -- open/close
vim.keymap.set('n', '<leader>p', ':NvimTreeRefresh<CR>') -- refresh
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>') -- search file

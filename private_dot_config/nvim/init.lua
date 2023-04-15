-- check runtimepath (:h rtp)
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

lualine.setup {
    options = {theme = 'onenord'},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'fileformat'},
        lualine_y = {'filetype'},
        lualine_z = {'location'}
    }
}

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
local lga_ok, lga_actions = pcall(require, 'telescope-live-grep-args.actions')

if not telescope_status_ok then return end
if not lga_ok then return end

local telescopeConfig = require("telescope.config")

-- -- Clone the default Telescope configuration
local vimgrep_arguments = {unpack(telescopeConfig.values.vimgrep_arguments)}

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--no-ignore")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
-- table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup {
    extensions = {
        live_grep_args = {
            auto_quoting = true,
            mappings = {
                i = {
                    ["<C-k>"] = lga_actions.quote_prompt(),
                    ["<C-i>"] = lga_actions.quote_prompt({postfix = " --iglob "})
                }
            }
        }
    },
    defaults = {
        -- `hidden=true` is not supported in the text grep commands.
        vimgrep_arguments = vimgrep_arguments,
        file_ignore_patterns = {"node_modules/", ".git/", "yarn/"}
    },
    pickers = {
        find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            -- include the option to ignore the .gitignore file
            find_command = {"rg", "--files", "--hidden", "--no-ignore"}
        }
    }
}

local telebuiltin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telebuiltin.find_files, {})
-- vim.keymap.set('n', '<C-S-f>', telebuiltin.live_grep, {})
vim.keymap.set('n', '<C-S-b>', telebuiltin.buffers, {})
vim.keymap.set('n', '<C-S-f>',
               ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
               {})
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

local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_status_ok then return end

cmp.setup {
    -- Load snippet 
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},

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
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    },

    -- Load sources, see: https://github.com/topics/nvim-cmp
    sources = {
        {name = 'luasnip'}, {name = 'nvim_lsp'}, {name = 'path'},
        {name = 'buffer'}
    }
}

--------------------------------------------------
-- Markdown Preview
--------------------------------------------------
-- set to 1, nvim will open the preview window after entering the markdown buffer
-- default: 0
vim.g.mkdp_auto_start = 0

-- set to 1, the nvim will auto close current preview window when change
-- from markdown buffer to another buffer
-- default: 1
vim.g.mkdp_auto_close = 1

-- set to 1, the vim will refresh markdown when save the buffer or
-- leave from insert mode, default 0 is auto refresh markdown as you edit or
-- move the cursor
-- default: 0
vim.g.mkdp_refresh_slow = 0

-- set to 1, the MarkdownPreview command can be use for all files,
-- by default it can be use in markdown file
-- default: 0
vim.g.mkdp_command_for_global = 0

-- set to 1, preview server available to others in your network
-- by default, the server listens on localhost (127.0.0.1)
-- default: 0
vim.g.mkdp_open_to_the_world = 0

-- use custom IP to open preview page
-- useful when you work in remote vim and preview on local browser
-- more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
-- default empty
vim.g.mkdp_open_ip = ''

-- specify browser to open preview page
-- for path with space
-- valid: `/path/with\ space/xxx`
-- invalid: `/path/with\\ space/xxx`
-- default: ''
vim.g.mkdp_browser = ''

-- set to 1, echo preview page url in command line when open preview page
-- default is 0
vim.g.mkdp_echo_preview_url = 0

-- a custom vim function name to open preview page
-- this function will receive url as param
-- default is empty
vim.g.mkdp_browserfunc = ''

-- options for markdown render
-- mkit: markdown-it options for render
-- katex: katex options for math
-- uml: markdown-it-plantuml options
-- maid: mermaid options
-- disable_sync_scroll: if disable sync scroll, default 0
-- sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
--   middle: mean the cursor position alway show at the middle of the preview page
--   top: mean the vim top viewport alway show at the top of the preview page
--   relative: mean the cursor position alway show at the relative positon of the preview page
-- hide_yaml_meta: if hide yaml metadata, default is 1
-- sequence_diagrams: js-sequence-diagrams options
-- content_editable: if enable content editable for preview page, default: v:false
-- disable_filename: if disable filename header for preview page, default: 0
vim.g.mkdp_preview_options = {
    mkit = {},
    katex = {},
    uml = {},
    maid = {},
    disable_sync_scroll = 0,
    sync_scroll_type = 'middle',
    hide_yaml_meta = 1,
    sequence_diagrams = {},
    flowchart_diagrams = {},
    content_editable = {v = false},
    disable_filename = 0,
    toc = {}
}

-- use a custom markdown style must be absolute path
-- like '/Users/username/markdown.css' or expand('~/markdown.css')
vim.g.mkdp_markdown_css = ''

-- use a custom highlight style must absolute path
-- like '/Users/username/highlight.css' or expand('~/highlight.css')
vim.g.mkdp_highlight_css = ''

-- use a custom port to start server or empty for random
vim.g.mkdp_port = ''

-- preview page title
-- ${name} will be replace with the file name
vim.g.mkdp_page_title = '「${name}」'

-- recognized filetypes
-- these filetypes will have MarkdownPreview... commands
vim.g.mkdp_filetypes = {'markdown'}

-- set default theme (dark or light)
-- By default the theme is define according to the preferences of the system
vim.g.mkdp_theme = 'dark'

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
-- Neogen Annotations
--------------------------------------------------
-- Setup
local neogen_status_ok, neogen = pcall(require, 'neogen')
if not neogen_status_ok then return end

neogen.setup {enabled = true, snippet_engine = "luasnip"}

-- keybind for generating using lua api
vim.api.nvim_set_keymap("n", "<leader>d",
                        ":lua require('neogen').generate()<CR>",
                        {noremap = true, silent = true})
--------------------------------------------------

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

-- EasyAlign Keymap Setup https://github.com/junegunn/vim-easy-align
map('v', 'ga', '<Plug>(EasyAlign)', {noremap = false})
map('n', 'ga', '<Plug>(EasyAlign)', {noremap = false})

-- Terminal mappings
vim.keymap.set('n', '<C-t>', ':Term<CR>', {noremap = true}) -- open
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>') -- exit

-- NvimTree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>') -- open/close
vim.keymap.set('n', '<leader>p', ':NvimTreeRefresh<CR>') -- refresh
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>') -- search file

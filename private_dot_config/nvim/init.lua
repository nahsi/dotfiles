-- Install packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- package manager

  use 'tpope/vim-vinegar' -- better netrw
  use 'tpope/vim-fugitive' -- git commands in nvim
  use 'tpope/vim-rhubarb' -- fugitive-companion to interact with github
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'machakann/vim-sandwich' -- vim-surround alternative
  use 'phaazon/hop.nvim' -- easymotion in lua
  use 'npxbr/glow.nvim' -- preview MD in buffer
  use 'norcalli/nvim-colorizer.lua' --  color higlighter in lua

  -- IDE
  -- highlight, edit, and navigate code
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- collection of configurations for build in LSP
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe' -- autocompletion plugin
  use 'L3MON4D3/LuaSnip' -- snippets plugin
  -- use 'fatih/vim-go' -- go developement plugin

  -- UI to select things (files, grep results, open buffers...)
  use {
    'nvim-telescope/telescope.nvim', 
    requires = {
      { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } 
    }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'airblade/vim-rooter' -- changes to work dir of project
  use 'windwp/nvim-autopairs'

  use 'RRethy/nvim-base16' -- base16 colorschemes pack
  use {
    'hoob3rt/lualine.nvim', -- statusline in lua
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  -- add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'wfxr/minimap.vim'
end)

-- Indentation
vim.o.tabstop=2
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.o.expandtab=true

-- Incremental live completion
vim.o.inccommand = 'nosplit'

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Do not save when switching buffers
vim.o.hidden = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.cmd [[set undofile]]

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.base16colorspace = 256
vim.cmd [[colorscheme base16-tomorrow-night]]

-- No backup/swap
vim.o.backup = false
vim.o.swapfile = false

-- Yank to system clipboard
vim.o.clipboard = 'unnamed'

-- Enable folding
vim.o.foldenable = true
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

-- Set colorcolumn and line highlight
vim.o.colorcolumn = '79'
vim.o.cursorline = true

-- Hide duplicate mod indicator
vim.o.showmode = false

-- Set statusbar
require('lualine').setup{
  options = {
    theme = 'auto',
    section_separators = '', component_separators = ''
  }
}

-- Set , as leader key
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Remove trailing whitespaces
vim.api.nvim_set_keymap('n', '<leader>w', [[<cmd>%s/\s\+$//<CR>:let @/='']], { noremap = true, silent = true })

-- Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Map blankline
vim.g.indent_blankline_char = '│'
vim.api.nvim_exec([[ hi IndentBlanklineChar guifg=#373b41 ]], false)
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- code-minimap
vim.g.minimap_auto_start = 0

-- colorizer
require'colorizer'.setup()

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- hop
require'hop'.setup()
vim.api.nvim_set_keymap('n', '<leader>h', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", {})

-- Telescope
require('telescope').setup {
  defaults = {
    layout_strategy = 'vertical',
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  extentions = {
    fzf = {
    fuzzy = true,                    -- false will only do exact matching
    override_generic_sorter = false, -- override the generic sorter
    override_file_sorter = true,     -- override the file sorter
    case_mode = "smart_case",
  }
  }
}
require('telescope').load_extension('fzf')

-- Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fo', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

-- Compe setup
require('compe').setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'disable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    nvim_lsp = true,
    luasnip = true,
    buffer = false,
    calc = false,
    nvim_lua = false,
    vsnip = false,
    ultisnips = false,
  },
}

-- Utility functions for compe and luasnip
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local luasnip = require 'luasnip'

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif luasnip.expand_or_jumpable() then
    return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif luasnip.jumpable(-1) then
    return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

-- Map tab to the above tab complete functiones
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })

-- autopairs
require('nvim-autopairs').setup({
  check_ts = true,
})
require('nvim-autopairs.completion.compe').setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true -- it will auto insert `(` after select function or method item
})

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    disable = {'yaml'}
  },
  indent = {
    enable = true,
    disable = {'yaml'}
  },
}

-- Enable the following language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
  gopls = { 
    cmd = {'gopls', 'serve'},
    capabilities = capabilities,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
      },
      staticcheck = true,
    },
  },
  terraformls = {}
}

local lsp_config = require'lspconfig'

for server, config in pairs(servers) do
    lsp_config[server].setup(config)
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,preview'

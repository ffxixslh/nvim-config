local g = vim.g
local opt = vim.opt

g.mapleader = ' '
g.maplocalleader = ' '
g.have_nerd_font = true

g.codeium_log_file = '~/codeium.log'
g.codeium_bin = '~/.codeium/bin/language_server_windows_x64.exe'

opt.number = true
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'
--
-- Sync clipboard between OS and Neovim.
opt.clipboard = 'unnamedplus'

-- Enable break indent
opt.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 150

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 200

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
opt.hlsearch = true
opt.incsearch = true

-- Show which line your cursor is on
opt.cursorline = true

-- Highlight current line number in sidebar but don't highlight whole row
opt.cursorlineopt = 'number'

opt.tabstop = 2 -- A TAB character looks like 4 spaces
opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
opt.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
opt.shiftwidth = 2 -- Number of spaces inserted when indenting
opt.smartindent = true

-- Text wrap in a single line
opt.wrap = true

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.showmode = false -- Don't show the mode, since it's already in status line

opt.shell = vim.fn.executable 'pwsh' and 'pwsh' or 'powershell'

opt.isfname:append '@-@'

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 }
  end,
})

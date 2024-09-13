local map = vim.keymap

map.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keymaps
map.set('i', 'jf', '<Esc>')
map.set('n', 'H', '^')
map.set('n', 'L', '$')

map.set('n', '<leader>ww', vim.cmd.write, { desc = '[W]rite file using shortcut' })
map.set('n', '<leader>qq', vim.cmd.quit, { desc = '[Q]uit current nvim window' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
map.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
map.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
map.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move Lines
map.set('n', '<A-j>', ':m .+1<cr>==', { desc = 'Move line down' })
map.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move line down' })
map.set('i', '<A-j>', '<Esc>:m .+1<cr>gi', { desc = 'Move line down' })
map.set('n', '<A-k>', ':m .-2<cr>==', { desc = 'Move line up' })
map.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move line up' })
map.set('i', '<A-k>', '<Esc>:m .-2<cr>==gi', { desc = 'Move line up' })

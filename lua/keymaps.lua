-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Terminal window navigation
vim.keymap.set('t', '<C-w>h', [[<C-\><C-n><C-w>h]], { desc = 'Go to left window' })
vim.keymap.set('t', '<C-w>j', [[<C-\><C-n><C-w>j]], { desc = 'Go to bottom window' })
vim.keymap.set('t', '<C-w>k', [[<C-\><C-n><C-w>k]], { desc = 'Go to top window' })
vim.keymap.set('t', '<C-w>l', [[<C-\><C-n><C-w>l]], { desc = 'Go to right window' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Window Resizing (Alt + hjkl)
vim.keymap.set('n', '<M-h>', '<cmd>vertical resize -5<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<M-l>', '<cmd>vertical resize +5<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<M-j>', '<cmd>resize -5<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<M-k>', '<cmd>resize +5<CR>', { desc = 'Increase window height' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
--
-- repl new block command
vim.keymap.set('n', '<Space>nc', '<cmd>NewReplBlock<CR>', { desc = 'Insert New REPL Code Block' })

-- goto to next diagnostics entry
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next()
end, { desc = 'jump to next diagnostics entry' })

vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev()
end, { desc = 'jump to previous diagnostics entry' })

-- Move up/down editor lines
vim.keymap.set('n', 'j', 'gj', { silent = true })
vim.keymap.set('n', 'k', 'gk', { silent = true })

-- Search with very magic regex by default
vim.keymap.set({ 'n', 'v' }, '/', '/\\v')

-- Buffer navigation
vim.keymap.set('n', 'gn', '<cmd>bn<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', 'gp', '<cmd>bp<CR>', { desc = 'Previous buffer' })

-- Telescope mappings (mirrored from .vimrc fzf)
vim.keymap.set('n', '<Tab>', function() Snacks.picker.buffers() end, { desc = '[ ] Search buffers' })
vim.keymap.set('n', '<leader>f', function() Snacks.picker.files() end, { desc = '[F]ind Files' })
vim.keymap.set('n', '<leader>r', function() Snacks.picker.grep() end, { desc = '[R]ipgrep' })

-- Replace word under cursor
vim.keymap.set('n', '<leader>sr', ':%s/<C-R><C-W>//g<Left><Left>', { desc = '[S]earch and [R]eplace word under cursor' })

-- Toggle UI elements via Snacks
vim.keymap.set('n', '<leader>td', function() Snacks.toggle.diagnostics():toggle() end, { desc = '[T]oggle [D]iagnostics' })
vim.keymap.set('n', '<leader>tl', function() Snacks.toggle.line_numbers():toggle() end, { desc = '[T]oggle [L]ine numbers' })
vim.keymap.set('n', '<leader>tw', function() Snacks.toggle.option('wrap'):toggle() end, { desc = '[T]oggle [W]rap' })

-- Fullscreen toggle (legacy F1)
vim.keymap.set({ 'n', 'v', 'i' }, '<F1>', '<cmd>set invfullscreen<CR>', { desc = 'Toggle fullscreen' })

-- search for common phrases in literature
vim.keymap.set('n', '<Leader>sp', '<cmd>TelescopePhrases /home/llan/.vim/useful_phrases.vim<CR>', { desc = '[S]earch for [P]hrases' })

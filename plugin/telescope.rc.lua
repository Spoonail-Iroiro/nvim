local telescope = require('telescope')

telescope.setup({
    defaults = {
        winblend = 20,
        file_ignore_patterns = {
            "^.git/",
            "^node_modules/"
        }
    }
})

local builtin = require('telescope.builtin')

vim.keymap.set({'n'}, '<Leader>f', '[telescope]', {remap=true})
vim.keymap.set({'n'}, '[telescope]b', function () builtin.buffers() end)
vim.keymap.set({'n'}, '[telescope]f', function () builtin.find_files({hidden=true, no_ignore=false}) end)
vim.keymap.set({'n'}, '[telescope]r', function () builtin.live_grep({hidden=true, no_ignore=false}) end)

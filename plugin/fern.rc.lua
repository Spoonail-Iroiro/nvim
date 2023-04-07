-- fern customize
local autocmd = vim.api.nvim_create_autocmd

vim.g["fern#default_hidden"] = 1

function fern_setting() 
    vim.opt.number = false
    vim.keymap.set('n', '<CR>', '<Plug>(fern-action-open-or-expand)', {buffer=true})
    vim.keymap.set('n', 's', '<Nop>', {buffer=true})
    vim.keymap.set('n', 'l', '<Nop>', {buffer=true})
    vim.keymap.set('n', 'v', '<Plug>(fern-action-open:rightest)', {buffer=true})
end 

autocmd("FileType", {
    pattern = {"fern"},
    callback = fern_setting
})

-- vim.keymaps fern
vim.keymap.set('n', 'e', ':Fern . -drawer<CR>')
vim.keymap.set('n', 'E', ':Fern . -drawer -reveal=%<CR>')

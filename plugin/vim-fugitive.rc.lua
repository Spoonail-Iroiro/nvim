function open_fugitive()
    vim.cmd [[
    tabnew
    Git
    7wincmd_
    ]]
end

vim.keymap.set('n', '[fugitive]', '<Nop>')
vim.keymap.set('n', '<Leader>g', '[fugitive]', {remap=true})
vim.keymap.set('n', '[fugitive]g', open_fugitive)

-- fern customize
local autocmd = vim.api.nvim_create_autocmd

vim.g["fern#default_hidden"] = 1
vim.g['fern#renderer'] = 'nerdfont'

function fern_open_or_expand_collapse()
    local expr_ = vim.fn['fern#smart#leaf'](
        '<Plug>(fern-action-open)',
        '<Plug>(fern-action-expand)',
        '<Plug>(fern-action-collapse)'
    )

    return expr_
end

function fern_create_python_package()
    local filetype_ = vim.bo['filetype']
    if filetype_ ~= "fern" then
        print("Not in Fern buffer.")
        return
    end

    local module_name = vim.fn.input('Module name:', '')
    vim.cmd('redraw')
    local new_dir = '<Plug>(fern-action-new-dir=)' .. module_name .. '<CR>'
    local new_file = '<Plug>(fern-action-new-file=)./' .. module_name .. '/__init__.py<CR>'
    local full_cmd = new_dir .. new_file
    return full_cmd
end

function fern_setting()
    vim.opt.number = false
    -- vim.keymap.set('n', '<CR>', '<Plug>(fern-action-open-or-expand)', {buffer=true})
    vim.keymap.set('n', '<CR>', fern_open_or_expand_collapse, { buffer = true, expr = true, silent = true })
    vim.keymap.set('n', 's', '<Nop>', { buffer = true })
    vim.keymap.set('n', 'l', '<Nop>', { buffer = true })
    vim.keymap.set('n', 'v', '<Plug>(fern-action-open:rightest)', { buffer = true })
    vim.keymap.set('n', 'b', '<Nop>', { buffer = true })
    vim.keymap.set('n', 'b', fern_create_python_package, { buffer = true, expr = true })
    vim.fn['glyph_palette#apply']()
end

autocmd("FileType", {
    pattern = { "fern" },
    callback = fern_setting
})


-- vim.keymaps fern
vim.keymap.set('n', 'e', ':Fern . -drawer<CR>')
vim.keymap.set('n', 'E', ':Fern . -drawer -reveal=%<CR>')

vim.g.coc_global_extensions = {
    'coc-json',
    'coc-html',
    'coc-lua'
}

vim.keymap.set('n', '[coc]', '<Nop>')
vim.keymap.set({'n', 'x', 'o'}, '<Leader>c', '[coc]', {remap=true})

-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
vim.keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

vim.keymap.set("n", "[coc]g", "<Cmd>CocDiagnostics<CR>")

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

vim.keymap.set('n', 'K', '<CMD>lua _G.show_docs()<CR>', {silent=true})

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})




-- Formatting selected code
-- Setup formatexpr specified filetype(s)
-- !! Target filetypes; if some format issue occured, remove some filetypes from here
local format_selected_filetypes = "typescript,json,python"
vim.keymap.set({"n", "x"}, "[coc]f", "<Plug>(coc-format-selected)", {silent = true})

vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = format_selected_filetypes,
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})


-- Symbol renaming
vim.keymap.set("n", "[coc]rn", "<Plug>(coc-rename)", {silent = true})

-- Apply codeAction to the selected region
--@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
vim.keymap.set("x", "[coc]a", "<Plug>(coc-codeaction-selected)", opts)
vim.keymap.set("n", "[coc]a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
vim.keymap.set("n", "[coc]ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply code actions affect whole buffer.
vim.keymap.set("n", "[coc]as", "<Plug>(coc-codeaction-source)", opts)
-- Remap keys for applying codeActions to the current buffer
vim.keymap.set("n", "[coc]ac", "<Plug>(coc-codeaction)", opts)
-- Apply the most preferred quickfix action on the current line.
vim.keymap.set("n", "[coc]qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
vim.keymap.set("n", "[coc]re", "<Plug>(coc-codeaction-refactor)", { silent = true })
vim.keymap.set("x", "[coc]r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
vim.keymap.set("n", "[coc]r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
vim.keymap.set("n", "[coc]cl", "<Plug>(coc-codelens-action)", opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
vim.keymap.set("x", "if", "<Plug>(coc-funcobj-i)", opts)
vim.keymap.set("o", "if", "<Plug>(coc-funcobj-i)", opts)
vim.keymap.set("x", "af", "<Plug>(coc-funcobj-a)", opts)
vim.keymap.set("o", "af", "<Plug>(coc-funcobj-a)", opts)
vim.keymap.set("x", "ic", "<Plug>(coc-classobj-i)", opts)
vim.keymap.set("o", "ic", "<Plug>(coc-classobj-i)", opts)
vim.keymap.set("x", "ac", "<Plug>(coc-classobj-a)", opts)
vim.keymap.set("o", "ac", "<Plug>(coc-classobj-a)", opts)

-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
vim.keymap.set({"n", "i", "v"}, "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
vim.keymap.set({"n", "i", "v"}, "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
vim.keymap.set({"n", "x"}, "[coc]s", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.cmd [[
    function! StatusDiagnostic() abort
        let info = get(b:, 'coc_diagnostic_info', {})
        if empty(info) | return '' | endif
        let msgs = []
        if get(info, 'error', 0)
            call add(msgs, 'E' . info['error'])
        endif
        if get(info, 'warning', 0)
            call add(msgs, 'W' . info['warning'])
        endif
        return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
    endfunction
]]

vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")
-- vim.opt.statusline:prepend("%{StatusDiagnostic()}")
-- vim.opt.statusline:prepend("hoge")
vim.cmd [[autocmd User CocStatusChange redrawstatus]]

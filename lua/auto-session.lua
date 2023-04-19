local SESSION_FILENAME = ".vimsession"

-- vim.opt.sessionoptions:append({})
vim.opt.sessionoptions:remove({ "options" })


local is_auto_session_loaded = false
local is_auto_save_disabled = false

local function clean_before_session_write()
    vim.cmd [[FernDo close -drawer]]
    vim.cmd [[norm tc]]
end

function create_auto_session()
    clean_before_session_write()
    vim.cmd([[mks ]] .. SESSION_FILENAME)
    is_auto_session_loaded = true
end

function disable_auto_save()
    is_auto_save_disabled = true
    print("AutoSaveStatus:" .. tostring(is_auto_save_disabled))
end

function save_auto_session(silent)
    if vim.fn["filewritable"](SESSION_FILENAME) == 1 and not is_auto_save_disabled then
        clean_before_session_write()
        vim.cmd([[mks! ]] .. SESSION_FILENAME)
    else
        if not silent then
            print("No " .. SESSION_FILENAME .. " found")
        end
    end
end

function load_auto_session(silent)
    if vim.fn["filereadable"](SESSION_FILENAME) == 1 then
        vim.cmd([[source ]] .. SESSION_FILENAME)
        is_auto_session_loaded = true
    else
        if not silent then
            print("No " .. SESSION_FILENAME .. " found")
        end
    end
end

function _G.check_auto_session_loaded()
    print(is_auto_session_loaded)
end

vim.api.nvim_create_user_command(
    "CreateAutoSession",
    create_auto_session,
    {}
)

vim.api.nvim_create_user_command(
    "SaveAutoSession",
    save_auto_session,
    {}
)

vim.api.nvim_create_user_command(
    "LoadAutoSession",
    load_auto_session,
    {}
)

vim.api.nvim_create_user_command(
    "DisableAutoSessionAutoSave",
    disable_auto_save,
    {}
)

local auto_session_group = vim.api.nvim_create_augroup("AutoSession", { clear = false })

-- local aa = [[
function _G.auto_session_register_auto_load()
    vim.api.nvim_create_autocmd(
        { "VimEnter", "WinEnter" },
        {
            pattern = { "*" },
            group = auto_session_group,
            command = "LoadAutoSession"
            -- callback = function() load_auto_session(true) end
        }
    )
end

-- ]]

vim.api.nvim_create_autocmd(
    { "VimLeave" },
    {
        pattern = { "*" },
        group = auto_session_group,
        callback = function() if is_auto_session_loaded == true then save_auto_session(true) end end
        -- callback = function() save_auto_session(true) end
    }
)

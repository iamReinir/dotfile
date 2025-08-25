-- session management
local dir = "/home/reinir/.config/nvim/session/"
local default_session_file = ".nvim_session"
local function session_file_complete(session_dir) -- auto complete RS/SS command with session file 
    return function(_, _, _)
        local files = vim.fn.globpath(session_dir, "*.session", false, true)
        return vim.tbl_map(function(path)
            return vim.fn.fnamemodify(path, ":t:r")  -- strip dir + extension
        end, files)
    end
end

-- Create Session with :ss
vim.api.nvim_create_user_command("SS", function(opts)
    local file = opts.args ~= "" and opts.args .. ".session" or default_session_file
    local session_file = dir .. file
    vim.cmd("mks! " .. vim.fn.fnameescape(session_file))
    print("Session saved to " .. session_file)
end, {
    nargs = "?",      -- zero or one argument
    complete = session_file_complete(dir)
})
-- Restore Session with :rs
vim.api.nvim_create_user_command("RS", function(opts)
    local file = opts.args ~= "" and opts.args .. ".session" or default_session_file
    local session_file = dir .. file
    if vim.fn.filereadable(session_file) == 1 then
        vim.cmd("source " .. vim.fn.fnameescape(session_file))
        print("Session restored from " .. session_file)
    else
        print("No session file at " .. session_file)
    end
end, {
    nargs = "?",
    complete = session_file_complete(dir),
})

-- List available session with :LS
vim.api.nvim_create_user_command("LS", function(opts)
    local file = opts.args ~= "" and opts.args .. ".session" or default_session_file
    vim.cmd("!ls " .. dir)
end, { })

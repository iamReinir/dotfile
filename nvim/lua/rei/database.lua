local config_dir = vim.fn.stdpath("config")
local command = config_dir .. '/database/connect.sh'
local repl = config_dir .. '/database/REPL.sh'
-- call db, dump result into RAM, open result in another buffer, nowrap. Look nice as hell
-- depend on cmd installed in local machine
vim.keymap.set('v', '<leader>db', ':w !' .. command .. '| csvlook > /tmp/db.txt 2>&1<CR>:e /tmp/db.txt<CR>:setlocal nowrap<CR>', opts)

vim.api.nvim_create_user_command("Conns", function()
    local dir = config_dir .. "/database/connections"
    -- open Oil in that directory
    require("oil").open(dir)
end, { desc = "Open Connections directory in Oil" })

vim.api.nvim_create_user_command("DB", function()
    vim.cmd("terminal " .. repl .. " " .. command)
    vim.cmd("startinsert")
end, {})

vim.api.nvim_create_user_command("DBSelect", function(opts)
    local src = config_dir .. "/database/connections/" .. opts.args
    if vim.fn.filereadable(src) == 1 then
        local content = vim.fn.readfile(src)
        vim.fn.writefile(content, command)
        print("Connect script selected: " .. src)
    else
        print("File not found: " .. src)
    end
end, { nargs = 1, desc = "Change connect script" })




local dap = require("dap")
dap.adapters.coreclr = {
    type = 'executable',
    command = '/usr/bin/netcoredbg', -- or 'vsdbg'
    args = { '--interpreter=vscode' }
}
dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    },
}

-- debugger
local keymap = vim.keymap.set
local dapui = require("dapui")

-- Extra: toggle UI
keymap("n", "<F3>", dapui.toggle, { desc = "DAP: Toggle UI" })
-- Optional: REPL
keymap("n", "<F2>", dap.repl.open, { desc = "DAP: Open REPL" })
keymap("n", "<F4>", function()
    require("dap").clear_breakpoints()
end, { desc = "DAP: Clear All Breakpoints" })
keymap("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
keymap("n", "<F6>", dap.terminate, { desc = "DAP: Terminate" })
keymap("n", "<F7>", dap.restart, { desc = "DAP: Restart (if supported)" })
keymap("n", "<F8>", dap.step_back or function() end, { desc = "DAP: Step Back (if supported)" })
keymap("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
keymap("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
keymap("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
keymap("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })

-- Install plugin manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Plugins go here
    { "nvim-neotest/nvim-nio" },
    { "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "Hoffs/omnisharp-extended-lsp.nvim" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    { "mfussenegger/nvim-dap", -- Debugger UI
        dependencies = {
            "rcarriga/nvim-dap-ui",            -- UI for DAP
            "theHamsta/nvim-dap-virtual-text", -- Virtual text for variables
        },
    },
    { 'lewis6991/gitsigns.nvim', -- Git sign
        config = function()
            require('gitsigns').setup()
        end
    },
    {'romgrk/barbar.nvim', -- pretty tab. The icon still suck lmao
        dependencies = {
          'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
          'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
    },
    { "echasnovski/mini.icons", opts = {}},
    { "stevearc/dressing.nvim" }, -- pretty UI for code action/rename
    { "stevearc/oil.nvim",
        opts = {},
        dependencies = { "echasnovski/mini.icons", opts = {}},
        lazy = false -- lazy load not recommended
    },
})

require("dapui").setup()
require("nvim-dap-virtual-text").setup()
require("oil").setup()

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

require("mason").setup()
require("rei.lsp")
require("rei.session")
require("rei.buffer")
require("rei.editor")
require("rei.debugger")

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

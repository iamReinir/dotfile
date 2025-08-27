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
    { "tpope/vim-dadbod",
        dependencies = {
            "kristijanhusak/vim-dadbod-completion"
        }
    },
})

require("dapui").setup()
require("nvim-dap-virtual-text").setup()
require("oil").setup()
require("mason").setup()
require("rei.lsp")
require("rei.session")
require("rei.buffer")
require("rei.editor")
require("rei.debugger")
require("rei.database")


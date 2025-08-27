local opts = { noremap = true, silent = true }
local map = vim.keymap.set
-- Tabbar
require('barbar').setup {
    icons = {
        separator = { left = '>', right = '' },
        filetype = { enabled = false },
        modified = { button = '*' },
        inactive = { button = ' ' },
        current = { button = '<' },
        insert_at_end = true,
        animation = false
    }
}

require('oil').setup {
    default_file_explorer = true,
    columns = {
    }
}
map('n', '<leader>cd', function()
    vim.cmd("cd " .. require('oil').get_current_dir())
end, opts)

vim.api.nvim_create_user_command("Ex", function()
    require('oil').open(path)
end, {})

-- change cursor when enter/leaving Insert. Very nice QOL
-- refer : https://linuxgazette.net/137/anonymous.html
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        os.execute('printf "\\e[?0c"')
    end
})

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        os.execute('printf "\\e[?6c"')
    end
})

-- Auto complete
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept completion
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Set basic options
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.signcolumn = "yes"

-- copy selection into clipboard
map('v', '<leader>y', ':w !tty-copy<CR>', opts)

-- BarBar buffer line setup

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- Close/restore buffer
map('n', '<A-w>', '<Cmd>BufferClose<CR>', opts)
map('n', '<A-s-w>', '<Cmd>BufferRestore<CR>', opts)

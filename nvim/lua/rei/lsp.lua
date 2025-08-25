
-- Set up LSP
local lspconfig = require("lspconfig")
local omnisharp_ext = require("omnisharp_extended")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- webdeb: HTML, CSS, JS/TS
lspconfig.html.setup {}
lspconfig.cssls.setup {}
lspconfig.ts_ls.setup({
    capabilities = capabilities,
    init_options = {
        plugins = { -- I think this was my breakthrough that made it work
            {
                name = "@vue/typescript-plugin",
                location = "usr/bin/vue-language-server",
                languages = { "vue" },
            },
        },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

-- Python
lspconfig.pyright.setup({
    capabilities = capabilities,
})

-- Lua
lspconfig.lua_ls.setup({
    capabilities = capabilities,
})

-- OmniSharp with Extensions
lspconfig.omnisharp.setup({
    capabilities = capabilities,
    cmd = { "omnisharp" }, -- Replace with full path if needed
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,

    handlers = {
        ["textDocument/definition"] = omnisharp_ext.handler,
        ["textDocument/typeDefinition"] = omnisharp_ext.handler,
        ["textDocument/references"] = omnisharp_ext.handler,
        ["textDocument/implementation"] = omnisharp_ext.handler,
    },
})

lspconfig.jdtls.setup({
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern("pom.xml", "build.gradle", ".git")
})

-- Keymap


local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local lsp = vim.lsp.buf

map('n', 'K', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- Scroll in hover doc (or any LSP floating window)
map({ "n", "i" }, "<C-f>", function()
  if not vim.lsp.util.scroll(4) then
    return "<C-f>"
  end
end, { expr = true, silent = true })

map({ "n", "i" }, "<C-b>", function()
  if not vim.lsp.util.scroll(-4) then
    return "<C-b>"
  end
end, { expr = true, silent = true })

map('n', 'gd', lsp.definition, opts)
-- Hover docs
map('n', 'gh', lsp.hover, opts)
map('n', 'gD', lsp.declaration, opts)
map('n', 'gi', lsp.implementation, opts)
map('n', 'gr', lsp.references, opts)
map('n', '<leader>rn', lsp.rename, opts)
map('n', '<leader>ac', lsp.code_action, opts)

-- Format
vim.api.nvim_create_user_command("F", function()
    lsp.format({ async = true })
end, {})

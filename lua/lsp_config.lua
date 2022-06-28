require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)

    vim.keymap.set('n', ' fm', vim.lsp.buf.formatting, bufopts)

    vim.keymap.set('n', ' dj', vim.diagnostic.goto_next, bufopts)

    vim.keymap.set('n', ' rr', vim.lsp.buf.rename, bufopts)

    vim.keymap.set('n', ' ca', vim.lsp.buf.code_action, bufopts)
end;

require("lspconfig")['ltex'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig")['jdtls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['pyright'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['metals'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['texlab'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['sumneko_lua'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    cmd = { "/home/nathanh/lua-language-server/bin/lua-language-server" }
}

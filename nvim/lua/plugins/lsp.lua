require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  },
})

require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  ensure_installed = {
    "lua_ls",
    "clangd",
    "pyright",
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local jdtls_path = "D:/downLoad/jdtls/jdt-language-server-1.9.0-202203031534/jdtls.bat"

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
}

require("lspconfig").pyright.setup {
  capabilities = capabilities,
}

require("lspconfig").clangd.setup {
  capabilities = capabilities,
}

require("lspconfig").jdtls.setup {
  cmd = { jdtls_path },
  capabilities = capabilities,
}


return {


  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- 1) Общие keymaps на LspAttach
      local group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(ev)
          local buf = ev.buf
          vim.bo[buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          local function map(mode, lhs, rhs, desc)
            local opts = { buffer = buf, silent = true }
            if type(desc) == "string" then opts.desc = desc end
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
          map("n", "<Leader>D", vim.lsp.buf.type_definition, "Type definition")
          map("n", "<Leader>lr", vim.lsp.buf.rename, "Rename symbol")
          map({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, "Code action")
          map("n", "<Leader>lf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
        end,
      })

      -- Include your LSP config files
      require("plugins.lsp.lua_ls")()
      -- require("plugins.lsp.pyright")()
      -- require("plugins.lsp.tsserver")()
    end,
  },
}

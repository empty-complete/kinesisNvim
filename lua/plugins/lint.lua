return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")


      lint.linters_by_ft = {
        python = { "ruff" },
        -- lua = { "luacheck" },
        -- javascript = { "eslint_d" },
      }

      local group = vim.api.nvim_create_augroup("UserLint", { clear = true })

      vim.api.nvim_create_autocmd(
        { "BufWritePost", "BufReadPost", "InsertLeave" },
        {
          group = group,
          callback = function()
            lint.try_lint()
          end,
        }
      )
    end,
  },
}

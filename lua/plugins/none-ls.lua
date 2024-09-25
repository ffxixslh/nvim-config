-- This file controls formatting and diagnostics, like eslint, prettier, etc
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  opts = function(_, opts)
    local nls = require 'null-ls'
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.formatting.stylua,
      nls.builtins.completion.spell,
      require 'none-ls.diagnostics.eslint_d',
    })
  end,
}

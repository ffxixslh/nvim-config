return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
  },
  opts = function(_, opts)
    local nls = require 'null-ls'
    opts.sources = vim.list_extend(opts.sources or {}, {
      nls.builtins.completion.spell,
      require('none-ls.diagnostics.eslint_d').with {
        condition = function(utils)
          return utils.root_has_file {
            '.eslintrc',
            '.eslintrc.json',
            'eslint.config.js',
            'eslint.config.cjs',
            'eslint.config.mjs',
          }
        end,
      },
    })
  end,
}

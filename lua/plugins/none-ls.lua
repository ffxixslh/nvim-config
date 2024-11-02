local eslint_d_ft = {
  '.eslintrc',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.cjs',
  'eslint.config.mjs',
}

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
          return utils.root_has_file(eslint_d_ft)
        end,
      },
      require('none-ls.code_actions.eslint_d').with {
        condition = function(utils)
          return utils.root_has_file(eslint_d_ft)
        end,
      },
    })
  end,
}

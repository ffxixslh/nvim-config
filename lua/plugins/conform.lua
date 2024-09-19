local formatters_by_ft = {
  lua = { 'stylua' },
}

local prettierd_ft = {
  'html',
  'css',
  'json',
  'markdown',
  'postcsss',
  'yaml',
}

local eslint_d_ft = {
  'typescript',
  'typescriptreact',
  'javascript',
  'javascriptreact',
}

for _, ft in ipairs(prettierd_ft) do
  formatters_by_ft[ft] = { 'prettierd' }
end

for _, ft in ipairs(eslint_d_ft) do
  formatters_by_ft[ft] = { 'eslint_d' }
end

return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = formatters_by_ft,
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
  },
}

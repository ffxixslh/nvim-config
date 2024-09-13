local formatters_by_ft = {
  lua = { 'stylua' },
}

local prettierd_ft = {
  'html',
  'css',
  'postcsss',
  'markdown',
  'json',
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
    ft = vim.tbl_keys(formatters_by_ft),
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    config = function()
      local conform = require 'conform'
      local utils = require 'ffxixslh.utils'

      conform.setup {
        formatters_by_ft = formatters_by_ft,
      }

      utils.config_autocmd('BufWritePre', {
        pattern = '*',
        callback = function(e)
          local filetype = vim.bo[e.buf].filetype

          if not formatters_by_ft[filetype] or vim.g.disable_autoformat then
            return
          end

          local client = vim.lsp.get_clients({ buf = e.buf, name = 'eslint' })[1]

          if client then
            pcall(vim.lsp.buf.format, {
              async = false,
              timeout_ms = 4000,
            })
          end

          pcall(conform.format, {
            bufnr = e.buf,
            timeout_ms = 1000,
            lsp_fallback = true,
          })
        end,
      })

      vim.api.nvim_create_user_command('FormatToggle', function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end, {})
    end,
  }

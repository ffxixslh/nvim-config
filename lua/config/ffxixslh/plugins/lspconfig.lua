return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'j-hui/fidget.nvim',
    'folke/neodev.nvim',
  },
  event = 'BufReadPre',
  config = function()
    local lsp = require 'config.ffxixslh.lsp'
    local utils = require 'config.ffxixslh.utils'
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    require('neodev').setup {}

    utils.config_autocmd('LspAttach', {
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if not client then
          return
        end

        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end

        lsp.on_attach(client, event.buf)
      end,
    })

    require('fidget').setup({
      progress = {
        display = { progress_icon = { "moon" } }
      },
    })
  end,
}

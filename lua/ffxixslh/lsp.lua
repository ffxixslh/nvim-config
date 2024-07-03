local builtin = require "telescope.builtin"
local themes = require "telescope.themes"

local M = {}

M.handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  }),
}

function M.on_attach(_, bufnr)
  local function lsp_map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = 'LSP: ' .. tostring(desc) })
  end

  lsp_map("n", "gd", builtin.lsp_definitions, "[G]oto [D]efinition")

  lsp_map("n", "gr", builtin.lsp_references, '[G]oto [R]eferences')

  lsp_map("n", "gI", builtin.lsp_implementations, '[G]oto [I]mplementation')

  lsp_map("n", "<leader>D", builtin.lsp_type_definitions, 'Type [D]efinition')

  lsp_map('n', '<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')

  lsp_map('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  lsp_map("n", "<leader>rn", vim.lsp.buf.rename, '[R]e[n]ame')

  lsp_map({ "n", "x", "v" }, "<leader>ca", vim.lsp.buf.code_action, '[C]ode [A]ction')

  lsp_map("n", "K", vim.lsp.buf.hover, "Hover Documentation")

  lsp_map("n", "gk", function()
    builtin.lsp_definitions(themes.get_ivy { jump_type = "vsplit" })
  end, "Hover Documentation Vertically")

  lsp_map("n", "gD", vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  lsp_map("n", "[d", vim.diagnostic.goto_prev, "[D]iagnostic [P]revious")

  lsp_map("n", "]d", vim.diagnostic.goto_next, "[D]iagnostic [N]ext")

  lsp_map("n", "<leader>e", vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

  lsp_map("i", "<C-K>", vim.lsp.buf.signature_help, "[S]ignature [H]elp")
end

return M

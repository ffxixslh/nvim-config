local formatters_by_ft = {
  css = { 'prettierd', 'stylelint' },
  html = { 'prettierd' },
  javascript = { 'biome', 'eslint_d', 'prettierd' },
  javascriptreact = { 'biome', 'eslint_d', 'prettierd' },
  json = { 'prettierd' },
  jsonc = { 'prettierd' },
  lua = { 'stylua' },
  typescript = { 'biome', 'eslint_d', 'prettierd' },
  typescriptreact = { 'biome', 'eslint_d', 'prettierd' },
  vue = { 'eslint_d', 'prettierd' },
  yaml = { 'prettierd' },
}

for _, value in pairs(formatters_by_ft) do
  value['stop_after_first'] = true
end

local formatter_data = {
  prettier = {
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.yml',
    '.prettierrc.yaml',
    '.prettierrc.json5',
    '.prettierrc.js',
    '.prettierrc.cjs',
    '.prettierrc.mjs',
    '.prettierrc.toml',
    'prettier.config.js',
    'prettier.config.cjs',
    'prettier.config.mjs',
  },
  eslint_d = {
    '.eslintrc',
    '.eslintrc.json',
    'eslint.config.js',
    'eslint.config.cjs',
    'eslint.config.mjs',
  },
  biome = {
    'biome.json',
    'biome.jsonc',
  },
}

-- References:
-- https://github.com/asilvadesigns/config/blob/87adf2bdc22c4ca89d1b06b013949d817b405e77/nvim/lua/plugins/conform.lua
-- Find closest config file to the current buffer
---@param config_names string[]
---@param current_buffer_path string
local function find_closest_config_file(config_names, current_buffer_path)
  if config_names == nil then
    return nil
  end
  for _, config_name in ipairs(config_names) do
    local found = vim.fs.find(config_name, {
      upward = true,
      path = vim.fn.fnamemodify(current_buffer_path, ':p:h'),
    })
    if #found > 0 then
      return found[1] -- Return the closest config file found
    end
  end
  return nil -- No config file found
end

--- Check if the config file exists. If not, return false
---@param formatter_name string
local function check_formatter_config_exists(formatter_name)
  return function()
    local current_buffer_path = vim.api.nvim_buf_get_name(0)
    local config_file = find_closest_config_file(formatter_data[formatter_name], current_buffer_path)
    return config_file ~= nil
  end
end

return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = formatters_by_ft,
    formatters = {
      biome = {
        condition = check_formatter_config_exists 'biome',
      },
      eslint_d = {
        condition = check_formatter_config_exists 'eslint_d',
      },
    },
  },
}

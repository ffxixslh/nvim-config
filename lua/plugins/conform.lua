local formatters_by_ft = {
  css = { 'prettierd', 'stylelint' },
  html = { 'prettierd' },
  javascript = { 'eslint_d', 'prettierd' },
  javascriptreact = { 'eslint_d', 'prettierd' },
  json = { 'prettierd' },
  jsonc = { 'prettierd' },
  lua = { 'stylua' },
  typescript = { 'eslint_d', 'prettierd' },
  typescriptreact = { 'eslint_d', 'prettierd' },
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
---@param config_names string[]
local function find_closest_config_file(config_names)
  if config_names == nil then
    return nil
  end
  for _, config_name in ipairs(config_names) do
    local found = vim.fs.find(config_name, {
      path = '.',
    })
    if #found > 0 then
      return found[1] -- Return the closest config file found
    end
  end
  return nil -- No config file found
end

return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = formatters_by_ft,
    formatters = {
      biome = {
        condition = function()
          local config_file = find_closest_config_file(formatter_data['biome'])
          return config_file ~= nil
        end,
      },
      eslint_d = {
        condition = function()
          local config_file = find_closest_config_file(formatter_data['eslint_d'])
          return config_file ~= nil
        end,
      },
      prettierd = {
        condition = function()
          local config_file = find_closest_config_file(formatter_data['prettierd'])
          return config_file ~= nil
        end,
      },
    },
  },
}

return {
  'neovim/nvim-lspconfig',
  opts = function()
    require('lspconfig').biome.setup {}
  end,
}

return {
  'nvim-telescope/telescope.nvim',
  opts = {
    defaults = {
      file_ignore_patterns = {
        'node_modules/',
        'dist/',
        '.next/',
        '.umi/',
        '.vscode/',
        '.git/',
        '.gitlab/',
        'build/',
        'target/',
        'package-lock.json',
        'pnpm-lock.yaml',
        'yarn.lock',
      },
    },
  },
}

-- VSCode Neovim mappings converted from wojukasz/VimCode.
-- This file lives in lua/plugins so Lazy.nvim loads it with the rest of LazyVim.

if not vim.g.vscode then
  return {}
end

local ok, vscode = pcall(require, "vscode")
if not ok then
  return {}
end

local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 8

if vim.g.vscode_clipboard then
  vim.g.clipboard = vim.g.vscode_clipboard
end

local function opts(desc)
  return { silent = true, noremap = true, desc = desc }
end

local function action(command, args)
  return function()
    vscode.action(command, args and { args = args } or nil)
  end
end

local function call(command, args)
  return function()
    vscode.call(command, args and { args = args } or nil)
  end
end

local function clear_search()
  vim.cmd("nohlsearch")
end

local function find_word()
  vscode.action("workbench.action.findInFiles", {
    args = { query = vim.fn.expand("<cword>") },
  })
end

local function cycle_config(name, values)
  local current = vscode.get_config(name)
  local next_value = values[1]

  for index, value in ipairs(values) do
    if value == current then
      next_value = values[(index % #values) + 1]
      break
    end
  end

  vscode.update_config(name, next_value, "global")
end

-- Insert mode
map("i", "jk", "<Esc>", opts("Escape"))
map("i", "jj", "<Esc>", opts("Escape"))

-- General
map("n", "<Esc>", clear_search, opts("Clear search highlight"))
map("n", "<C-n>", clear_search, opts("Clear search highlight"))
map("n", "K", action("editor.action.showHover"), opts("Hover"))
map("n", "<leader>K", action("editor.action.showHover"), opts("Keywordprg / hover"))
map("n", "<leader>l", "<cmd>Lazy<cr>", opts("Lazy"))
map("n", "<leader>L", function()
  if LazyVim and LazyVim.news then
    LazyVim.news.changelog()
  else
    vim.cmd("Lazy")
  end
end, opts("LazyVim changelog"))
map({ "n", "x" }, "<A-j>", action("editor.action.moveLinesDownAction"), opts("Move line down"))
map({ "n", "x" }, "<A-k>", action("editor.action.moveLinesUpAction"), opts("Move line up"))

-- Files
map("n", "<leader><space>", action("workbench.action.quickOpen"), opts("Find files"))
map("n", "<leader>,", action("workbench.action.showAllEditors"), opts("Switch buffer"))
map({ "n", "x" }, "<leader>/", action("workbench.action.findInFiles"), opts("Search in files"))
map("n", "<leader>:", action("workbench.action.showCommands"), opts("Command palette"))
map("n", "<leader>ff", action("workbench.action.quickOpen"), opts("Find files"))
map("n", "<leader>fF", action("workbench.action.quickOpen"), opts("Find files (cwd)"))
map("n", "<leader>fg", action("workbench.action.quickOpen"), opts("Find git files"))
map("n", "<leader>fr", action("workbench.action.openRecent"), opts("Recent files"))
map("n", "<leader>fR", action("workbench.action.openRecent"), opts("Recent files (cwd)"))
map("n", "<leader>fn", action("workbench.action.files.newUntitledFile"), opts("New file"))
map("n", "<leader>fc", action("workbench.action.openSettingsJson"), opts("Find config file"))
map("n", "<leader>fp", action("workbench.action.openRecent"), opts("Projects"))
map("n", "<leader>fb", action("workbench.action.showAllEditors"), opts("Buffers"))
map("n", "<leader>fe", action("workbench.files.action.focusFilesExplorer"), opts("Explorer"))
map("n", "<leader>fE", action("workbench.view.explorer"), opts("Explorer (cwd)"))
map("n", "<leader>ft", action("workbench.action.terminal.toggleTerminal"), opts("Toggle terminal"))
map("n", "<leader>fT", action("workbench.action.terminal.toggleTerminal"), opts("Toggle terminal (cwd)"))
map("n", "<leader>e", action("workbench.files.action.focusFilesExplorer"), opts("Explorer"))
map("n", "<leader>E", action("workbench.view.explorer"), opts("Explorer (cwd)"))

-- Search
map("n", "<leader>s/", action("workbench.action.findInFiles"), opts("Search history"))
map("n", "<leader>sg", action("workbench.action.findInFiles"), opts("Grep"))
map("n", "<leader>sG", action("workbench.action.findInFiles"), opts("Grep (cwd)"))
map("n", "<leader>sw", find_word, opts("Search word"))
map("n", "<leader>sW", find_word, opts("Search word (cwd)"))
map("n", "<leader>sr", action("workbench.action.replaceInFiles"), opts("Replace in files"))
map("n", "<leader>ss", action("workbench.action.gotoSymbol"), opts("Document symbols"))
map("n", "<leader>sS", action("workbench.action.showAllSymbols"), opts("Workspace symbols"))
map("n", "<leader>sd", action("workbench.actions.view.problems"), opts("Diagnostics"))
map("n", "<leader>sD", action("workbench.action.problems.focus"), opts("Buffer diagnostics"))
map("n", "<leader>sk", action("workbench.action.openGlobalKeybindings"), opts("Keymaps"))
map("n", "<leader>sc", action("workbench.action.showCommands"), opts("Command palette"))
map("n", "<leader>sC", action("workbench.action.showCommands"), opts("Commands"))
map("n", "<leader>sh", action("workbench.action.showCommands"), opts("All commands"))
map("n", "<leader>sl", action("workbench.action.problems.focus"), opts("Location list"))
map("n", "<leader>sq", action("workbench.action.problems.focus"), opts("Quickfix list"))
map("n", "<leader>sR", action("workbench.action.findInFiles"), opts("Resume search"))

-- Code / LSP
map({ "n", "x" }, "<leader>ca", action("editor.action.quickFix"), opts("Code action"))
map({ "n", "x" }, "<leader>cA", action("editor.action.sourceAction"), opts("Source action"))
map("n", "<leader>cf", call("editor.action.formatDocument"), opts("Format document"))
map("x", "<leader>cf", call("editor.action.formatSelection"), opts("Format selection"))
map("n", "<leader>cF", call("editor.action.formatSelection"), opts("Format selection"))
map("x", "<leader>cF", call("editor.action.formatSelection"), opts("Format selection"))
map("n", "<leader>cr", action("editor.action.rename"), opts("Rename"))
map("n", "<leader>cd", action("editor.action.showHover"), opts("Line diagnostics"))
map("n", "<leader>cl", action("workbench.action.problems.focus"), opts("Problems"))
map("n", "<leader>co", action("editor.action.organizeImports"), opts("Organize imports"))
map({ "n", "x" }, "<leader>cc", action("editor.action.commentLine"), opts("Toggle comment"))
map("n", "<leader>cR", action("workbench.files.action.showActiveFileInExplorer"), opts("Rename file"))
map("n", "<leader>cs", action("workbench.action.gotoSymbol"), opts("Document symbols"))
map("x", "gc", action("editor.action.commentLine"), opts("Toggle comment"))

-- Go to
map("n", "gd", action("editor.action.revealDefinition"), opts("Goto definition"))
map("n", "gD", action("editor.action.revealDeclaration"), opts("Goto declaration"))
map("n", "gr", action("editor.action.goToReferences"), opts("References"))
map("n", "gI", action("editor.action.goToImplementation"), opts("Implementation"))
map("n", "gy", action("editor.action.goToTypeDefinition"), opts("Type definition"))
map("n", "gK", action("editor.action.triggerParameterHints"), opts("Signature help"))

map("n", "<leader>Gd", action("editor.action.revealDefinition"), opts("Goto definition"))
map("n", "<leader>GD", action("editor.action.revealDeclaration"), opts("Goto declaration"))
map("n", "<leader>Gr", action("editor.action.goToReferences"), opts("References"))
map("n", "<leader>GI", action("editor.action.goToImplementation"), opts("Implementation"))
map("n", "<leader>Gy", action("editor.action.goToTypeDefinition"), opts("Type definition"))
map("n", "<leader>GK", action("editor.action.triggerParameterHints"), opts("Signature help"))
map("n", "<leader>Gh", action("editor.action.showHover"), opts("Hover"))

-- Buffers / editors
map("n", "<S-h>", action("workbench.action.previousEditor"), opts("Previous editor"))
map("n", "<S-l>", action("workbench.action.nextEditor"), opts("Next editor"))
map(
  "n",
  "<leader>bb",
  action("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup"),
  opts("Switch to other buffer")
)
map("n", "<leader>bB", action("workbench.action.showAllEditors"), opts("Switch buffer"))
map("n", "<leader>bd", action("workbench.action.closeActiveEditor"), opts("Close buffer"))
map("n", "<leader>bD", action("workbench.action.closeActiveEditor"), opts("Delete buffer and window"))
map("n", "<leader>bi", action("workbench.action.closeEditorsInOtherGroups"), opts("Delete invisible buffers"))
map("n", "<leader>bo", action("workbench.action.closeOtherEditors"), opts("Close other buffers"))
map("n", "<leader>bp", action("workbench.action.pinEditor"), opts("Toggle pin"))
map("n", "<leader>bP", action("workbench.action.unpinEditor"), opts("Unpin buffer"))
map("n", "<leader>b[", action("workbench.action.previousEditor"), opts("Previous buffer"))
map("n", "<leader>b]", action("workbench.action.nextEditor"), opts("Next buffer"))
map("n", "<leader>`", action("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup"), opts("Alternate buffer"))

-- Git. Git Graph and GitCharm commands use the locally installed VSCode extensions.
map("n", "<leader>gg", action("workbench.view.scm"), opts("Git status"))
map("n", "<leader>gG", action("workbench.view.scm"), opts("Git status (cwd)"))
map("n", "<leader>gs", action("workbench.view.scm"), opts("Git status"))
map("n", "<leader>gb", action("gitcharm.openGitAnnotations"), opts("Git blame"))
map("n", "<leader>gB", action("gitcharm.openLog"), opts("Git browse / log"))
map("n", "<leader>gd", action("git.openChange"), opts("Git diff"))
map("n", "<leader>gf", action("gitcharm.showFileHistory"), opts("Current file history"))
map("n", "<leader>gl", action("git-graph.view"), opts("Git log"))
map("n", "<leader>gL", action("git-graph.view"), opts("Git log (cwd)"))
map("n", "<leader>gc", action("gitcharm.commit"), opts("Commit"))
map("n", "<leader>ghn", action("workbench.action.editor.nextChange"), opts("Next hunk"))
map("n", "<leader>ghp", action("workbench.action.editor.previousChange"), opts("Previous hunk"))
map("n", "<leader>ghs", action("git.stageSelectedRanges"), opts("Stage selected ranges"))
map("n", "<leader>ghr", action("git.revertSelectedRanges"), opts("Revert selected ranges"))

-- Windows / editor groups
map("n", "<leader>wd", action("workbench.action.closeActiveEditor"), opts("Close window"))
map("n", "<leader>ww", action("workbench.action.focusNextGroup"), opts("Next window"))
map("n", "<leader>wm", action("workbench.action.toggleEditorWidths"), opts("Maximize window"))
map("n", "<leader>-", action("workbench.action.splitEditorDown"), opts("Split below"))
map("n", "<leader>|", action("workbench.action.splitEditorRight"), opts("Split right"))
map("n", "<leader>ws", action("workbench.action.splitEditorDown"), opts("Split below"))
map("n", "<leader>wv", action("workbench.action.splitEditorRight"), opts("Split right"))
map("n", "<leader>wh", action("workbench.action.focusLeftGroup"), opts("Focus left"))
map("n", "<leader>wj", action("workbench.action.focusBelowGroup"), opts("Focus down"))
map("n", "<leader>wk", action("workbench.action.focusAboveGroup"), opts("Focus up"))
map("n", "<leader>wl", action("workbench.action.focusRightGroup"), opts("Focus right"))
map("n", "<leader>w=", action("workbench.action.increaseViewWidth"), opts("Increase width"))
map("n", "<leader>w-", action("workbench.action.decreaseViewWidth"), opts("Decrease width"))
map("n", "<leader>w+", action("workbench.action.increaseViewHeight"), opts("Increase height"))
map("n", "<leader>w_", action("workbench.action.decreaseViewHeight"), opts("Decrease height"))
map("n", "<leader>w1", action("workbench.action.focusFirstEditorGroup"), opts("Focus group 1"))
map("n", "<leader>w2", action("workbench.action.focusSecondEditorGroup"), opts("Focus group 2"))
map("n", "<leader>w3", action("workbench.action.focusThirdEditorGroup"), opts("Focus group 3"))

-- Tabs
map("n", "<leader><tab><tab>", action("workbench.action.files.newUntitledFile"), opts("New tab"))
map("n", "<leader><tab>]", action("workbench.action.nextEditor"), opts("Next tab"))
map("n", "<leader><tab>[", action("workbench.action.previousEditor"), opts("Previous tab"))
map("n", "<leader><tab>d", action("workbench.action.closeActiveEditor"), opts("Close tab"))
map("n", "<leader><tab>f", action("workbench.action.firstEditorInGroup"), opts("First tab"))
map("n", "<leader><tab>l", action("workbench.action.lastEditorInGroup"), opts("Last tab"))
map("n", "<leader><tab>o", action("workbench.action.closeOtherEditors"), opts("Close other tabs"))

-- Diagnostics / quickfix-like navigation
map("n", "<leader>xx", action("workbench.action.problems.focus"), opts("Diagnostics"))
map("n", "<leader>xX", action("workbench.actions.view.problems"), opts("Workspace diagnostics"))
map("n", "<leader>xl", action("workbench.action.problems.focus"), opts("Location list"))
map("n", "<leader>xq", action("workbench.action.problems.focus"), opts("Quickfix list"))
map("n", "[d", action("editor.action.marker.prevInFiles"), opts("Previous diagnostic"))
map("n", "]d", action("editor.action.marker.nextInFiles"), opts("Next diagnostic"))
map("n", "[e", action("editor.action.marker.prev"), opts("Previous error"))
map("n", "]e", action("editor.action.marker.next"), opts("Next error"))
map("n", "[q", action("search.action.focusPreviousSearchResult"), opts("Previous search result"))
map("n", "]q", action("search.action.focusNextSearchResult"), opts("Next search result"))
map("n", "[b", action("workbench.action.previousEditor"), opts("Previous buffer"))
map("n", "]b", action("workbench.action.nextEditor"), opts("Next buffer"))
map("n", "[h", action("workbench.action.editor.previousChange"), opts("Previous hunk"))
map("n", "]h", action("workbench.action.editor.nextChange"), opts("Next hunk"))

-- UI toggles
map("n", "<leader>uw", action("editor.action.toggleWordWrap"), opts("Toggle word wrap"))
map("n", "<leader>uz", action("workbench.action.toggleZenMode"), opts("Toggle zen mode"))
map("n", "<leader>uZ", action("workbench.action.toggleEditorWidths"), opts("Toggle window zoom"))
map("n", "<leader>uC", action("workbench.action.selectTheme"), opts("Colorscheme"))
map("n", "<leader>uh", function()
  cycle_config("editor.inlayHints.enabled", { "on", "off" })
end, opts("Toggle inlay hints"))
map("n", "<leader>um", action("editor.action.toggleMinimap"), opts("Toggle minimap"))
map("n", "<leader>ur", clear_search, opts("Clear search highlight"))
map("n", "<leader>ul", function()
  cycle_config("editor.lineNumbers", { "on", "relative", "off" })
end, opts("Cycle line numbers"))
map("n", "<leader>uL", function()
  cycle_config("editor.lineNumbers", { "relative", "on" })
end, opts("Toggle relative numbers"))

-- Quit
map("n", "<leader>qq", action("workbench.action.closeWindow"), opts("Close window"))
map("n", "<leader>qa", action("workbench.action.quit"), opts("Quit VSCode"))

return {}

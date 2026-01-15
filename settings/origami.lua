vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

local origami = require("origami")
origami.setup({
  useLspFoldsWithTreesitterFallback = {
    enabled = true,
    foldmethodIfNeitherIsAvailable = "indent",
  },
  pauseFoldsOnSearch = true,
  foldtext = {
    enabled = true,
    padding = 3,
    lineCount = { template = "%d lines", hlgroup = "Comment" },
    diagnosticsCount = true,
    gitsignsCount = true, -- only if you have gitsigns.nvim installed
    disableOnFt = { "snacks_picker_input" },
  },
  autoFold = { enabled = true, kinds = { "comment", "imports" } },
  foldKeymaps = {
    setup = false,
    closeOnlyOnFirstColumn = false,
    scrollLeftOnCaret = false,
  },
})

vim.keymap.set("n", "<Up>",  origami.h)
vim.keymap.set("n", "<Down>", origami.l)
vim.keymap.set("n", "<End>",   origami.dollar)
vim.keymap.set("n", "<Home>",  origami.caret)

-----------------------------------------------------------------------
-- NOICE SETUP
-----------------------------------------------------------------------
require("noice").setup({
  ---------------------------------------------------------------------
  -- LSP markdown + documentation improvements
  ---------------------------------------------------------------------
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },

  ---------------------------------------------------------------------
  -- CENTER CMDLINE RELATIVE TO CURRENT BUFFER
  ---------------------------------------------------------------------
  cmdline = {
    view = "cmdline_popup",
  },

  views = {
    cmdline_popup = {
      relative = "win",        -- ← IMPORTANT: relative to active window
      position = {
        row = 0.5,             -- 0.5 = center vertically
        col = 0.5,             -- 0.5 = center horizontally
      },
      size = {
        width = 60,
        height = "auto",
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
  },

  ---------------------------------------------------------------------
  -- PRESETS
  ---------------------------------------------------------------------
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
})

-----------------------------------------------------------------------
-- NOICE KEYMAPS
-----------------------------------------------------------------------
local noice = require("noice")

vim.keymap.set("n", "<leader>nl", function() noice.cmd("last") end,
    { desc = "Noice: Last Message" })

vim.keymap.set("n", "<leader>nh", function() noice.cmd("history") end,
    { desc = "Noice: Message History" })

vim.keymap.set("n", "<leader>na", function() noice.cmd("all") end,
    { desc = "Noice: All Messages" })

-- vim.keymap.set("n", "<leader>nd", function() noice.cmd("dismiss") end,
  -- { desc = "Noice: Dismiss Messages" })

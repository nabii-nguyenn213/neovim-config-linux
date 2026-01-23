local function hex(n) return string.format("#%06x", n) end

local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
local bg = normal.bg and hex(normal.bg) or "#000000"

require("notify").setup({
  background_colour = bg,
})

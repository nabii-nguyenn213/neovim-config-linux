-- typr.lua (rewritten)
local state = require("typr.state")

-- =======================
-- Typr config
-- =======================
state.config.mode = "words"           -- "words" or "phrases"
state.config.winlayout = "responsive"
state.config.kblayout = "qwerty"
state.config.wpm_goal = 100

state.config.numbers = false
state.config.symbols = false
state.config.random = false
state.config.insert_on_start = true
state.linecount = 6

state.config.stats_filepath = vim.fn.expand("~/.config/nvim/settings/typr/typrstats")
vim.fn.mkdir(vim.fn.fnamemodify(state.config.stats_filepath, ":h"), "p")

state.config.phrases = {
  "the quick brown fox jumps over the lazy dog",
  "neovim is fun",
}

-- IMPORTANT: initializes/restores stats
require("typr").setup()

-- =======================
-- Kitty font bump helpers
-- =======================
local TyprFont = {
  active = false,
  delta = 4, -- font size step
}

local function in_kitty()
  return vim.env.KITTY_WINDOW_ID ~= nil or vim.env.KITTY_LISTEN_ON ~= nil
end

local function kitty_cmd(args)
  -- Prefer `kitten` if available; otherwise `kitty +kitten`
  local base
  if vim.fn.executable("kitten") == 1 then
    base = { "kitten", "@", "set-font-size" }
  else
    base = { "kitty", "+kitten", "@", "set-font-size" }
  end

  vim.list_extend(base, args)
  vim.fn.jobstart(base, { detach = true })
end

local function font_increase()
  if TyprFont.active then return end
  TyprFont.active = true

  if in_kitty() then
    kitty_cmd({ "+" .. TyprFont.delta })
  else
    -- GUI fallback
    local gf = vim.o.guifont or ""
    local size = tonumber(gf:match(":h(%d+)"))
    if size then
      vim.o.guifont = gf:gsub(":h%d+", ":h" .. (size + TyprFont.delta), 1)
    end
  end
end

local function font_restore()
  if not TyprFont.active then return end

  if in_kitty() then
    -- negative needs `--`
    kitty_cmd({ "--", "-" .. TyprFont.delta })
  else
    -- GUI restore not tracked here (best effort)
  end

  TyprFont.active = false
end

-- =======================
-- Open Typr after resize
-- =======================
local function open_typr_centered()
  local opened = false
  local group = vim.api.nvim_create_augroup("TyprOpenAfterResize", { clear = true })

  -- If kitty font change triggers a resize, wait for it so layout centers correctly
  vim.api.nvim_create_autocmd("VimResized", {
    group = group,
    once = true,
    callback = function()
      if opened then return end
      opened = true
      vim.schedule(function()
        vim.cmd("redraw!")
        vim.cmd("Typr")
      end)
    end,
  })

  -- Fallback if VimResized doesn't fire
  vim.defer_fn(function()
    if opened then return end
    opened = true
    vim.cmd("redraw!")
    vim.cmd("Typr")
  end, 160)
end

-- =======================
-- Typr buffer mappings
-- =======================
state.config.mappings = function(buf)
  vim.keymap.set("n", "q", function()
    font_restore()
    vim.cmd("close")
  end, { buffer = buf, silent = true })

  -- Safety: restore if buffer closes another way
  vim.api.nvim_create_autocmd({ "BufHidden", "BufWipeout", "BufDelete" }, {
    buffer = buf,
    once = true,
    callback = font_restore,
  })
end

-- =======================
-- User keymaps
-- =======================
vim.keymap.set("n", "<leader>T", function()
  font_increase()
  open_typr_centered()
end, { silent = true, desc = "Typr (bump kitty font)" })

vim.keymap.set("n", "<leader>Ts", "<cmd>TyprStats<CR>", { silent = true, desc = "Typr stats" })

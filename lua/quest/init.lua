local M = {}

-- =========================
-- Config
-- =========================
local notes_dir = "/home/nabinguyen/Notes/quest_notes"
vim.fn.mkdir(notes_dir, "p")

local cfg = {
    width_ratio = 0.8,
    height_ratio = 0.8,
    title = " Quest ",
    border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
    dim_winblend = 30,
}

vim.api.nvim_set_hl(0, "QuestDim", { bg = "#000000" })

-- =========================
-- State (single active buffer)
-- =========================
local state = {
    buf = -1,
    win = -1,
    dim = { buf = -1, win = -1 },
}

-- =========================
-- Helpers
-- =========================
local function valid_buf(buf)
    return type(buf) == "number" and buf > 0 and vim.api.nvim_buf_is_valid(buf)
end

local function valid_win(win)
    return type(win) == "number" and win > 0 and vim.api.nvim_win_is_valid(win)
end

local function make_footer(width, left, mid, right)
    left, mid, right = left or "", mid or "", right or ""
    local t = {}
    for i = 1, width do t[i] = " " end

    local function put(pos, text)
        for i = 1, #text do
            local p = pos + i - 1
            if p >= 1 and p <= width then
                t[p] = text:sub(i, i)
            end
        end
    end

    local left_pos = 1
    local right_pos = math.max(1, width - #right + 1)
    local mid_pos = math.max(1, math.floor((width - #mid) / 2) + 1)

    put(left_pos, left)
    put(mid_pos, mid)
    put(right_pos, right)
    return table.concat(t)
end

local function get_snacks()
    if _G.Snacks then return _G.Snacks end
    local ok, s = pcall(require, "snacks")
    if ok then return s end
    return nil
end

local function close_float()
    if valid_win(state.win) then vim.api.nvim_win_hide(state.win) end
    if valid_win(state.dim.win) then vim.api.nvim_win_hide(state.dim.win) end
    state.win = -1
    state.dim.win = -1
end

local function new_buf()
    local buf = vim.api.nvim_create_buf(false, true)

    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "hide"
    vim.bo[buf].swapfile = false

    vim.api.nvim_buf_call(buf, function()
        vim.cmd("setfiletype markdown")
    end)

    vim.b[buf].quest_file = nil
    return buf
end


local function ensure_dim_open()
    local width = vim.o.columns
    local height = vim.o.lines

    if not valid_buf(state.dim.buf) then
        state.dim.buf = vim.api.nvim_create_buf(false, true)
        vim.bo[state.dim.buf].buftype = "nofile"
        vim.bo[state.dim.buf].bufhidden = "hide"
        vim.bo[state.dim.buf].swapfile = false
    end

    local base_cfg = {
        relative = "editor",
        row = 0,
        col = 0,
        width = width,
        height = height,
        style = "minimal",
        focusable = false,
        zindex = 1, -- behind Quest
    }

    if valid_win(state.dim.win) then
        -- ✅ noautocmd NOT allowed here
        vim.api.nvim_win_set_config(state.dim.win, base_cfg)
    else
        -- ✅ allowed only on create
        local create_cfg = vim.tbl_extend("force", base_cfg, { noautocmd = true })
        state.dim.win = vim.api.nvim_open_win(state.dim.buf, false, create_cfg)
    end

    vim.wo[state.dim.win].winblend = cfg.dim_winblend
    vim.wo[state.dim.win].winhighlight = "Normal:QuestDim,NormalNC:QuestDim"
end

local function attach_buf_keymaps(buf)
    vim.keymap.set("n", "q", close_float, { buffer = buf, silent = true, nowait = true })
    vim.keymap.set("n", "<Esc>", close_float, { buffer = buf, silent = true, nowait = true })

    vim.keymap.set("n", "<leader>qw", function() M.save(false) end, { buffer = buf, silent = true })
    vim.keymap.set("n", "<leader>qa", function() M.save(true) end,  { buffer = buf, silent = true })
    vim.keymap.set("n", "<leader>qn", function() M.new() end,       { buffer = buf, silent = true })
    vim.keymap.set("n", "<leader>qo", function() M.open() end,      { buffer = buf, silent = true })
end

local function open_float(buf)
    ensure_dim_open()

    local width = math.floor(vim.o.columns * cfg.width_ratio)
    local height = math.floor(vim.o.lines * cfg.height_ratio)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local footer = make_footer(
        width,
        " q/<Esc>: close ",
        " <leader>qn: new  <leader>qo: open ",
        " <leader>qw: save  <leader>qa: save as "
    )

    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        border = cfg.border,
        title = cfg.title,
        title_pos = "center",
        footer = footer,
        footer_pos = "left",
        zindex = 2,
    }

    if valid_win(state.win) then
        vim.api.nvim_win_set_buf(state.win, buf)
        vim.api.nvim_win_set_config(state.win, win_config)
        vim.api.nvim_set_current_win(state.win)
    else
        state.win = vim.api.nvim_open_win(buf, true, win_config)
    end

    attach_buf_keymaps(buf)
end

local function ensure_open()
    if not valid_buf(state.buf) then
        state.buf = new_buf()
    end
    open_float(state.buf)
end

local function load_file_into_quest(path)
    if not path or path == "" then return end
    path = vim.fn.fnamemodify(path, ":p")

    -- If current buffer is an *unsaved scratch* and modified, delete it (your “terminate unsaved” rule)
    if valid_buf(state.buf) and vim.bo[state.buf].modified and (vim.b[state.buf].quest_file == nil) then
        local old = state.buf
        state.buf = new_buf()
        pcall(vim.api.nvim_buf_delete, old, { force = true })
    elseif not valid_buf(state.buf) then
        state.buf = new_buf()
    end

    -- Read file
    local ok, lines = pcall(vim.fn.readfile, path)
    if not ok then
        vim.notify("Quest: failed to read " .. path, vim.log.levels.ERROR)
        return
    end

    -- Show quest and load contents
    open_float(state.buf)
    vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)

    vim.b[state.buf].quest_file = path
    vim.api.nvim_buf_set_name(state.buf, path)
    vim.bo[state.buf].modified = false
end

-- =========================
-- Save
-- =========================
function M.save(force_save_as)
    if not valid_buf(state.buf) then
        vim.notify("Quest: no buffer to save", vim.log.levels.ERROR)
        return
    end

    local target_buf = state.buf
    local current_file = vim.b[target_buf].quest_file

    local function write_to(path)
        if not valid_buf(target_buf) then
            vim.notify("Quest: buffer disappeared before saving", vim.log.levels.ERROR)
            return
        end
        local lines = vim.api.nvim_buf_get_lines(target_buf, 0, -1, false)
        vim.fn.writefile(lines, path)

        vim.b[target_buf].quest_file = path
        vim.api.nvim_buf_set_name(target_buf, path)
        vim.bo[target_buf].modified = false
        vim.notify("Saved: " .. path)
    end

    if current_file and not force_save_as then
        write_to(current_file)
        return
    end

    local default = current_file and vim.fn.fnamemodify(current_file, ":t") or "note.md"
    vim.ui.input({ prompt = "Save Quest as: ", default = default }, function(name)
        if not name or name == "" then return end
        if not name:match("%.%w+$") then name = name .. ".md" end
        write_to(notes_dir .. "/" .. name)
    end)
end

-- =========================
-- New buffer (DISCARD old if unsaved)
-- =========================
function M.new()
    local old = state.buf
    local buf = new_buf()
    state.buf = buf
    open_float(buf)

    if valid_buf(old) then
        local old_unsaved = vim.bo[old].modified and (vim.b[old].quest_file == nil)
        if old_unsaved then
            pcall(vim.api.nvim_buf_delete, old, { force = true })
        end
    end
end

-- =========================
-- Open file using Snacks.picker
-- =========================
function M.open()
    local Snacks = get_snacks()
    if not Snacks or not Snacks.picker or not Snacks.picker.files then
        vim.notify("Quest: Snacks.picker not available", vim.log.levels.ERROR)
        return
    end

    Snacks.picker.files({
        cwd = notes_dir,
        -- files picker uses `confirm`, not `on_select` :contentReference[oaicite:2]{index=2}
        confirm = function(picker, item)
            -- Try common fields; files items usually have `item.file`
            local path = (item and (item.file or item.path)) or nil
            if not path then
                -- fallback: some items store in `text`
                path = item and item.text or nil
            end
            if path and not path:match("^/") and picker and picker.dir then
                path = picker:dir() .. "/" .. path
            end

            -- Close picker first (best-effort)
            if picker then
                if picker.close then
                    pcall(function() picker:close() end)
                elseif picker.action then
                    pcall(function() picker:action("close") end)
                end
            end

            load_file_into_quest(path)
        end,
    })
end

-- =========================
-- Commands + Keymaps
-- =========================
vim.api.nvim_create_user_command("Quest", function()
    if valid_win(state.win) then close_float() else ensure_open() end
end, { desc = "Toggle Quest" })

vim.api.nvim_create_user_command("QuestNew", function() M.new() end, { desc = "New Quest (discard unsaved old)" })
vim.api.nvim_create_user_command("QuestSave", function() M.save(false) end, { desc = "Save Quest" })
vim.api.nvim_create_user_command("QuestSaveAs", function() M.save(true) end, { desc = "Save Quest As" })
vim.api.nvim_create_user_command("QuestOpen", function() M.open() end, { desc = "Open note into Quest" })

vim.keymap.set("n", "<leader>qq", "<cmd>Quest<CR>", { desc = "Toggle Quest" })
vim.keymap.set("n", "<leader>qn", "<cmd>QuestNew<CR>", { desc = "New Quest (discard unsaved old)" })
vim.keymap.set("n", "<leader>qw", "<cmd>QuestSave<CR>", { desc = "Save Quest" })
vim.keymap.set("n", "<leader>qa", "<cmd>QuestSaveAs<CR>", { desc = "Save Quest As" })
vim.keymap.set("n", "<leader>qo", "<cmd>QuestOpen<CR>", { desc = "Open Quest note" })

return M

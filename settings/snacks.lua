local ok, Snacks = pcall(require, "snacks")
if not ok then
    return
end


Snacks.setup({
    bigfile = { 
        enabled = true 
    },
    explorer  = { 
        enabled = true, 
        replace_netrw = false,
    },
    indent    = { 
        enabled = true 
    },
    input     = { 
        enabled = true
    },
    notifier  = { 
        enabled = true, 
        timeout = 3000 
    },
    picker = {
        enabled = true,
        layouts = { 
            default = { 
                layout = {
                    box = "horizontal",
                    width = 0.8,
                    min_width = 120,
                    height = 0.8,
                    {
                        box = "vertical",
                        border = true,
                        title = "{title} {live} {flags}",
                        { win = "input", height = 1, border = "bottom" },
                        { win = "list", border = "none" },
                    },
                    { win = "preview", title = "{preview}", border = true, width = 0.5 },
                },
            }, 
            dropdown = {
                layout = {
                    backdrop = false,
                    row = 1,
                    width = 0.4,
                    min_width = 80,
                    height = 0.8,
                    border = "none",
                    box = "vertical",
                    { win = "preview", title = "{preview}", height = 0.4, border = true },
                    {
                        box = "vertical",
                        border = true,
                        title = "{title} {live} {flags}",
                        title_pos = "center",
                        { win = "input", height = 1, border = "bottom" },
                        { win = "list", border = "none" },
                    },
                },
            },  
            ivy = {
                layout = {
                    box = "vertical",
                    backdrop = false,
                    row = -1,
                    width = 0,
                    height = 0.4,
                    border = "top",
                    title = " {title} {live} {flags}",
                    title_pos = "left",
                    { win = "input", height = 1, border = "bottom" },
                    {
                        box = "horizontal",
                        { win = "list", border = "none" },
                        { win = "preview", title = "{preview}", width = 0.6, border = "left" },
                    },
                },
            }, 
            ivy_split = {
                preview = "main",
                layout = {
                    box = "vertical",
                    backdrop = false,
                    width = 0,
                    height = 0.4,
                    position = "bottom",
                    border = "top",
                    title = " {title} {live} {flags}",
                    title_pos = "left",
                    { win = "input", height = 1, border = "bottom" },
                    {
                        box = "horizontal",
                        { win = "list", border = "none" },
                        { win = "preview", title = "{preview}", width = 0.6, border = "left" },
                    },
                },
            }, 
            select = {
                hidden = { "preview" },
                layout = {
                    backdrop = false,
                    width = 0.5,
                    min_width = 80,
                    max_width = 100,
                    height = 0.4,
                    min_height = 2,
                    box = "vertical",
                    border = true,
                    title = "{title}",
                    title_pos = "center",
                    { win = "input", height = 1, border = "bottom" },
                    { win = "list", border = "none" },
                    { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                },
            }, 
            sidebar = {
                preview = "main",
                layout = {
                    backdrop = false,
                    width = 40,
                    min_width = 40,
                    height = 0,
                    position = "right",
                    border = "none",
                    box = "vertical",
                    {
                        win = "input",
                        height = 1,
                        border = true,
                        title = "{title} {live} {flags}",
                        title_pos = "center",
                    },
                    { win = "list", border = "none" },
                    { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                },
            }, 
            telescope = {
                reverse = true,
                layout = {
                    box = "horizontal",
                    backdrop = false,
                    width = 0.8,
                    height = 0.9,
                    border = "none",
                    {
                        box = "vertical",
                        { win = "list", title = " Results ", title_pos = "center", border = true },
                        { win = "input", height = 1, border = true, title = "{title} {live} {flags}", title_pos = "center" },
                    },
                    {
                        win = "preview",
                        title = "{preview:Preview}",
                        width = 0.45,
                        border = true,
                        title_pos = "center",
                    },
                },
            }, 
            vertical = { 
                layout = {
                    backdrop = false,
                    width = 0.5,
                    min_width = 80,
                    height = 0.8,
                    min_height = 30,
                    box = "vertical",
                    border = true,
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                    { win = "input", height = 1, border = "bottom" },
                    { win = "list", border = "none" },
                    { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                },    
            }, 
            vscode = {
                hidden = { "preview" },
                layout = {
                    backdrop = false,
                    row = 1,
                    width = 0.4,
                    min_width = 80,
                    height = 0.4,
                    border = "none",
                    box = "vertical",
                    { win = "input", height = 1, border = true, title = "{title} {live} {flags}", title_pos = "center" },
                    { win = "list", border = "hpad" },
                    { win = "preview", title = "{preview}", border = true },
                },
            },
        },
        sources = {
            explorer = {
                finder = "explorer",
                sort = { fields = { "sort" } },
                supports_live = true,
                tree = true,
                watch = true,
                diagnostics = true,
                diagnostics_open = false,
                git_status = true,
                git_status_open = false,
                git_untracked = true,
                hidden = true,
                follow_file = true,
                focus = "list",
                auto_close = false,
                jump = { close = false },

                layout = {
                    preset = "sidebar",
                    cycle = false, 
                    preview = false,
                },

                formatters = {
                    file = { filename_only = true },
                    severity = { pos = "right" },
                },

                matcher = { sort_empty = false, fuzzy = false },

                -- ✅ explorer keymaps live here:
                win = {
                    list = {
                        keys = {
                            ["<Esc>"] = "close", 

                            ["<BS>"] = "explorer_up",
                            ["o"] = "confirm",
                            -- ["<C-t>"] = "explorer_close",

                            ["a"] = "explorer_add",
                            ["d"] = "explorer_del",
                            ["r"] = "explorer_rename",
                            ["y"] = "explorer_copy",
                            ["O"] = "explorer_open",
                            ["P"] = "toggle_preview",
                            ["u"] = "explorer_paste",

                            ["<F3>"] = { "explorer_update", mode = { "n" } },
                            ["<leader>/"] = { "picker_grep", mode = { "n" } },
                            ["m"] = "explorer_move",

                            ["I"] = "toggle_ignored",
                            ["Z"] = "explorer_close_all",
                        },
                    },
                },
            },
        },
    },
    quickfile   = { 
        enabled = true 
    },
    scratch = {
        enabled = true
    }, 
    scope       = { 
        enabled = true, 
    },
    scroll      = { 
        enabled = true, 
        -- animation settings
        animate = {
            duration = { step = 10, total = 200 },
            easing = "linear",
        },
        -- faster animation when repeating scroll after delay
        animate_repeat = {
            delay = 100, -- delay in ms before using the repeat animation
            duration = { step = 5, total = 50 },
            easing = "linear",
        },
        -- what buffers to animate
        filter = function(buf)
            return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= "terminal"
        end,
    },
    image = {
        enabled = true, 
        -- Document rendering (markdown/latex/html/typst/...)
        doc = {
            enabled = true,

            -- Kitty supports placeholders, so inline works.
            -- Inline takes precedence over float when available. :contentReference[oaicite:1]{index=1}
            inline = true,
            float = true, -- fallback (also used by hover)

            max_width = 80,
            max_height = 30,

            -- Optional: hide only math markup when inline-rendering,
            -- keeps normal image links visible. :contentReference[oaicite:2]{index=2}
            conceal = function(lang, type)
                return type == "math"
            end,
        },

        -- LaTeX/Typst math rendering
        math = {
            enabled = true, -- there is an explicit toggle for math rendering :contentReference[oaicite:3]{index=3}
            latex = {
                -- default is "Large"; drop to "normalsize" if equations feel huge :contentReference[oaicite:4]{index=4}
                font_size = "Large",
                -- packages are configurable; defaults include amsmath/amssymb/... :contentReference[oaicite:5]{index=5}
                packages = { "amsmath", "amssymb", "amsfonts", "mathtools" },
            },
        },

        -- Optional: show a notification if conversion fails (debugging)
        convert = {
            notify = true, -- default is false :contentReference[oaicite:6]{index=6}
        },
    },
    statuscolumn = { 
        enabled = true 
    },
    words       = { 
        enabled = true 
    },
    styles = { 
        notification = {}, 
        dashboard = {
            win = {
                input = {
                    keys = {
                        ["F"] = { "preview_scroll_up", mode = { "n", "i" } },
                        ["S"] = { "preview_scroll_down", mode = { "n", "i" } },
                        ["R"] = { "preview_scroll_left", mode = { "n", "i" } },
                        ["T"] = { "preview_scroll_right", mode = { "n", "i" } },
                    },
                },
            },
        },
    },
    dashboard = {
        enabled = true,
        preset = {
            keys = {
                {
                    icon = " ",
                    key = "F",
                    desc = "Find File",
                    action = function()
                        Snacks.dashboard.pick("files", { cwd = "~/" })
                    end,
                },
                { icon = " ", key = "N", desc = "New File", action = ":ene | startinsert" },
                {
                    icon = " ",
                    key = "R",
                    desc = "Recent Files",
                    action = function()
                        Snacks.dashboard.pick("recent")
                    end,
                },
                {
                    icon = " ",
                    key = "C",
                    desc = "Config",
                    action = function()
                        Snacks.dashboard.pick("files", {
                            cwd = vim.fn.stdpath("config"),
                        })
                    end,
                },
                {
                    icon = " ",
                    key = "c",
                    desc = "Code Space",
                    action = function()
                        Snacks.dashboard.pick("files", {
                            cwd = "~/Dev/",
                        })
                    end,
                },
                {
                    icon = " ",
                    key = "n",
                    desc = "Notes",
                    action = function()
                        Snacks.dashboard.pick("files", {
                            cwd = "~/Notes/",
                        })
                    end,
                },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },

            header = [[
            ███╗   ██╗ █████╗ ██████╗ ██╗
            ████╗  ██║██╔══██╗██╔══██╗██║
            ██╔██╗ ██║███████║██████╔╝██║
            ██║╚██╗██║██╔══██║██╔══██╗██║
            ██║ ╚████║██║  ██║██████╔╝██║
            ╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝ ╚═╝]],

        },
        -- --chafa
        -- sections = {
        --     { section = "header" , align = "center", padding = 1},
        --
        --     -- Left pane: chafa
        --     {
        --         pane = 1,
        --         section = "terminal",
        --         -- bash -lc makes ~ expansion work and loads PATH like your shell
        --         cmd = { "bash", "-lc",
        --         "chafa ~/Pictures/backgrounds/wallpaper_1.jpg --format symbols --symbols vhalf --size 60x17 --stretch --clear; sleep 0.1"
        --         },
        --         height = 17,
        --         padding = 1,
        --         ttl = 0, -- disable caching while you test
        --     },
        --
        --     -- Right pane: keys + startup
        --     { pane = 2, section = "keys", gap = 1, padding = 1 },
        --     { pane = 2, section = "startup" },
        -- },

        sections = {
            { section = "header" },
            {
                pane = 2,
                section = "terminal",
                -- cmd = "colorscript -e square",
                cmd = { "bash", "-lc", "TERM=xterm-256color colorscript -e square" },
                height = 5,
                padding = 1,
            },
            { section = "keys", gap = 1, padding = 1 },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
            {
                pane = 2,
                icon = " ",
                title = "Git Status",
                section = "terminal",
                enabled = function()
                    return Snacks.git.get_root() ~= nil
                end,
                cmd = "git status --short --branch --renames",
                height = 5,
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
            },
            { section = "startup" },
        },

    },
})

-- =======================
-- Keymaps (basic set)
-- =======================

local map = vim.keymap.set
local opts = { 
    noremap = true, 
    silent = true 
}

-- Top pickers & explorer
map("n", "<leader>fm", function() Snacks.picker.smart({

}) end, vim.tbl_extend("force", opts, { desc = "Smart Find Files" }))

map("n", "<leader><space>", function() Snacks.picker.buffers({
    on_show = function()
        vim.cmd.stopinsert()
    end, 
    finder = "buffers", 
    format = "buffer", 
    unloaded = true, 
    sort_lastused = true, 
    current = true, 
    win = {
        input = { 
            keys = { 
                ["Esc"] = {"close", mode = {"n", "i"}}, 

                ["F"] = {"preview_scroll_up", mode = {"n", "i"}}, 
                ["S"] = {"preview_scroll_down", mode = {"n", "i"}}, 
                ["R"] = {"preview_scroll_left", mode = {"n", "i"}}, 
                ["T"] = {"preview_scroll_right", mode = {"n", "i"}}, 

                ["d"] = "bufdelete", 
            },  
        },
        list = { 
            keys = { 
                ["d"] = "bufdelete" 
            }, 
        }, 
    }, 
}) end, vim.tbl_extend("force", opts, { desc = "Buffers" }))

-- <leader>e to open explorer in current folder 
vim.keymap.set("n", "<leader>e", function() Snacks.explorer({ 
    cwd = vim.fn.expand("%:p:h"), 
}) end, { desc = "Explorer" })

--type Config in cmdline to open Config folder (C:/Users/ADMIN/AppData/Local/nvim/)
vim.api.nvim_create_user_command("Config", function() Snacks.explorer({ 
    cwd = "~/.config/nvim", 
}) end, { desc = "Config Folder" })

-- type Code in cmdline to open Dev folder (C:/Users/ADMIN/Dev/)
vim.api.nvim_create_user_command("Code", function() Snacks.explorer({ 
    cwd = "~/Dev/", 
}) end, { desc = "Dev Folder" })

-- type Note in cmdline to open Note folder (C:/Users/ADMIN/Desktop/MyNotes)
vim.api.nvim_create_user_command("Note", function() Snacks.explorer({ 
    cwd = "~/Notes/", 
}) end, { desc = "Notes Folder" })

-- A few more nice ones
map("n", "<leader>ff", function() Snacks.picker.files({

}) end, vim.tbl_extend("force", opts, { desc = "Find Files" }))

map("n", "<leader>fr", function() Snacks.picker.recent({
    on_show = function()
        vim.cmd.stopinsert()
    end, 
    win = {
        input = {
            keys = {
                ["Esc"] = {"close", mode = {"n", "i"}}, 

                ["F"] = {"preview_scroll_up", mode = {"n", "i"}}, 
                ["S"] = {"preview_scroll_down", mode = {"n", "i"}}, 
                ["R"] = {"preview_scroll_left", mode = {"n", "i"}}, 
                ["T"] = {"preview_scroll_right", mode = {"n", "i"}}, 
            }, 
        }, 
    }, 

}) end, vim.tbl_extend("force", opts, { desc = "Recent Files" }))

map("n", "<leader>C", function() Snacks.picker.files({ 
    on_show = function()
        vim.cmd.stopinsert()
    end, 
    cwd = "~/.config/nvim/", 
}) end, { desc = "Config Folder" })

map("n", "<leader>z",  function() Snacks.zen({

}) end, vim.tbl_extend("force", opts, { desc = "Toggle Zen Mode" }))

map("n", "<C-k>", function() Snacks.picker.keymaps({ 
    layout = "vertical", 
}) end, { desc = "Keymap" })

map("n", "<leader>so", function() Snacks.scratch({

}) end, { desc = "Toggle Scratch Buffer" })

map("n", "<leader>sn", function() Snacks.scratch_new({

}) end, { desc = "List Sratch" })

map("n", "<leader>ss", function() Snacks.scratch.select({
    on_show = function()
        vim.cmd.stopinsert()
    end, 
    win = {
        input = { 
            keys = { 
                ["Esc"] = {"close", mode = {"n", "i"}}, 
                ["d"] = "bufdelete", 
            },  
        },
        list = { 
            keys = { 
                ["d"] = "bufdelete" 
            }, 
        }, 
    }, 
}) end, { desc = "Select Scratch Buffer" })

map("n", "<leader>hp", function() Snacks.picker.help({
    on_show = function()
        vim.cmd.stopinsert()
    end, 
    win = {
        input = {
            keys = {
                ["Esc"] = {"close", mode = {"n", "i"}}, 

                ["F"] = {"preview_scroll_up", mode = {"n", "i"}}, 
                ["S"] = {"preview_scroll_down", mode = {"n", "i"}}, 
                ["R"] = {"preview_scroll_left", mode = {"n", "i"}}, 
                ["T"] = {"preview_scroll_right", mode = {"n", "i"}}, 
            }, 
        }, 
    }, 

}) end, { desc = "Help Pages" })

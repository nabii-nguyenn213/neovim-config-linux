require("tgpt").setup({
    buffer_height_ratio = 1.0,
    buffer_width_ratio = 0.4,
})
vim.keymap.set("n", "<leader>cc", "<cmd>TgptChat<CR>", { silent = true, desc = "Typr stats" })
vim.keymap.set("n", "<leader>cr", "<cmd>TgptRateMyCode<CR>", { silent = true, desc = "Typr stats" })
vim.keymap.set("n", "<leader>cb", "<cmd>TgptCheckForBugs<CR>", { silent = true, desc = "Typr stats" })


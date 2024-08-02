require("nvim-treesitter.configs").setup({
    ensure_installed = { "javascript", "typescript", "lua", "vim", "json", "html", "rust", "tsx" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
})

-- require("CopilotChat").setup {
--   debug = true, -- Enable debugging
--   -- See Configuration section for rest
-- }

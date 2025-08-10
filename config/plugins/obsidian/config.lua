local vim = vim
local km = vim.keymap
local autocmd = vim.api.nvim_create_autocmd

local function keybindings()

    km.set("n", "<CR>", ":ObsidianFollowLink <CR>")
    km.set('n', '<leader>bb', ":ObsidianBacklinks <CR>")
    km.set('n', '<leader>bt', ":ObsidianToday <CR>")
    km.set('n', '<leader>bT', ":ObsidianTomorrow <CR>")
    km.set('n', '<leader>by', ":ObsidianYesterday <CR>")
    km.set('n', '<leader>bs', ":ObsidianSearch <CR>")
    km.set('v', 'bs', ":ObsidianSearch <CR>")
    km.set('v', 'bl', ":ObsidianLink <CR>")
    km.set('v', 'bL', ":ObsidianLinkNew <CR>")

end

-- only set obsidian keybindings when in the obsidian directory
local event_names = { "BufReadPre", "BufNewFile", "VimEnter" }
local locs = { '*/Obsidian', '*/Obsidian/*', '*/Obsidian/**/*' }
for _, event in pairs(event_names) do
    for _, loc in pairs(locs) do
        autocmd(event, { pattern = loc, callback = keybindings })
    end
end

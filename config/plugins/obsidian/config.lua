local vim = vim
local km = vim.keymap
local autocmd = vim.api.nvim_create_autocmd

local function keybindings()

    km.set('n', '<leader>bb', ":Obsidian backlinks <CR>")
    km.set('n', '<leader>bt', ":Obsidian today <CR>")
    km.set('n', '<leader>bT', ":Obsidian today 1 <CR>")
    km.set('n', '<leader>by', ":Obsidian today -1 <CR>")
    km.set('n', '<leader>bs', ":Obsidian search <CR>")
    km.set('v', 'bs', ":Obsidian search <CR>")
    km.set('v', 'bl', ":Obsidian link <CR>")
    km.set('v', 'bL', ":Obsidian link_new <CR>")

end

-- only set obsidian keybindings when in the obsidian directory
local event_names = { "BufReadPre", "BufNewFile", "VimEnter" }
local locs = { '*/Obsidian', '*/Obsidian/*', '*/Obsidian/**/*' }
for _, event in pairs(event_names) do
    for _, loc in pairs(locs) do
        autocmd(event, { pattern = loc, callback = keybindings })
    end
end

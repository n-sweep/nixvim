local function func(ev)

    local foundry = require('foundry')
    foundry.setup({})

    -- keymaps ---------------------------------------------------------------------


    -- F33 -> Ctrl+Enter
    vim.keymap.set({'n', 'v'}, '<F33>', ":FoundryExecute<CR>", {
        desc = 'Foundry execute the current cell',
        buffer = ev.buf,
        silent = true,
    })

    -- F34 -> Shift+Enter
    vim.keymap.set({'n', 'v'}, '<F34>', ":FoundryExecuteStep<CR>", {
        desc = 'Foundry execute the current cell and step forward',
        buffer = ev.buf,
        silent = true,
    })

    -- F31 -> Shift+Tab
    vim.keymap.set('n', '<F31>', ":FoundryNext<CR>", {
        desc = 'Foundry move cursor to next cell',
        buffer = 0,
        silent = true,
    })

    -- F32 -> Alt+Tab
    vim.keymap.set('n', '<F32>', ":FoundryPrev<CR>", {
        desc = 'Foundry move cursor to previous cell',
        buffer = 0,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fo', ":FoundryOpen<CR>", {
        desc = 'Foundry open cell output in a temporary buffer',
        buffer = 0,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fn', ":FoundryCreateCell<CR>", {
        desc = 'Foundry create a new cell below the current cell',
        buffer = 0,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fN', ":FoundryCreateCellAbove<CR>", {
        desc = 'Foundry create a new cell above the current cell',
        buffer = 0,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fm', ":FoundryCreateMdCell<CR>", {
        desc = 'Foundry create a new markdown cell below the current cell',
        buffer = 0,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fM', ":FoundryCreateMdCellAbove<CR>", {
        desc = 'Foundry create a new markdown cell above the current cell',
        buffer = 0,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fd', ":FoundryDelete<CR>", {
        desc = 'Foundry delete cell under cursor',
        buffer = 0,
        silent = true,
    })

end


-- start foundry-nvim when an .ipynb file is opened
vim.api.nvim_create_autocmd('BufReadPre', {
    pattern = {'*.ipynb', '*.qmd'},
    callback = function(ev) func(ev) end
})

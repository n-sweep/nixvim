local function func(ev)

    -- F33 -> Ctrl+Enter
    vim.keymap.set({'n', 'v'}, '<C-CR>', ":FoundryExecute<CR>", {
        desc = 'Foundry execute the current cell',
        buffer = ev.buf,
        silent = true,
    })

    -- F34 -> Shift+Enter
    vim.keymap.set({'n', 'v'}, '<S-CR>', ":FoundryExecuteStep<CR>", {
        desc = 'Foundry execute the current cell and step forward',
        buffer = ev.buf,
        silent = true,
    })

    -- F31 -> Shift+Tab
    vim.keymap.set('n', '<S-Tab>', ":FoundryNext<CR>", {
        desc = 'Foundry move cursor to next cell',
        buffer = ev.buf,
        silent = true,
    })

    -- F32 -> Alt+Tab
    vim.keymap.set('n', '<M-Tab>', ":FoundryPrev<CR>", {
        desc = 'Foundry move cursor to previous cell',
        buffer = ev.buf,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fy', ":FoundryYankOutput<CR>", {
        desc = 'Foundry yank cell output',
        buffer = ev.buf,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fY', ":FoundryYankInput<CR>", {
        desc = 'Foundry yank cell input',
        buffer = ev.buf,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fo', ":FoundryOpen<CR>", {
        desc = 'Foundry open cell output in a temporary buffer',
        buffer = ev.buf,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fnc', ":FoundryCreateCell<CR>", {
        desc = 'Foundry create a new cell below the current cell',
        buffer = ev.buf,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fnC', ":FoundryCreateCellAbove<CR>", {
        desc = 'Foundry create a new cell above the current cell',
        buffer = ev.buf,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fnm', ":FoundryCreateMdCell<CR>", {
        desc = 'Foundry create a new markdown cell below the current cell',
        buffer = ev.buf,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fnM', ":FoundryCreateMdCellAbove<CR>", {
        desc = 'Foundry create a new markdown cell above the current cell',
        buffer = ev.buf,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fmk', ":FoundryMoveUp<CR>", {
        desc = 'Foundry move the cell under the cursor up one cell',
        buffer = ev.buf,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fmj', ":FoundryMoveDown<CR>", {
        desc = 'Foundry move the cell under the cursor down one cell',
        buffer = ev.buf,
        silent = true,
    })

    vim.keymap.set('n', '<leader>fd', ":FoundryDelete<CR>", {
        desc = 'Foundry delete cell under cursor',
        buffer = ev.buf,
        silent = true,
    })

end


require('foundry').setup({keymap_func = func})

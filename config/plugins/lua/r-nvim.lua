require("r.nvim").setup({
    config = function()
        local opts = {
            external_term = "tmux split-window -h -l 80"
        }
        require("r").setup(opts)
    end
})

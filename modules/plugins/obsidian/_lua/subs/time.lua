---@diagnostic disable: miss-name
function(_, suffix)
    local format = suffix or Obsidian.opts.templates.time_format
    return require("obsidian.util").format_date(os.time(), format)
end

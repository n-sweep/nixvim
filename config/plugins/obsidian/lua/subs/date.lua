function _(ctx, suffix)
    local format_date = require("obsidian.util").format_date
    local format = suffix or Obsidian.opts.templates.date_format

    if ctx.partial_note then
        local id = ctx.partial_note.id
        local year, month, day = id:match("(%d+)-(%d+)-(%d+)")
        if year then
            local ts = os.time({ year = year, month = month, day = day })
            return format_date(ts, format)
        end
    end
    return format_date(os.time(), format)
end

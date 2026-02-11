---@diagnostic disable: miss-name
function(ctx)
    if not ctx.partial_note then return "" end

    local id = ctx.partial_note.id
    local y, m, d = id:match("(%d+)-(%d+)-(%d+)")
    if not y then return "" end

    local ts = os.time({ year = y, month = m, day = d})
    local day = tonumber(d)
    local suffix = "th"
    if day == 1 or day == 21 or day == 31 then
        suffix = "st"
    elseif day == 2 or day == 22 then
        suffix = "nd"
    elseif day == 3 or day == 23 then
        suffix = "rd"
    end

    return os.date("%A, %b ", ts) .. day .. suffix
end

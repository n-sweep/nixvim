---@diagnostic disable: miss-name
function(ctx)
    return ctx.partial_note and tostring(ctx.partial_note.path)
end

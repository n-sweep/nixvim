---@diagnostic disable: miss-name
function(ctx)
    return ctx.partial_note and ctx.partial_note:display_name()
end

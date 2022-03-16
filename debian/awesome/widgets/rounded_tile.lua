local wibox = require("wibox")
local gears = require("gears")

local roundedTile = {}

function roundedTile.wrap(widget)
    return wibox.widget {
        {
            {
                {
                    widget = widget
                },
                left = 8,
                right = 8,
                top = 4,
                bottom = 4,
                widget = wibox.container.margin
            },
            bg = "#454545",
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background
        },
        top = 5,
        bottom = 5,
        right = 5,
        left = 5,
        widget = wibox.container.margin
    }
end

function roundedTile.wrapLayout(layout)
    return wibox.widget {
        {
            {
                layout,
                left = 8,
                right = 8,
                top = 4,
                bottom = 4,
                widget = wibox.container.margin
            },
            bg = "#454545",
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background
        },
        top = 5,
        bottom = 5,
        right = 5,
        left = 5,
        widget = wibox.container.margin
    }
end

return roundedTile
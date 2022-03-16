local wibox = require("wibox")

local systray = {}

function systray.build()
    local widget = wibox.widget {
        {
            base_size = nil,
            widget = wibox.widget.systray
        },
        left = 15,
        right = 15,
        widget = wibox.container.margin
    }

    return widget
end

return systray
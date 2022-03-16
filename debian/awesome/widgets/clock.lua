local wibox = require("wibox")
local calendar = require("widgets.calendar")

local clock = {}

function clock.build()
    local textClock = wibox.widget {
        format = '%I:%M %P',
        widget = wibox.widget.textclock
    }

    local widget = wibox.widget {
        {
            widget = textClock
        },
        halign = "center",
        widget = wibox.container.place
    }

    calendar:register(textClock)
    return widget
end

return clock
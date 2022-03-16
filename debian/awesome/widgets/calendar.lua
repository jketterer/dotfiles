local awful = require("awful")

local calendar
calendar = awful.widget.calendar_popup.month({position="tc"})

function calendar:register(widget)
    widget:connect_signal(
        "mouse::enter",
        function ()
            self:toggle()
        end
    )

    widget:connect_signal(
        "mouse::leave",
        function ()
            self:toggle()
        end
    )

    widget:buttons(awful.util.table.join(
        awful.button({}, 1, function ()
            self:call_calendar(-1)
        end),
        awful.button({}, 2, function ()
            self:call_calendar(0)
        end),
        awful.button({}, 3, function ()
            self:call_calendar(1)
        end)
    ))
end

return calendar
local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local taglist = {}

local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ }, 3, awful.tag.viewtoggle)
                )

function taglist.build(s)
    return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    id = "text_role",
                    widget = wibox.widget.textbox,
                },
                left = 15,
                right = 15,
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        }
    }
end

return taglist
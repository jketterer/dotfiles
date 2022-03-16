local wibox = require("wibox")
local awful = require("awful")
local tileWrapper = require("widgets.rounded_tile")
local iconLoader = require("utils.icon_loader")

local memory = {}

function memory.build()
    local label = wibox.widget.textbox()
    awful.widget.watch('/home/jeremy/mem_usage.sh', 2, function (widget, stdout) -- luacheck: ignore
        label:set_text(stdout)
    end)

    local icon = iconLoader.lookup_icon("drive-multidisk")
    local iconWidget = wibox.widget {
        resize = true,
        image = iconLoader.load_icon(icon),
        widget = wibox.widget.imagebox
    }

    return tileWrapper.wrapLayout({
        iconWidget,
        wibox.widget {
            {
                widget = label
            },
            left = 6,
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal
    })
end

return memory
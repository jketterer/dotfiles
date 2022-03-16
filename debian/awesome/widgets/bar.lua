local wibox = require("wibox")
local awful = require("awful")

local taglistBuilder = require("widgets.taglist")
local clockBuilder = require("widgets.clock")
local systrayBuilder = require("widgets.systray")
local volume = require("widgets.volume")
local batteryBuilder = require("widgets.battery")
local memoryBuilder = require("widgets.memory")
local cpuBuilder = require("widgets.cpu")

local wibar = {}

function wibar.build(screen)
    -- Create the wibox
    local bar = awful.wibar({
        position = "top",
        screen = screen,
        height = 35,
    })

    -- Build widgets
    local promptbox = awful.widget.prompt()
    local taglist = taglistBuilder.build(screen)
    local systray = systrayBuilder.build()
    local clock = clockBuilder.build()
    local bat = batteryBuilder.build()
    local memory = memoryBuilder.build()
    local cpu = cpuBuilder.build()

    -- Add widgets to the bar
    bar:setup {
        -- Stacking the clock on top of the bar so it's always centered
        layout = wibox.layout.stack,
        clock,
        {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                taglist,
                promptbox,
            },
            nil, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                memory,
                cpu,
                volume,
                bat,
                systray,
                -- layoutbox,
            },
        }
    }
end

return wibar
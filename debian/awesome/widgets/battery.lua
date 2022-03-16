local wibox = require("wibox")
local tileWrapper = require("widgets.rounded_tile")
local upower = require("utils.upower")
local iconLoader = require("utils.icon_loader")

local icon = {
  discharging_full = iconLoader.lookup_icon("battery-full-symbolic"),
  discharging_good = iconLoader.lookup_icon("battery-good-symbolic"),
  discharging_low = iconLoader.lookup_icon("battery-low-symbolic"),
  discharging_empty = iconLoader.lookup_icon("battery-empty-symbolic"),
  charging_full = iconLoader.lookup_icon("battery-full-charging-symbolic"),
  charging_good = iconLoader.lookup_icon("battery-good-charging-symbolic"),
  charging_low = iconLoader.lookup_icon("battery-low-charging-symbolic"),
  charging_empty = iconLoader.lookup_icon("battery-empty-charging-symbolic"),
}

local battery = {}

function battery.build()
    local image_widget = wibox.widget {
        resize = true,
        widget = wibox.widget.imagebox
    }

    local upowerObject = upower({
        settings = function(bat_now, widget)
            local status = string.format("%d", bat_now.perc) .. "%"
            local image

            if bat_now.status == "Full" then
              image = iconLoader.load_icon(icon.discharging_full)
              status = "full"
            elseif bat_now.perc >= 90 then
              if bat_now.status == "Discharging" then
                image = iconLoader.load_icon(icon.discharging_full)
              else
                image = iconLoader.load_icon(icon.charging_full)
              end
            elseif bat_now.perc >= 66 then
              if bat_now.status == "Discharging" then
                image = iconLoader.load_icon(icon.discharging_good)
              else
                image = iconLoader.load_icon(icon.charging_good)
              end
            elseif bat_now.perc >= 33 then
              if bat_now.status == "Discharging" then
                image = iconLoader.load_icon(icon.discharging_low)
              else
                image = iconLoader.load_icon(icon.charging_low)
              end
            else
              if bat_now.status == "Discharging" then
                image = iconLoader.load_icon(icon.discharging_empty)
              else
                image = iconLoader.load_icon(icon.charging_empty)
              end
            end

            image_widget.image = image
            widget:set_markup(status)
    end
    })

    return tileWrapper.wrapLayout({
        image_widget,
        wibox.widget {
          {
              widget = upowerObject.widget
          },
          left = 3,
          widget = wibox.container.margin
      },
        layout = wibox.layout.fixed.horizontal
    })
end

return battery
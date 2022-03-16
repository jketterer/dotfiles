local upower   = require("lgi").require("UPowerGlib")
local wibox    = require("wibox")
local setmetatable = setmetatable

local upower_battery = {}

upower_battery.upower_status = {
	[upower.DeviceState.PENDING_DISCHARGE] = "Discharging",
	[upower.DeviceState.PENDING_CHARGE]    = "Charging",
	[upower.DeviceState.FULLY_CHARGED]     = "Full",
	[upower.DeviceState.EMPTY]             = "N/A",
	[upower.DeviceState.DISCHARGING]       = "Discharging",
	[upower.DeviceState.CHARGING]          = "Charging",
	[upower.DeviceState.UNKNOWN]           = "N/A"
}

upower_battery.upower_kind = {
	[upower.DeviceKind.UNKNOWN]            = "N/A",
	[upower.DeviceKind.LINE_POWER]         = 1,
	[upower.DeviceKind.TABLET]             = "N/A",
	[upower.DeviceKind.COMPUTER]           = "N/A",
	[upower.DeviceKind.LAST]               = "N/A",
	[upower.DeviceKind.BATTERY]            = 0,
	[upower.DeviceKind.UPS]                = "N/A",
	[upower.DeviceKind.MONITOR]            = "N/A",
	[upower.DeviceKind.MOUSE]              = "N/A",
	[upower.DeviceKind.KEYBOARD]           = "N/A",
	[upower.DeviceKind.PDA]                = "N/A",
	[upower.DeviceKind.PHONE]              = "N/A",
	[upower.DeviceKind.MEDIA_PLAYER]       = "N/A"
}

upower_battery.display_device = {}

function upower_battery.factory(args)
	local bat 	= { widget = wibox.widget.textbox() }
	local args 	= args or {}
	local settings 	= args.settings or function() end

	function bat.update(device)
		local bat_now = {}
		bat_now.status = upower_battery.upower_status[device.state]
		bat_now.ac_status = upower_battery.upower_kind[device.kind]
		bat_now.perc = 0 + device.percentage
		bat_now.watt = device.energy_full_design

		settings(bat_now, bat.widget)
	end

	upower_battery.display_device = upower.Client():get_display_device()
	bat.update(upower_battery.display_device)
	upower_battery.display_device.on_notify = bat.update

	return bat
end

return setmetatable(upower_battery, { __call = function(_, ...) return upower_battery.factory(...) end })
local lgi = require('lgi')
local icon_theme = lgi.Gtk.IconTheme.get_default()
local IconLookupFlags = lgi.Gtk.IconLookupFlags

local icon_size = 64
local icon_flags = {IconLookupFlags.GENERIC_FALLBACK}

local loader = {}

function loader.lookup_icon(name)
    return icon_theme:lookup_icon(name, icon_size, icon_flags)
  end

function loader.load_icon(icon)
    if icon ~= nil then
        return icon:load_surface()
      end
end

return loader
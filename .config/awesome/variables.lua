local awful = require("awful")
local lain = require("lain")

local home_path = os.getenv("HOME")

terminal = "cool-retro-term"
quaketerminal = "guake"
browser1 = "firefox"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
file1 = "nautilus"
file2 = terminal .. " -e " .. "ranger"
music = terminal .. " -e ncmpcpp"
rofi_run = "rofi -show drun"
rofi_power = string.format("%s/.scripts/rofi-power", home_path)
clipmenu = "CM_LAUNCHER=rofi clipmenu -i"
copyq = "copyq show"
screenshot = "gnome-screenshot -i"

scripts = "~/.scripts/"

screen1 = "HDMI-0"
screen2 = "DVI-D-0"

lockscreen = "betterlockscreen -l dimblur"

kb_layout = "pl"

is_laptop = false

autostart = {
	"unclutter",
  "nm-applet",
  "udiskie --smart-tray",
  "guake",
  "firefox",
  "emacs --daemon",
  -- "telegram-desktop",
  "nautilus",
  "copyq",
  "clipmenud",
  "virt-manager",
}

awful.layout.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.floating,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.magnifier,
  awful.layout.suit.corner.nw,
  awful.layout.suit.corner.ne,
  awful.layout.suit.corner.sw,
  awful.layout.suit.corner.se,
  lain.layout.cascade,
  lain.layout.cascade.tile,
  lain.layout.centerwork,
  lain.layout.centerwork.horizontal,
  lain.layout.termfair,
  lain.layout.termfair.center,
}

awful.util.tagnames = {
	{
		{name = "\u{f269} Firefox", sel = true, lay=awful.layout.layouts[1]},
		{name = "\u{f121} Code", lay=awful.layout.layouts[2]},
		{name = "\u{f120} Term"},
		{name = "\u{f0c5} Files", lay=awful.layout.layouts[4]},
		{name = "\u{f1c1} Docs"},
		{name = "\u{f471} Pwn"},
		{name = "\u{f141} Misc"},
		{name = "\u{f1b6} Steam"},
		{name = "\u{f0e5} Chat", lay=awful.layout.layouts[2]},
		{name = "\u{f17a} VM"},
	},
	{
		{name = "1", sel = true},
		{name = "2"},
		{name = "3"},
		{name = "4"},
		{name = "5"},
		{name = "6"},
		{name = "7"},
		{name = "8"},
		{name = "9"},
		{name = "10"},
	}
}

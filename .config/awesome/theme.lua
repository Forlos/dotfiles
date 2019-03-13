local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")


local themes_path = require("gears.filesystem").get_themes_dir()
local dpi = require("beautiful.xresources").apply_dpi

-- {{{ Main
local theme = {}
theme.wallpaper = themes_path .. "zenburn/zenburn-background.png"
-- }}}

-- {{{ Styles
theme.font      = "sans 8"
theme.iconFont  = "Font Awesome 5 Free Regular 9"

-- {{{ Colors
theme.fg_normal  = "#DCDCCC"
theme.fg_focus   = "#F0DFAF"
theme.fg_urgent  = "#CC9393"
theme.bg_normal  = "#3F3F3F"
theme.bg_focus   = "#1E2320"
theme.bg_urgent  = "#3F3F3F"
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap   = 5
theme.border_width  = 1
theme.border_normal = "#3F3F3F"
theme.border_focus  = "#6F6F6F"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- Textclock
local cal_icon = " <span color=\"#a753fc\" font=\"".. theme.iconFont .."\"></span>"
local mytextclock = wibox.widget.textclock(markup(white, cal_icon) .. markup(white, " %d ")
                                             .. markup(gray, "%b ") .. markup(white, "%Y ") .. markup(gray, " %a ") .. markup(white, "%H:%M %p "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
      font = "Misc Tamsyn 11",
      fg   = white,
      bg   = theme.bg_normal
}})
mytextclock:disconnect_signal("mouse::enter", theme.cal.hover_on)

-- Thermal
theme.ther = wibox.widget.textbox()
vicious.register(
	theme.ther,
	vicious.widgets.thermal,
	function(widget, args)
		local fs_icon = ("<span color=\"%s\" font=\"%s\"></span>"):format(
			"#fc4f8e", theme.iconFont	
                                                                      )
		return ("%s <span color=\"%s\">%s%%</span>"):format(
			fs_icon, white, args[1]
                                                       )
	end,
	19,
	"thermal_zone1"
)

-- Mem
theme.mem = wibox.widget.textbox()
vicious.register(
	theme.mem,
	vicious.widgets.mem,
	function(widget, args)
		local mem_icon = ("<span color=\"%s\" font=\"%s\"></span>"):format(
			"#a753fc", theme.iconFont	
                                                                       )
		return ("%s <span color=\"%s\">%s%%</span>"):format(
			mem_icon, white, args[1]
                                                       )
	end
)

-- CPU
theme.cpu = lain.widget.cpu({
    settings = function()
      local cpu_icon = "<span font=\"".. theme.iconFont .."\"></span> "
      widget:set_markup(markup.font(theme.font, markup("#1eff8e", cpu_icon) .. markup(white, cpu_now.usage .. "% ")))
    end
})

theme.bat.widget:buttons(awful.util.table.join(
    awful.button({}, 4, function() -- scroll up
        os.execute("light -A 5")
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute("light -U 5")
    end)
))

-- volume
theme.volumewidget = wibox.widget.textbox()
vicious.register(theme.volumewidget, vicious.widgets.volume,
                function(widget, args)
                    local label = {["♫"] = "O", ["♩"] = "M"}
					local cur_vol = args[1]
					local vol_color = white
					local vol_icon_color = "#ff8e1e"
					if (cur_vol > 70) then
						vol_icon = ""
					elseif (cur_vol > 30) then
						vol_icon = ""
					else
						vol_icon = ""
					end
					if label[args[2]] == "M" then
						vol_color = "#ff1e8e"
						vol_icon_color = "#ff1e8e"
						cur_vol = "M"
					end
					local vheader = ("<span color=\"%s\" font=\"%s\">%s</span>"):format(
						vol_icon_color, theme.iconFont, vol_icon
					)
                    return ("<span color=\"%s\">%s %s </span>"):format(
						vol_color, vheader, cur_vol
					)
                end, 2, {"Master", "-D", "pulse"})

theme.volumewidget:buttons(awful.util.table.join(
    awful.button({}, 2, function() -- left click
        awful.spawn("pavucontrol")
    end),
    awful.button({}, 3, function() -- right click
        os.execute("amixer set Master toggle")
		vicious.force({theme.volumewidget})
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute("amixer set Master 2%+")
		vicious.force({theme.volumewidget})
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute("amixer set Master 2%-")
		vicious.force({theme.volumewidget})
    end)
))

-- Separators
local first     = wibox.widget.textbox('<span font="Misc Tamsyn 4"> </span>')
local arrl_pre  = separators.arrow_right("alpha", theme.pw_bg)
local arrl_post = separators.arrow_right(theme.pw_bg, "alpha")
local arll_pre  = separators.arrow_left("alpha", theme.pw_bg)
local arll_post = separators.arrow_left(theme.pw_bg, "alpha")

function theme.at_screen_connect(s)

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s)

    -- Tags
    --awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
	for _, i in pairs(awful.util.tagnames[s.index]) do
		awful.tag.add(i.name, {
			layout = i.lay or awful.layout.layouts[1],
			gap = i.gap or theme.useless_gap,
			screen = s,
			selected = i.sel or false,
			master_width_factor = i.mw or 0.5,
		})
	end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({}, 1, function() awful.layout.inc( 1) end),
                           awful.button({}, 2, function() awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function() awful.layout.inc(-1) end),
                           awful.button({}, 4, function() awful.layout.inc( 1) end),
                           awful.button({}, 5, function() awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(
		s,
		awful.widget.tasklist.filter.focused
	)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 19, bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
		expand = 'none',
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mylayoutbox,
            first,
            s.mytaglist,
            s.mypromptbox,
            first,
			arrl_pre,
			wibox.container.background(theme.mpd_prev, theme.pw_bg),
			wibox.container.background(theme.mpd_toggle, theme.pw_bg),
			wibox.container.background(theme.mpd_next, theme.pw_bg),
			arrl_post,
			theme.mpdwidget,
        },
        wibox.container.place(mytextclock, "center"),
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            first,
			arll_pre,
			wibox.container.background(theme.ther, theme.pw_bg),
			arll_post,
			theme.fs,
			arll_pre,
			wibox.container.background(theme.cpu.widget, theme.pw_bg),
			arll_post,
			theme.mem,
			arll_pre,
			wibox.container.background(theme.volumewidget, theme.pw_bg),
			arll_post,
			theme.bat,
        },
    }
end


-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = themes_path .. "zenburn/taglist/squarefz.png"
theme.taglist_squares_unsel = themes_path .. "zenburn/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = themes_path .. "zenburn/awesome-icon.png"
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = themes_path .. "zenburn/layouts/tile.png"
theme.layout_tileleft   = themes_path .. "zenburn/layouts/tileleft.png"
theme.layout_tilebottom = themes_path .. "zenburn/layouts/tilebottom.png"
theme.layout_tiletop    = themes_path .. "zenburn/layouts/tiletop.png"
theme.layout_fairv      = themes_path .. "zenburn/layouts/fairv.png"
theme.layout_fairh      = themes_path .. "zenburn/layouts/fairh.png"
theme.layout_spiral     = themes_path .. "zenburn/layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "zenburn/layouts/dwindle.png"
theme.layout_max        = themes_path .. "zenburn/layouts/max.png"
theme.layout_fullscreen = themes_path .. "zenburn/layouts/fullscreen.png"
theme.layout_magnifier  = themes_path .. "zenburn/layouts/magnifier.png"
theme.layout_floating   = themes_path .. "zenburn/layouts/floating.png"
theme.layout_cornernw   = themes_path .. "zenburn/layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "zenburn/layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "zenburn/layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "zenburn/layouts/cornerse.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themes_path .. "zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "zenburn/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = themes_path .. "zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = themes_path .. "zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme


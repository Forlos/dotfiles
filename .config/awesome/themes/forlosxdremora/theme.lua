local naughty = require("naughty")
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")

local os = os

local markup     = lain.util.markup
local separators = lain.util.separators

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/forlosxdremora"
theme.wallpaper                                 = os.getenv("HOME") .. "/.wallpapers/Hyper-Light-Drifter_campfire-in-the-storm_1920x1080.png"

theme.font                                      = "GohuFont Nerd Font Mono 10"
theme.taglist_font                              = "GohuFont Nerd Font 10"
theme.iconFont                                  = "Font Awesome 5 Free Regular 9"
theme.fg_normal                                 = "#bbb"
theme.fg_focus                                  = "#DDDCFF"
theme.bg_normal                                 = "#2F343F"
theme.bg_focus                                  = "#2F343F"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#2A1F1E"
theme.border_width                              = "1"
theme.border_normal                             = "#19171c"
theme.border_focus                              = "#576ddb"
theme.border_marked                             = "#398bc6"
theme.titlebar_bg_focus                         = "#292929"
theme.taglist_fg_focus                          = "#dddcff"
theme.taglist_fg_normal                         = "#dddcff"
theme.taglist_bg_focus                          = "#003cb3"
theme.taglist_bg_urgent                         = "#AF002A"
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.tasklist_align                            = "center"
theme.useless_gap                               = 5
theme.pw_bg                                     = "#231929"

theme.wibar_opacity                             = 0.8
theme.wibar_bg                                  = "#081020"
theme.wibar_fg                                  = "#5050b0"
theme.menu_height                               = 15
theme.menu_width                                = 200
theme.taglist_spacing                           = 5

-- {{{ Notifications
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
-- theme.notification_border_width = theme.border_width
-- theme.notification_border_color = theme.border_marked
theme.notification_font = theme.font
theme.notification_opacity = 0.85
theme.notification_icon_size = 150
theme.notification_max_width = 450
theme.notification_max_height = 200
theme.notification_margin = 15

naughty.config.padding = 10
naughty.config.spacing = 10
naughty.config.defaults.timeout = 3
-- }}}

local white      = theme.fg_focus
local gray       = "#858585"

-- Textclock
local cal_icon = " <span color=\"#a753fc\" font=\"".. theme.iconFont .."\"></span>"
local mytextclock = wibox.widget.textclock(markup(white, cal_icon) .. markup(white, " %d ")
.. markup(gray, "%b ") .. markup(white, "%Y ") .. markup(gray, " %a ") .. markup(white, "%H:%M "))
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    icons = "",
    attach_to = { mytextclock },
    notification_preset = {
        font = theme.font,
        fg   = white,
        bg   = theme.wibar_bg
}})
mytextclock:disconnect_signal("mouse::enter", theme.cal.hover_on)

-- FS
theme.fs = wibox.widget.textbox()
vicious.cache(vicious.widgets.fs)
vicious.register(
	theme.fs,
	vicious.widgets.fs,
	function(widget, args)
		local fs_icon = ("<span color=\"%s\" font=\"%s\"></span>"):format(
			"#b6b6b6", theme.iconFont
		)
		return ("%s <span color=\"%s\">%s%%</span>"):format(
			fs_icon, white, args["{/ used_p}"]
		)
	end,
	999
)
theme.fs.font = theme.taglist_font

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
theme.mem.font = theme.taglist_font

-- CPU
theme.cpu = lain.widget.cpu({
	settings = function()
		local cpu_icon = "<span font=\"".. theme.iconFont .."\"></span> "
		widget:set_markup(markup.font(theme.taglist_font, markup("#1eff8e", cpu_icon) .. markup(white, cpu_now.usage .. "% ")))
	end
})

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
theme.volumewidget.font = theme.taglist_font

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
	-- for _, i in pairs(awful.util.tagnames[s.index]) do
	-- 	awful.tag.add(i.name, {
	-- 		layout = i.lay or awful.layout.layouts[1],
	--  		gap = i.gap or theme.useless_gap,
	--  		screen = s,
	--  		selected = i.sel or false,
	--  		master_width_factor = i.mw or 0.5,
	--  	})
	--  end

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
    s.mytaglist = awful.widget.taglist{
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
      buttons = awful.util.taglist_buttons,
      style = {
        shape = gears.shape.rectangle
      },
      layout = {
        layout  = wibox.layout.fixed.horizontal
      },
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(
		s,
		awful.widget.tasklist.filter.focused
	)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 20, bg = theme.wibar_bg, fg = theme.fg_normal })

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
			-- wibox.container.background(theme.mpd_prev, theme.pw_bg),
			-- wibox.container.background(theme.mpd_toggle, theme.pw_bg),
			-- wibox.container.background(theme.mpd_next, theme.pw_bg),
			arrl_post,
			-- theme.mpdwidget,
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

return theme

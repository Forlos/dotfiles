local lain          = require("lain")
local variables = require("variables")
local scratch = require("scratch")
local vicious = require("vicious")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local cyclefocus = require('cyclefocus')

-- TODO file path
local home_path = os.getenv("HOME")
local todo_file = string.format('%s/TODO.txt', home_path)


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "zenburn/theme.lua")

-- Compton init

awful.spawn.with_shell("~/.config/awesome/autorun.sh " .. "picom -b")

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", home_path, "forlosxdremora"))

-- This is used later as the default terminal and editor to run.
terminal = "cool-retro-term"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
-- awful.layout.layouts = {
--     awful.layout.suit.floating,
--     awful.layout.suit.tile,
--     awful.layout.suit.tile.left,
--     awful.layout.suit.tile.bottom,
--     awful.layout.suit.tile.top,
--     awful.layout.suit.fair,
--     awful.layout.suit.fair.horizontal,
--     awful.layout.suit.spiral,
--     awful.layout.suit.spiral.dwindle,
--     awful.layout.suit.max,
--     awful.layout.suit.max.fullscreen,
--     awful.layout.suit.magnifier,
--     awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
-- }
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mypowermenu = {
  { "⚙ lock", lockscreen },
  { "⏾ suspend", "systemctl suspend" },
  { "⏼ hybrid-sleep", "systemctl hybrid-sleep" },
  { "↻ reboot", "reboot" },
  { "⏻ shutdown", "poweroff" }
}

mymainmenu = awful.menu({ items = {
                            { "awesome", myawesomemenu, beautiful.awesome_icon },
                            { "open terminal", terminal },
                            { "power" , mypowermenu},
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
netwidget = wibox.widget.textbox()
-- Register widget
vicious.register(netwidget, vicious.widgets.net, '<span color="#be4678">▼ ${wlp2s0 down_kb}</span> <span color="#2a9292">▲ ${wlp2s0 up_kb}</span>', 3)

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s, wallpaper)
    -- Wallpaper
    if beautiful.wallpaper then
        -- local wallpaper = beautiful.get().wallpaper
        -- local wallpaper = beautiful.get().wallpapers[math.random(0, #beautiful.get().wallpapers)]
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s)
    end
end


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

-- awful.screen.connect_for_each_screen(function(s)
--     -- Wallpaper
--     set_wallpaper(s)

--     -- Each screen has its own tag table.
--     awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

--     -- Create a promptbox for each screen
--     s.mypromptbox = awful.widget.prompt()
--     -- Create an imagebox widget which will contain an icon indicating which layout we're using.
--     -- We need one layoutbox per screen.
--     s.mylayoutbox = awful.widget.layoutbox(s)
--     s.mylayoutbox:buttons(gears.table.join(
--                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
--                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
--                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
--                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))
--     -- Create a taglist widget
--     s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

--     -- Create a tasklist widget
--     s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

--     -- Create the wibox
--     s.mywibox = awful.wibar({ position = "top", screen = s })

--     -- Add widgets to the wibox
--     s.mywibox:setup {
--         layout = wibox.layout.align.horizontal,
--         { -- Left widgets
--             layout = wibox.layout.fixed.horizontal,
--             mylauncher,
--             s.mytaglist,
--             s.mypromptbox,
--         },
--         s.mytasklist, -- Middle widget
--         { -- Right widgets
--             layout = wibox.layout.fixed.horizontal,
--             mykeyboardlayout,
--             wibox.widget.systray(),
--             mytextclock,
--             s.mylayoutbox,
--         },
--     }
-- end)
-- -- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    -- awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
    --           {description = "select next", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
    --           {description = "select previous", group = "layout"}),

    -- Prompt
    awful.key({ modkey, "Shift" }, "0" , function () awful.util.spawn(rofi_power) end),
    awful.key({ }, "F2" , function () awful.util.spawn(rofi_run) end),
    awful.key({ }, "F3" , function () awful.spawn.with_shell(clipmenu) end),
    -- awful.key({ }, "F4" , function () awful.util.spawn(copyq) end),
    awful.key({ }, "Print" , function () awful.util.spawn(screenshot) end),
    awful.key({ modkey, "Ctrl" }, "t" , function () display_todo(todo_file) end),
    awful.key({ modkey, "Ctrl" }, "n" , function ()
        beautiful.get().wallpaper_index = beautiful.get().wallpaper_index + 1
        if(beautiful.get().wallpaper_index > #beautiful.get().wallpapers) then
          beautiful.get().wallpaper_index = 0
        end
        awful.screen.connect_for_each_screen(
          function(s)
            set_wallpaper(s, beautiful.get().wallpapers[beautiful.get().wallpaper_index])
        end)
    end),
    awful.key({ modkey, "Ctrl" }, "b" , function ()
        beautiful.get().wallpaper_index = beautiful.get().wallpaper_index - 1
        if(beautiful.get().wallpaper_index < 0) then
          beautiful.get().wallpaper_index = #beautiful.get().wallpapers
        end
        awful.screen.connect_for_each_screen(
          function(s)
            set_wallpaper(s, beautiful.get().wallpapers[beautiful.get().wallpaper_index])
        end)
    end),


    -- awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
    --           {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- for i = 1, 9 do
--     globalkeys = gears.table.join(globalkeys,
--         -- View tag only.
--         awful.key({ modkey }, "#" .. i + 9,
--                   function ()
--                         local screen = awful.screen.focused()
--                         local tag = screen.tags[i]
--                         if tag then
--                            tag:view_only()
--                         end
--                   end,
--                   {description = "view tag #"..i, group = "tag"}),
--         -- Toggle tag display.
--         awful.key({ modkey, "Control" }, "#" .. i + 9,
--                   function ()
--                       local screen = awful.screen.focused()
--                       local tag = screen.tags[i]
--                       if tag then
--                          awful.tag.viewtoggle(tag)
--                       end
--                   end,
--                   {description = "toggle tag #" .. i, group = "tag"}),
--         -- Move client to tag.
--         awful.key({ modkey, "Shift" }, "#" .. i + 9,
--                   function ()
--                       if client.focus then
--                           local tag = client.focus.screen.tags[i]
--                           if tag then
--                               client.focus:move_to_tag(tag)
--                           end
--                      end
--                   end,
--                   {description = "move focused client to tag #"..i, group = "tag"}),
--         -- Toggle tag on focused client.
--         awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
--                   function ()
--                       if client.focus then
--                           local tag = client.focus.screen.tags[i]
--                           if tag then
--                               client.focus:toggle_tag(tag)
--                           end
--                       end
--                   end,
--                   {description = "toggle focused client on tag #" .. i, group = "tag"})
--     )
-- end

local sharedtags = require("sharedtags")

local tags = sharedtags({
    {name = "1.\u{f269} Firefox", sel = true, lay=awful.layout.layouts[1]},
    {name = "2.\u{f121} Code", lay=awful.layout.layouts[2]},
    {name = "3.\u{f120} Term",screen=2},
    {name = "4.\u{f0c5} Files", lay=awful.layout.layouts[4], screen=2},
    {name = "5.\u{f1c1} Docs"},
    {name = "6.\u{f471} Pwn"},
    {name = "7.\u{f1b6} Steam"},
    {name = "8.\u{f0e5} Chat", lay=awful.layout.layouts[2], screen=2},
    {name = "9.\u{f17a} VM"},
})

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = tags[i]
                        if tag then
                           sharedtags.viewonly(tag, screen)
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = tags[i]
                      if tag then
                         sharedtags.viewtoggle(tag, screen)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Open tag in screen number 2
        awful.key({ modkey, "Mod1" }, "#" .. i + 9,
          function ()
            local screen = screen[2]
            local tag = tags[i]
            if tag then
              sharedtags.viewonly(tag, screen)
            end
          end,
          {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Guake",
          "Signal",
          "Qemu",
          },

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true, border_width = 0 }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false}
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    { rule = { class = "firefox" },
      properties = {switchtotag=true , tags[1]} },
    { rule = { class = "Emacs" },
      properties = {maximized_vertical = true, maximized_horizontal = true,  tag = tags[2]} },
    { rule = { class = "Telegram" },
      properties = {switchtotag=true,maximized_vertical = true, maximized_horizontal = true, tag=tags["8.\u{f0e5} Chat"] , opacity = 0.95, } },
    { rule = { class = "Steam" },
      properties = {tag = tags[7]} },
    { rule = { class = "Nautilus" },
      properties = {tag = tags[4]} },
    { rule = { class = "Evince" },
      properties = {tag = tags[5]} },
    { rule = { class = "jetbrains-idea-ce" },
      properties = { opacity = 0.95, tag = tags[2] } },
    { rule = { class = "Virt-manager"},
      properties = { tag = tags[9] } },
    { rule = { class = "looking-glass-client"},
      properties = { tag = tags[9], fullscreen = true } },
    { rule = { class = "anki"},
      properties = { tag = tags[5] } },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

for _,i in pairs(autostart) do
	awful.spawn.with_shell("~/.config/awesome/autorun.sh " .. i)
end

-- No border for maximized clients
function border_adjust(c)
  if c.maximized then -- no borders if only 1 client visible
    c.border_width = 0
  elseif awful.screen.focused().clients > 1 then
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_focus
  end
end

quake = lain.util.quake {
	app = quaketerminal,
	horiz = "center",
	height = 0.5,
	width = 1
}

-- Alt-Tab: cycle through clients on the same screen.
-- This must be a clientkeys mapping to have source_c available in the callback.
cyclefocus.key({ "Mod1", }, "Tab", {
    -- cycle_filters as a function callback:
    -- cycle_filters = { function (c, source_c) return c.screen == source_c.screen end },

    -- cycle_filters from the default filters:
    cycle_filters = { cyclefocus.filters.same_screen, cyclefocus.filters.common_tag },
    keys = {'Tab', 'ISO_Left_Tab'}  -- default, could be left out
})

-- see if the file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end
-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

function display_todo(file)
  local lines = lines_from(file)
  local lines_text = ""
  local height = 0

  -- print all line numbers and their contents
  for k,v in pairs(lines) do
    lines_text = lines_text .. k .. "." .. v .. '\n'
    height = height + 18
  end
  naughty.notify { title="TODOs",
                   text=lines_text,
                   icon=string.format("%s/.wallpapers/emote11.PNG", home_path),
                   bg="#dfb088", fg="#081020",
                   border_color="#ff4643",
                   timeout=8, padding=20, max_width=600, max_height=height,icon_size=height,
                   font = "GohuFont Nerd Font Mono 10"}
end

naughty.notify { title="Welcome home",
                 text="",icon=string.format("%s/.wallpapers/nat1.png", home_path),
                 bg="#bfb0b8", fg="#081020",
                 border_color="#ff66b3",
                 timeout=5, padding=20, width=300, height=150,icon_size=150,
                 font = "GohuFont Nerd Font Mono 10"}

display_todo(todo_file)

awful.spawn.with_shell("setxkbmap " .. kb_layout)
awful.spawn.with_shell("pulsemixer --unmute")

client.connect_signal("focus", function(c)
                        c.border_color = beautiful.border_focus
                        -- c.opacity = 1
                      end)
client.connect_signal("unfocus", function(c)
                        c.border_color = beautiful.border_normal
                        -- c.opacity = 0.85
                      end)
-- }}}

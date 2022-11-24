

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
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


local theme = require("theme.default.theme")

-- local volume = require("core.bar.widgets.vol")

-- local volume = require('awesome-wm-widgets.volume-widget.volume')

terminal = "alacritty"
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor


-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

temas = {
    {"default", function() awful.spawn("julia /home/fer/.config/awesome/cambiar.jl default") awesome.restart() end },
    {"light", function() awful.spawn("julia /home/fer/.config/awesome/cambiar.jl light") awesome.restart() end },
    {"purple", function() awful.spawn("julia /home/fer/.config/awesome/cambiar.jl purple") awesome.restart() end }
}


mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "temas", temas},
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}



-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock(" %d-%m, %H:%M ")

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
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)









awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "α", 
                "β", 
                "γ", 
                "δ", 
                "ε", 
                "ζ", 
                "η", 
                "θ", 
                "ι" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget

beautiful.taglist_font = "FiraCode Nerd Font Mono 12"


s.icon = wibox.widget{text = "  ", font = "FiraCode Nerd Font Mono 16", widget = wibox.widget.textbox}
s.julia = wibox.widget{text = "  ", font = "FiraCode Nerd Font Mono 16", widget = wibox.widget.textbox}


-- s.volume = awful.widget.watch(".config/awesome/core/bar/widgets/volume", 1)
s.volume = wibox.widget{text = " 墳 ", font = "FiraCode Nerd Font Mono 16", widget = wibox.widget.textbox}
-- s.volume = require('awesome-wm-widgets.volume-widget.volume')
s.battery = awful.widget.watch(".config/awesome/core/bar/widgets/battery", 10)
s.wifi = awful.widget.watch(".config/awesome/core/bar/widgets/wifi", 10)
s.brightness = awful.widget.watch(".config/awesome/core/bar/widgets/brightness", 1)
s.layout = awful.widget.watch(".config/awesome/core/bar/widgets/layout", 1)
s.volume:buttons(
    awful.util.table.join(
        awful.button({}, 1, function() awful.spawn("notify-send \"$(pactl get-sink-volume @DEFAULT_SINK@)\"") end),
        awful.button({}, 4, function() awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%") end),
        awful.button({}, 5, function() awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%") end)
    )
)

s.battery:buttons(
    awful.util.table.join(
        awful.button({}, 1, function() awful.spawn("redshift -O 2000") end),
        awful.button({}, 3, function() awful.spawn("redshift -x") end),
        awful.button({}, 4, function() awful.spawn("brightnessctl s +10") end),
        awful.button({}, 5, function() awful.spawn("brightnessctl s 10-") end)
    )
)


    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
              {
                {
                  id = "text_role",
                  widget = wibox.widget.textbox,
                  align = "center",
                  valign = "center",
                },
                left = 7,
                right = 7,
                widget = wibox.container.margin,
              },
              id = "background_role",
              widget = wibox.container.background,
            },
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,

    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.icon,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            mytextclock,
            wibox.container.background(s.battery, theme.bar_bg_tre),
            s.volume,
            s.mylayoutbox,
        },
    }
end)
-- }}}






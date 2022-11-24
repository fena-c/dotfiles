# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget, hook, qtile, extension
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy 
from libqtile.utils import guess_terminal
import os
import subprocess
import re
import socket

mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
#    Key(['mod4'], 'space', lazy.run_extension(extension.DmenuRun(
#        dmenu_prompt=">",
#        dmenu_font="Andika-8",
#        background="#15181a",
#        foreground="#00ff00",
#        selected_background="#079822",
#        selected_foreground="#fff"))),
    Key([mod], "space", lazy.spawncmd(), desc="Spawnear comandos"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "t", lazy.window.toggle_floating(),desc="Alternar flotantes")
#    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

]

colors = {
    "background": '#181818',
    "current_line": '#282828',
    "foreground": '#f8f8f2',
    "comment": '#535453',
    "black":   '#181818',
    "red":     '#ab4642',
    "green":   '#a1b56c',
    "yellow":  '#f7ca88',
    "blue":    '#7cafc2',
    "lavender": '#ba8baf',
    "cyan":    '#86c1b9',
    "white":   '#d8d8d8',
}

catt = {
        "rosewater":   "#F5E0DC",
        "flamingo":    "#F2CDCD",
        "mauve":       "#DDB6F2",
        "pink":        "#F5C2E7",
        "maroon":      "#E8A2AF",
        "red":         "#F28FAD",
        "peach":       "#F8BD96",
        "yellow":      "#FAE3B0",
        "green":       "#ABE9B3",
        "teal":        "#B5E8E0",
        "blue":        "#96CDFB",
        "sky":         "#89DCEB",
        "lavender":    "#C9CBFF",
        
        "black0":      "#161320",
        "black1":      "#1A1826",
        "black2":      "#1E1E2E",
        "black3":      "#302D41",
        "black4":      "#575268",
        "gray0":       "#6E6C7E",
        "gray1":       "#988BA2",
        "gray2":       "#C3BAC6",
        "white":       "#D9E0EE",
        }

#αβγδεζηθι


groups = [
        Group(name="1", label="α"),
        Group(name="2", label="β"),
        Group(name="3", label="γ"),
        Group(name="4", label="δ"),
        Group(name="5", label="ε"),
        Group(name="6", label="ζ"),
        Group(name="7", label="η"),
        Group(name="8", label="θ"),
        Group(name="9", label="ι"),
        ]


for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Bsp(margin = 8, border_width = 2, border_focus=catt["blue"], 
        border_on_single="#F28FAD"),
    layout.MonadTall(margin = 8, border_width = 2, border_focus=catt["blue"], 
        border_on_single="#F28FAD"),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
     #layout.Stack(num_stacks=2),
     #layout.Matrix(),
     #layout.MonadWide(),
     #layout.RatioTile(),
     #layout.Tile(),
     #layout.TreeTab(),
     #layout.VerticalTile(),
     #layout.Zoomy(),
]

widget_defaults = dict(
        font="Iosevka Term:pixelsize=13;4",
    fontsize=12,
    background = "#302D41",
    padding=3,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper = "/home/fer/Imágenes/fondos/wallpapers/minimalistic/"+
        "red-cat.png",
        wallpaper_mode = "fill",
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(scale = 0.8,
                    background = catt["black2"]),
                widget.GroupBox(highlight_method = "block",
                    background = catt["black2"],
                    disable_drag = True,
#                    active = catt["black3"],
                    foreground = "#ffffff",
                    margin_y = 3,
                    fontsize = 14,
                    margin_x = 0,
                    padding_x = 10,
                    padding_y = 10,
                    border_width = 0,
                    block_highlight_text_color = catt["black0"],
                    highlight_color = catt["green"],
                    this_current_screen_border = catt["green"],
                    this_screen_border = catt["lavender"],
                       ),
                widget.TextBox(
                    text='\uE0B0',
                    foreground=catt["black2"],
                    padding=0,
                    fontsize=25),
                widget.Prompt(),
                widget.Spacer(),
                widget.WindowName(),
#                widget.TaskList(),
                widget.Spacer(),
#                widget.TextBox(
#                    fmt = "φ",
#                    mouse_callbacks = {
#                        "Button1": qtile.cmd_spawn("firefox")
#                        }
#                    ),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox(
                    text='\uE0B2',
                    foreground=catt["peach"],
                    background= "#302D41",
                    padding=0,
                    fontsize=25),
                widget.Backlight(
                    fontshadow=catt["white"],
                    backlight_name = "amdgpu_bl0",
                    fontsize = 16,
                    format = "☀ {percent:2.0%}",
                    foreground = catt["black4"],
                    mouse_callbacks = {
                        "Button1": lambda: qtile.cmd_spawn("redshift -O 2000"),
                        "Button2": lambda: qtile.cmd_spawn("redshift -x"),
                        "Button4": lambda: qtile.cmd_spawn("brightnessctl s +10"),
                        "Button5": lambda: qtile.cmd_spawn("brightnessctl s 10-")
                        },
                    background = [catt["peach"], catt["peach"]]),
#                widget.OpenWeather(location = "Santiago, CL", 
                        #format = "{location_city},"+
#                    " {main_temp}{units_temperature}"),
                widget.TextBox(
                    text='\uE0B2',
                    foreground=catt["lavender"],
                    background= catt["peach"],
                    padding=0,
                    fontsize=25),
                widget.Clock(format=" %Y-%m-%d %a %I:%M %p",
                    foreground = catt["black4"],
                    timezone="Chile/Continental",
                    fontshadow=catt["white"],
                    background = [catt["lavender"],catt["lavender"]]),
                widget.TextBox(
                    text='\uE0B2',
                    foreground=catt["teal"],
                    background= catt["lavender"],
                    padding=0,
                    fontsize=25),
                widget.Battery( format=' {percent:2.0%}', 
                    foreground = catt["black4"],
                    fontshadow=catt["white"],
                    background = [catt["teal"], catt["teal"]]),
#                widget.Volume(emoji = True),
                widget.TextBox(
                    text='\uE0B2',
                    foreground=catt["sky"],
                    background= catt["teal"],
                    padding=0,
                    fontsize=25),
                widget.PulseVolume(background = [catt["sky"], catt["sky"] ],
                    foreground = catt["black4"],
                    fontshadow=catt["white"],
#                    emoji = True,
                    format = "{get_volume_command}"),
                widget.TextBox(
                    text='\uE0B2',
                    foreground=catt["black2"],
                    background= catt["sky"],
                    padding=0,
                    fontsize=25),
                widget.Systray(highlight_method = "block",
                    background = [catt["black2"], catt["black2"]],
                    fontshadow=catt["white"],
                    #foreground = catt["black4"],
                    ),
            ],
            28,
#            margin = 4,
#             border_width=[2, 2, 2, 2],  # Draw top and bottom borders
#             border_color=["00000000", "00000000", "00000000", "00000000"]  # Borders are lavender
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"






# AUTOSTART
autostart = ["/home/fer/.config/bspwm/scripts/low_bat_notifier.sh",
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
        "nm-applet --indicator",
        """xinput set-prop "ELAN0504:01 04F3:312A Touchpad" "libinput Natural Scrolling Enabled" 1""",
        "picom -CGb "
        ]

for command in autostart:
    qtile.cmd_spawn(command)
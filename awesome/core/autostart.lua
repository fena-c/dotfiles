local awful = require("awful")
awful.util.spawn_with_shell("lxpolkit &")
-- awful.util.spawn_with_shell("nitrogen --set-zoom-fill /home/fer/Imágenes/fondos/pianodark.png &")
awful.util.spawn_with_shell("picom &")

awful.util.spawn_with_shell("~/.config/bspwm/scripts/low_bat_notifier.sh")


awful.util.spawn_with_shell("xinput set-prop \"ELAN0504:01 04F3:312A Touchpad\" \"libinput Natural Scrolling Enabled\" 1 &")
awful.util.spawn_with_shell("xinput set-prop \"ELAN0504:01 04F3:312A Touchpad\" \"libinput Tapping Enabled\" 1 &")



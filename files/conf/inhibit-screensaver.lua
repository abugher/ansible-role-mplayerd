local utils = require 'mp.utils'
mp.add_periodic_timer(30, function()
    utils.subprocess({env={"DISPLAY=:0", "XAUTHORITY=/home/display/.Xauthority"},args={"xdg-screensaver", "reset"}})
end)

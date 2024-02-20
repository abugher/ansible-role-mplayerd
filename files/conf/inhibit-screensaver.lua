-- Comments look like this.
local utils = require 'mp.utils'

function inhibit()
    utils.subprocess({env={"DISPLAY=:0", "XAUTHORITY=/home/display/.Xauthority"},args={"xdg-screensaver", "reset"}})
end

-- Inhibit screensaver every 30 seconds.
mp.add_periodic_timer(30, inhibit)
-- Don't wait 30 seconds to turn off the screen saver.
inhibit

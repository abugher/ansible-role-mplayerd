-- Comments look like this.
local utils = require 'mp.utils'


-- Unconditionally reset the screen saver inactivity countdown.
local function inhibit()
    utils.subprocess( {
        env={
            "DISPLAY=:0", 
            "XAUTHORITY=/home/display/.Xauthority"
        }, args={
            "xdg-screensaver", 
            "reset"
        }
    } )
end


-- Conditionally reset the screen saver inactivity countdown.
local function heartbeat(property_name, property_value)
    -- While paused or not playing anything, let the screen saver run.
    if 
        mp.get_property_bool("pause")
        or mp.get_property_bool("idle-active")
    then
        return
    end

    -- If actively playing, inhibit the screen saver.
    return inhibit()
end


-- Establish periodic heartbeat.
mp.add_periodic_timer(30, heartbeat)
-- Hastily turn off the screen saver when playback starts.  (Fire but do nothing when playback stops.)
mp.observe_property("idle-active", "bool", heartbeat)
mp.observe_property("pause", "bool", heartbeat)

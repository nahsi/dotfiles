if os.execute("pgrep redshift > /dev/null") ~= 0
    then
        return
    end

local redshift_enabled = true

function redshift_toggle()
    os.execute("pkill -USR1 redshift")
end

function redshift_disable()
    if redshift_enabled
    then
        redshift_toggle()
        redshift_enabled = false
        mp.msg.log("info", "redshift off")
    end
end

function redshift_enable()
    if not redshift_enabled
    then
        redshift_toggle()
        redshift_enabled = true
        mp.msg.log("info", "redshift on")
    end
end

function redshift_handler()
    if mp.get_property("video") ~= "no"
    then
        redshift_disable()
    else
        redshift_enable()
    end
end

mp.register_event("file-loaded", redshift_handler)
mp.register_event("shutdown", redshift_enable)

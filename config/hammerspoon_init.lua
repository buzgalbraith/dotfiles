local altScrollWatcher = hs.eventtap.new({hs.eventtap.event.types.scrollWheel}, function(e)
    local flags = e:getFlags()

    if flags.cmd then
        local dy = e:getProperty(
            hs.eventtap.event.properties.scrollWheelEventDeltaAxis1
        )
        hs.eventtap.event.newScrollEvent({dy, 0}, {}, "line"):post()
        return true
    end

    return false
end)

altScrollWatcher:start()

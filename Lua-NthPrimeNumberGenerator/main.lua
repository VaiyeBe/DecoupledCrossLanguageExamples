initStuff = function()

    local luaContext = luaContext()
    local mainWnd = luaContext:namedMesseagable("mainWnd")

    pushButtonHandler = luaContext:makeLuaMatchHandler(
        VMatch(function()



        end,"mwnd_outbtnclicked")
    )

    luaContext:message(mainWnd,VSig("mwnd_inattachmsg"),VMsg(pushButtonHandler))
end
initStuff()


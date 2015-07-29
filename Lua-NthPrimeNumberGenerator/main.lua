initStuff = function()

    local luaContext = luaContext()
    local mainWnd = luaContext:namedMesseagable("mainWnd")

    pushButtonHandler = luaContext:makeLuaMatchHandler(
        VMatch(function()

            local hipster = luaContext:namedMesseagable("hipster")

            --luaContext:message(hipster,VInt(7))
            local out = luaContext:messageRetValues(hipster,VString("empty"))
            print( "Received: " .. out._1 )

        end,"mwnd_outbtnclicked")
    )

    luaContext:message(mainWnd,VSig("mwnd_inattachmsg"),VMsg(pushButtonHandler))
end
initStuff()


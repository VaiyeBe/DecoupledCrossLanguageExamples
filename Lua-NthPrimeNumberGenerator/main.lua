print('hello werld!')

initStuff = function()

    local theContext = luaContext()
    local mainWnd = theContext:namedMesseagable("mainWnd")

    theContext:attachToProcessing(mainWnd)

    theContext:message(mainWnd,VSig("mwnd_insetlabel"),"CHOLO")

    local mainWndPushButtonMatch = VMatchFunctor.create(
        VMatch(function()
            local gen = theContext:namedMesseagable("generator")
            local vmatch = VMatchFunctor.create(
                VMatch(function(natpack,val)
                    local updateStr = "Found " .. val._2 .. " primes..."
                    theContext:message(mainWnd,VSig("mwnd_insetlabel"),VString(updateStr))
                end,
                "apg_asyncupdate","int")
            )
            local updateHandler = theContext:makeLuaHandler(function(pack)
                vmatch:tryMatch(pack)
            end)
            theContext:message(gen,"apg_asyncjob",updateHandler)
        end,"mwnd_outbtnclicked")
    )

    local mainWndPushButtonHandler = theContext:makeLuaHandler(function(pack)
        mainWndPushButtonMatch:tryMatch(pack)
    end)

    theContext:message(mainWnd,VSig("mwnd_inattachmsg"),VMsg(mainWndPushButtonHandler))

end
initStuff()


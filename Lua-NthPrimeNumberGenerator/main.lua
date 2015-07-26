print('hello werld!')

initStuff = function()

    local theContext = luaContext()
    local mainWnd = theContext:namedMesseagable("mainWnd")

    theContext:attachContextTo(mainWnd)

    theContext:message(mainWnd,VSig("mwnd_insetlabel"),"Press GO to generate nth prime number")

    local mainWndPushButtonMatch = VMatchFunctor.create(
        VMatch(function()
            local gen = theContext:namedMesseagable("generator")
            local vmatch = VMatchFunctor.create(
                VMatch(function(natpack,val)
                    print('GAH')
                    local updateStr = "Found " .. val:values()._2 .. " primes..."
                    print(updateStr)
                    theContext:message(mainWnd,VSig("mwnd_insetlabel"),VString(updateStr))
                end,
                "apg_asyncupdate","int")
            )
            local updateHandler = theContext:makeLuaHandler(function(pack)
                print('boyz 2 men')
                vmatch:tryMatch(pack)
            end)
            theContext:attachToProcessing(updateHandler)
            theContext:message(gen,VSig("apg_asyncjob"),
                VMsg(updateHandler),VInt(2000),VInt(250))
        end,"mwnd_outbtnclicked")
    )

    local mainWndPushButtonHandler = theContext:makeLuaHandler(function(pack)
        mainWndPushButtonMatch:tryMatch(pack)
    end)

    theContext:message(mainWnd,VSig("mwnd_inattachmsg"),VMsg(mainWndPushButtonHandler))

end
initStuff()


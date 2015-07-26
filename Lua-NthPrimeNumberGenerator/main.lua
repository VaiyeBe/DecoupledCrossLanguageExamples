print('hello werld!')

initStuff = function()

    local theContext = luaContext()
    local mainWnd = theContext:namedMesseagable("mainWnd")

    theContext:attachContextTo(mainWnd)

    theContext:message(mainWnd,VSig("mwnd_insetlabel"),
        "Press GO to generate nth prime number")

    local mainWndPushButtonMatch = VMatchFunctor.create(
        VMatch(function()
            local gen = theContext:namedMesseagable("generator")
            theContext:message(mainWnd,VSig("mwnd_setgoenabled"),VBool(false))
            local out = theContext:messageRetValues(
                mainWnd,VSig("mwnd_querylabel"),VString("empty"))

            local num = tonumber(out._2)

            if (num == nil) then
                theContext:message(mainWnd,VSig("mwnd_insetlabel"),
                    "Number could not be parsed.")
                theContext:message(mainWnd,VSig("mwnd_setgoenabled"),VBool(true))
                return
            end

            local vmatch = VMatchFunctor.create(
                VMatch(function(natpack,val)
                    local theNum = val:values()._2
                    local updateStr = "Found " .. theNum .. " primes..."
                    local updatePercent = (theNum / num) * 100;
                    theContext:message(mainWnd,VSig("mwnd_insetlabel"),VString(updateStr))
                    theContext:message(mainWnd,VSig("mwnd_insetprog"),VInt( updatePercent ))
                end,
                "apg_asyncupdate","int"),
                VMatch(function(natpack,val)
                    local updateStr = "Nth prime number is: " .. val:values()._2
                    theContext:message(mainWnd,VSig("mwnd_insetlabel"),VString(updateStr))
                    theContext:message(mainWnd,VSig("mwnd_insetprog"),VInt( 100 ))
                    theContext:message(mainWnd,VSig("mwnd_setgoenabled"),VBool(true))
                end,
                "apg_asyncfinish","int")
            )
            updateHandler = theContext:makeLuaHandler(function(pack)
                print('boyz 2 men')
                vmatch:tryMatch(pack)
            end)
            theContext:attachToProcessing(updateHandler)
            theContext:message(gen,VSig("apg_asyncjob"),
                VMsg(updateHandler),VInt(num),VInt(100))
        end,"mwnd_outbtnclicked")
    )

    mainWndPushButtonHandler = theContext:makeLuaHandler(function(pack)
        mainWndPushButtonMatch:tryMatch(pack)
    end)

    theContext:message(mainWnd,VSig("mwnd_inattachmsg"),VMsg(mainWndPushButtonHandler))

end
initStuff()


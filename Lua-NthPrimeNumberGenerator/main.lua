print('hello werld!')

initStuff = function()

    local theContext = luaContext()
    local mainWnd = theContext:namedMesseagable("mainWnd")

    theContext:attachToProcessing(mainWnd)

    theContext:message(mainWnd,VSig("mwnd_insetlabel"),"CHOLO")

    local mainWndPushButtonMatch = VMatchFunctor.create(
        VMatch(function()
            print('oh noes!')
        end,VSig("mwnd_outbtnclicked"))
    )

    local mainWndPushButtonHandler = theContext:makeLuaHandler(function(pack)
        mainWndPushButtonMatch:tryMatch(pack)
    end)

    theContext:message(mainWnd,VSig("mwnd_inattachmsg"),VMsg(mainWndPushButtonHandler))

end
initStuff()


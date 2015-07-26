print('hello werld!')

initStuff = function()

    theContext = luaContext()
    mainWnd = theContext:namedMesseagable("mainWnd")

    theContext:attachToProcessing(mainWnd)

    theContext:message(mainWnd,VSig("mwnd_insetlabel"),"CHOLO")

    mainWndPushButtonMatch = VMatchFunctor.create(
        VMatch(function()
            print('oh noes!')
        end,VSig("mwnd_outbtnclicked"))
    )

    mainWndPushButtonHandler = theContext:makeLuaHandler(function(pack)
        mainWndPushButtonMatch.tryMatch(pack)
    end)

    theContext:message(mainWnd,VSig("mwnd_inattachmsg"),mainWndPushButtonHandler)

end
initStuff()


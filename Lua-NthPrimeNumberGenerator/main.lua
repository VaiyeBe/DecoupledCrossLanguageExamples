print('hello werld!')

theContext = luaContext()
mainWnd = theContext:namedMesseagable("mainWnd")

theContext:message(mainWnd,VSig("mwnd_insetlabel"),"CHOLO")

mainWndPushButtonMatch = VMatchFunctor.create(
    VMatch(function()
        print('oh noes!')
    end,VSig("mwnd_outbtnclicked"))
)


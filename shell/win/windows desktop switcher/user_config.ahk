
; === SYMBOLS ===
; !   <- Alt
; +   <- Shift
; ^   <- Ctrl
; #   <- Win
; For more, visit https://autohotkey.com/docs/Hotkeys.htm

Alt & `::switchDesktopByNumber(1)
Alt & 2::switchDesktopByNumber(2)
Alt & 3::switchDesktopByNumber(3)
Alt & 4::switchDesktopByNumber(4)
Alt & 5::switchDesktopByNumber(5)
Alt & 6::switchDesktopByNumber(6)
Alt & 7::switchDesktopByNumber(7)
Alt & 8::switchDesktopByNumber(8)
Alt & 9::switchDesktopByNumber(9)

^Left::Send  {Media_Prev}
^Right::Send {Media_Next}
^Up::Send    {Volume_Up}
^Down::Send  {Volume_Down}

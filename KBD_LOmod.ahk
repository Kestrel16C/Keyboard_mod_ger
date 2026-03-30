#Requires AutoHotkey v2.0
; --- Main remappings/ modes:

; Switches ' with #
#::'
+':: Send "{#}"

; Replaces numpad comma with a dot (non-numpad keys not affected)
; Toggle back via AltGr + ä if needed, set to dot by default.
global numpad_decimal_mode := true
<^>!ä:: {
    global numpad_decimal_mode
    numpad_decimal_mode := !numpad_decimal_mode
    numpad_decimal_mode ? A_TrayMenu.Check("Numpad Decimal Mode") : A_TrayMenu.Uncheck("Numpad Decimal Mode")
}
#HotIf (numpad_decimal_mode= true)
NumpadDot:: Send "."
#HotIf

; Additional input mode for remapping ö and ä to {} and ü to ~
; Uppercase Ö, Ä and Ü are remapped to [, ] and &
; Toggle via AltGr + ü, set to false/ disabled by default
global coding_mode := false
<^>!ü:: {
    global coding_mode
    coding_mode := !coding_mode
    coding_mode ? A_TrayMenu.Check("Coding Mode") : A_TrayMenu.Uncheck("Coding Mode")
}
#HotIf (coding_mode= true)
ö:: Send "{{}"
Ö:: Send "["
ä:: Send "{}}"
Ä:: Send "]"
ü:: Send "~"
Ü:: Send "&"
ß:: Send "\"
#HotIf

; --- Below are utility additions:

; Addition for laptops w/o media fn-keys: Media playback controls
; OS-key + Alt + arrow keys
#!Left::Send("{Media_Prev}")
#!Right::Send("{Media_Next}")
#!Down::Send("{Media_Play_Pause}")

; Taskbar toggle key via OS key + space
#Space:: ToggleTaskbar()
ToggleTaskbar() {
    static hide := false
    static ABM_SETSTATE := 0xA
    static ABS_AUTOHIDE := 0x1
    static ABS_ALWAYSONTOP := 0x2
    hide := !hide
    size := 2*A_PtrSize + 2*4 + 16 + A_PtrSize
    APPBARDATA := Buffer(size, 0)
    NumPut("UInt", size, APPBARDATA, 0)
    NumPut("Ptr", WinExist("ahk_class Shell_TrayWnd"), APPBARDATA, A_PtrSize)
    NumPut("Ptr", hide ? ABS_AUTOHIDE : ABS_ALWAYSONTOP, APPBARDATA, size - A_PtrSize)
    DllCall("Shell32\SHAppBarMessage", "UInt", ABM_SETSTATE, "Ptr", APPBARDATA)
}

; --- Tray indicators and mode selectors
A_TrayMenu.Delete()
A_TrayMenu.Add("Coding Mode", ToggleCodingMode)
A_TrayMenu.Add("Numpad Decimal Mode", ToggleNumpadMode)
A_TrayMenu.Add()
A_TrayMenu.Add("Exit", (*) => ExitApp())
A_TrayMenu.Check("Numpad Decimal Mode")

ToggleCodingMode(*) {
    global coding_mode
    coding_mode := !coding_mode
    coding_mode ? A_TrayMenu.Check("Coding Mode") : A_TrayMenu.Uncheck("Coding Mode")
}

ToggleNumpadMode(*) {
    global numpad_decimal_mode
    numpad_decimal_mode := !numpad_decimal_mode
    numpad_decimal_mode ? A_TrayMenu.Check("Numpad Decimal Mode") : A_TrayMenu.Uncheck("Numpad Decimal Mode")
}
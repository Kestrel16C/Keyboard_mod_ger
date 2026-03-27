#Requires AutoHotkey v2.0
; Meant for use with German keyboards

; Switches ' with #
#::'
+':: Send "{#}"

; Replaces numpad comma with a dot (non-numpad keys not affected)
; Toggle back via AltGr + ä if needed, set to dot by default.
global numpad_decimal_mode := true
<^>!ä:: {
    global numpad_decimal_mode
    numpad_decimal_mode := !numpad_decimal_mode
}
#HotIf (numpad_decimal_mode= true)
NumpadDot:: Send "."
#HotIf

; Additional input mode for remapping ö and ä to {} and ü to \
; Toggle via AltGr + ü, set to true/ enabled by default
global coding_mode := true
<^>!ü:: {
    global coding_mode
    coding_mode := !coding_mode
}
#HotIf (coding_mode= true)
ö:: Send "{{}"
ä:: Send "{}}"
ü:: Send "\"
#HotIf

; Below are utility additions:

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
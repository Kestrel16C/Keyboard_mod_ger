#Requires AutoHotkey v2.0
; --- Main remappings/ modes:

; Switches ' with #
#::'
+':: Send "{#}"

; --- Mode state (defaults)
global numpad_decimal_mode := true
global coding_mode := false
global wasd_to_arrow := true

; --- Toggle functions (single source of truth for state + tray check)
ToggleNumpadMode(*) {
    global numpad_decimal_mode
    numpad_decimal_mode := !numpad_decimal_mode
    numpad_decimal_mode ? A_TrayMenu.Check("Numpad Decimal Mode") : A_TrayMenu.Uncheck("Numpad Decimal Mode")
}

ToggleCodingMode(*) {
    global coding_mode
    coding_mode := !coding_mode
    coding_mode ? A_TrayMenu.Check("Coding Mode") : A_TrayMenu.Uncheck("Coding Mode")
}

ToggleWASD(*) {
    global wasd_to_arrow
    wasd_to_arrow := !wasd_to_arrow
    wasd_to_arrow ? A_TrayMenu.Check("WASD to Arrow Mode") : A_TrayMenu.Uncheck("WASD to Arrow Mode")
}

; --- Mode toggle hotkeys (route through the same function as the tray menu)
<^>!ä::ToggleNumpadMode()
<^>!ü::ToggleCodingMode()
<^>!ö::ToggleWASD()

; --- Numpad: replaces numpad comma with a dot (non-numpad keys not affected)
#HotIf numpad_decimal_mode
NumpadDot:: Send "."
#HotIf

; --- Coding mode: ö/ä → {}, ü → ~, Ö/Ä → [], Ü → &, ß → \
#HotIf coding_mode
ö:: Send "{{}"
Ö:: Send "["
ä:: Send "{}}"
Ä:: Send "]"
ü:: Send "/"
Ü:: Send "&"
ß:: Send "\"
#HotIf

; --- Alt + WASD as arrow keys
#HotIf wasd_to_arrow
!w:: Send "{Up}"
!s:: Send "{Down}"
!a:: Send "{Left}"
!d:: Send "{Right}"
#HotIf

; --- Below are utility additions:

; Media playback controls for laptops w/o media fn-keys
; Win + Alt + arrow keys
#!Left::Send("{Media_Prev}")
#!Right::Send("{Media_Next}")
#!Down::Send("{Media_Play_Pause}")

; Taskbar toggle via Win + Space
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
A_TrayMenu.Add("WASD to Arrow Mode", ToggleWASD)
A_TrayMenu.Add()
A_TrayMenu.Add("Reload", (*) => Reload())
A_TrayMenu.Add("Exit", (*) => ExitApp())

; Initial check state derived from variables, not hardcoded strings
if numpad_decimal_mode
    A_TrayMenu.Check("Numpad Decimal Mode")
if coding_mode
    A_TrayMenu.Check("Coding Mode")
if wasd_to_arrow
    A_TrayMenu.Check("WASD to Arrow Mode")
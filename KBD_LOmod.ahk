#Requires AutoHotkey v2.0

; --- Config loading
ConfigFile := A_ScriptDir "\kbd_mod.cfg"

; Defaults (used if .cfg is missing entries or the file doesn't exist)
global numpad_decimal_mode := IniRead(ConfigFile, "Defaults", "NumpadDecimalMode", "1") = "1"
global coding_mode         := IniRead(ConfigFile, "Defaults", "CodingMode",         "0") = "1"
global wasd_to_arrow       := IniRead(ConfigFile, "Defaults", "WASDToArrowMode",    "1") = "1"

ToggleNumpadHotkey := IniRead(ConfigFile, "Hotkeys", "ToggleNumpadDecimal", "<^>!ä")
ToggleCodingHotkey := IniRead(ConfigFile, "Hotkeys", "ToggleCoding",        "<^>!ü")
ToggleWASDHotkey   := IniRead(ConfigFile, "Hotkeys", "ToggleWASD",          "<^>!ö")

; --- Switches ' with #
#::'
+'::Send "{#}"

; --- Toggle functions
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

; --- Register toggle hotkeys from config
try Hotkey(ToggleNumpadHotkey, ToggleNumpadMode)
catch as e
    MsgBox "Invalid hotkey for ToggleNumpadDecimal: " ToggleNumpadHotkey "`n" e.Message

try Hotkey(ToggleCodingHotkey, ToggleCodingMode)
catch as e
    MsgBox "Invalid hotkey for ToggleCoding: " ToggleCodingHotkey "`n" e.Message

try Hotkey(ToggleWASDHotkey, ToggleWASD)
catch as e
    MsgBox "Invalid hotkey for ToggleWASD: " ToggleWASDHotkey "`n" e.Message

; --- Mode-conditional remaps (unchanged)
#HotIf numpad_decimal_mode
NumpadDot::Send "."
#HotIf

#HotIf coding_mode
ö::Send "{{}"
Ö::Send "["
ä::Send "{}}"
Ä::Send "]"
ü::Send "/"
Ü::Send "&"
ß::Send "\"
#HotIf

#HotIf wasd_to_arrow
!w::Send "{Up}"
!s::Send "{Down}"
!a::Send "{Left}"
!d::Send "{Right}"
#HotIf

; --- Utility hotkeys
#!Left::Send("{Media_Prev}")
#!Right::Send("{Media_Next}")
#!Down::Send("{Media_Play_Pause}")

#Space::ToggleTaskbar()
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

; --- Tray menu
A_TrayMenu.Delete()
A_TrayMenu.Add("Coding Mode", ToggleCodingMode)
A_TrayMenu.Add("Numpad Decimal Mode", ToggleNumpadMode)
A_TrayMenu.Add("WASD to Arrow Mode", ToggleWASD)
A_TrayMenu.Add()
A_TrayMenu.Add("Reload", (*) => Reload())
A_TrayMenu.Add("Exit", (*) => ExitApp())

if numpad_decimal_mode
    A_TrayMenu.Check("Numpad Decimal Mode")
if coding_mode
    A_TrayMenu.Check("Coding Mode")
if wasd_to_arrow
    A_TrayMenu.Check("WASD to Arrow Mode")
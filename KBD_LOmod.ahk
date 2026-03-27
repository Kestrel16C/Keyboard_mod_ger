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

; Addition for laptops w/o media fn-keys: Media playback controls
; OS-key + Alt + arrow keys
#!Left::Send("{Media_Prev}")
#!Right::Send("{Media_Next}")
#!Down::Send("{Media_Play_Pause}")

; Additional input mode for remapping ö and ä to {} and ü to \
; Toggle via AltGr + ü, set to on by default.
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
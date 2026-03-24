#Requires AutoHotkey v2.0

; Replaces ' with #
NumpadDot:: Send "."
#::'
+':: Send "{#}"

; Addition for laptops w/o media fn-keys: Media playback controls
; OS-key + Alt + arrow keys
#!Left::Send("{Media_Prev}")
#!Right::Send("{Media_Next}")
#!Down::Send("{Media_Play_Pause}")

; Additional input mode for remapping ö and ä to {} and ü to \
; Toggle via AltGr+ü, set to on by default.
global mode_1Enabled := true
<^>!ü:: {
    global mode_1Enabled
    mode_1Enabled := !mode_1Enabled
}
#HotIf (mode_1Enabled= true)
ö:: Send "{{}"
ä:: Send "{}}"
ü:: Send "\"
#HotIf
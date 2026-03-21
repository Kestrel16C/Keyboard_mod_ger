#Requires AutoHotkey v2.0

NumpadDot:: Send "."
#::'
+':: Send "{#}"

; Addition for laptops w/o media fn-keys: Media playback controls
#!Left::Send("{Media_Prev}")
#!Right::Send("{Media_Next}")
#!Down::Send("{Media_Play_Pause}")
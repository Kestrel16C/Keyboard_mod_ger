#Requires AutoHotkey v2.0

; --- IME helper (from zero-plusplus gist, trimmed to essentials) --- 
; only used here not to interfere with IME.
class Ime {
  static getStatus() {
    static IMC_GETOPENSTATUS := 0x0005
    return !!(this._sendMessage(IMC_GETOPENSTATUS))
  }
  static _sendMessage(wParam, lParam := 0) {
    static WM_IME_CONTROL := 0x0283
    hwndIme := DllCall("imm32\ImmGetDefaultIMEWnd", "UInt", WinActive("A"), "UInt")
    return DllCall(
      "SendMessage",
      "UInt", hwndIme,
      "UInt", WM_IME_CONTROL,
      "Int",  wParam,
      "Int",  lParam,
      "Ptr"
    )
  }
}

#HotIf !Ime.getStatus()
NumpadDot:: Send "."
#::'
+':: Send "{#}"
#HotIf

; Addition for laptops w/o media fn-keys: Media playback controls
#!Left::Send("{Media_Prev}")
#!Right::Send("{Media_Next}")
#!Down::Send("{Media_Play_Pause}")
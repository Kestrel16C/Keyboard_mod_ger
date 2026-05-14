# KBD_LOmod — German Keyboard Layout Modifier

AHK v2 script with utility additions for German keyboards.

## Features

### Layout fixes
- **# / ' swap** — `#` outputs `'` by default and vice versa
- **Numpad decimal** — NumpadDot outputs `.` instead of `,`, on by default (toggle anytime: `AltGr+ä`)
- **Coding mode** — off by default, toggle anytime via `AltGr+ü`
  - `ö` → `{`, `Ö` → `[`
  - `ä` → `}`, `Ä` → `]`
  - `ü` → `/`, `Ü` → `&`
  - `ß` → `\`
- **WASD as arrow keys** — `Alt+W/A/S/D` act as `↑/←/↓/→`, on by default (toggle anytime: `AltGr+ö`). Useful for cursor navigation when editing text without leaving the home row.

### Utilities
- **Media keys** — `Win+Alt+←/→/↓` for previous/next/play-pause, for laptops without dedicated media keys
- **Taskbar toggle** — `Win+Space` toggles taskbar auto-hide on/off via Windows AppBar API, no Explorer restart required

### Tray menu
Right-clicking the tray icon allows toggling coding mode, numpad decimal mode, and WASD-to-arrow mode directly, with checkmarks reflecting the current state.

## Configuration

A `kbd_mod.cfg` file in the same folder as the executable controls startup defaults and the toggle hotkeys. If the file is missing or incomplete, built-in defaults are used — the script works without it. A baseline `kbd_mod.cfg` is shipped with the repo as a starting point.

Example `kbd_mod.cfg`:

```ini
[Defaults]
; 1 = on at startup, 0 = off
NumpadDecimalMode=1
CodingMode=0
WASDToArrowMode=1

[Hotkeys]
; AHK v2 hotkey syntax:
;   ^ = Ctrl, ! = Alt, + = Shift, # = Win
;   < = left modifier, > = right modifier
;   <^>! = AltGr
ToggleNumpadDecimal=<^>!ä
ToggleCoding=<^>!ü
ToggleWASD=<^>!ö
```

After editing, reload via the tray menu (**Reload**) to apply changes.

## Setup

No AHK installation required — use the compiled `KBD_LOmod.exe` directly. Alternatively compile the AHK source yourself. Requires AutoHotkey 2.0.

To run on startup:
1. Press `Win+R` and type `shell:startup`
2. Place a shortcut of `KBD_LOmod.exe` in the folder that opens

If you want to customize defaults or toggle hotkeys, place `kbd_mod.cfg` next to the executable.

## Note on Windows Security

Windows **Smart App Control** silently evaluates software in the background and may block the exe on startup, as keyboard remapping can resemble keylogger behavior. If the script stops working after running from startup, check whether Smart App Control is blocking it under **Settings → Privacy & Security → Windows Security → App & Browser Control**. Turning it off permanently resolves this.
# KBD_LOmod — German Keyboard Layout Modifier

AHK v2 script with utility additions for German keyboards.

## Features

### Layout fixes
- **# / ' swap** — `#` outputs `'` by default and vice versa
- **Numpad decimal** — NumpadDot outputs `.` instead of `,`, on by default (toggle anytime: `AltGr+ä`)
- **Coding mode** — `ö` → `{`, `ä` → `}`, `ü` → `\`, on by default (toggle anytime: `AltGr+ü`)

### Utilities
- **Media keys** — `Win+Alt+←/→/↓` for previous/next/play-pause, for laptops without dedicated media keys
- **Taskbar toggle** — `Win+Space` toggles taskbar auto-hide on/off via Windows AppBar API, no Explorer restart required

## Setup

No AHK installation required — use the compiled `KBD_LOmod.exe` directly. Alternatively compile ahk source code yourself. Requires Autohotkey 2.0

To run on startup:
1. Press `Win+R` and type `shell:startup`
2. Place a shortcut of `KBD_LOmod.exe` in the folder that opens

## Note on Windows Security

Windows **Smart App Control** silently evaluates software in the background and may block the exe on startup, as keyboard remapping can resemble keylogger behavior. If the script stops working after running from startup, check whether Smart App Control is blocking it under **Settings → Privacy & Security → Windows Security → App & Browser Control**. Turning it off permanently resolves this.
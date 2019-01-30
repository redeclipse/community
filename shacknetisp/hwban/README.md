# Beha's HWBan System
Add `exec hwban.cfg` to your `autoexec.cfg`.
Then use bans like this (the ID must be unique for each ban and consist of alphanumeric characters and underscores):
```
// Create ban with ID "someguy" to ban all win32 clients.
hwban.ban "someguy" [
	// Windows
	[(= (getclientversion $cn 4) 0)]
	// 32-bit
	[(= (getclientversion $cn 5) 32)]
]
```


#How to use scripts in Red Eclipse

## save the config file
- select a file from the above list
- press the *Raw* button to view it as raw text
- select all and copy, then paste and save using a text editor, such as vim, gedit, emacs or notepad
- store the script in your Red Eclipse user content

## where to find RE user content
On windows, look for the "My Games" folder in your "documents", on linux or OSX, check the app data in your home dir:
- Windows
`%USERPROFILE%\My Documents\My Games\Red Eclipse`

- Linux
`~/.redeclipse`

- Mac/OSX
`/Users/<username>/Library/Application Support/Red Eclipse`
    
## executing scripts

Use the game chat (Return or T Key) or the console (backslash or backquote key) to enter a command like:
`/exec myscriptname.cfg`
To run the script automatically on startup, put the same line (without the leading slash) in your autoexec.cfg
`exec myscriptname.cfg`

## further reading
See our wiki, redeclipse.net/wiki/Cubescript

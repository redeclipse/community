# chatlogger for windows - put this in your RE user content dir (typically documents\My Games\Red Eclipse)
# then use it instead of the game launcher, which is called right after saving a copy of recent chat lines
findstr /R "<.*>" log.txt >> chatlog.txt
"C:\Program Files (x86)\Red Eclipse\redeclipse.bat"

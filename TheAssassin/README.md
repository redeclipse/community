# TheAssassin's Red Eclipse community stuff


## Desktop file

You can use the desktop file to launch Red Eclipse from your desktop
environment's launcher.

Optional: Download the .ico file, put it in your Red Eclipse directory.

Then, download `redeclipse.desktop`, edit the paths inside and put it in
either `~/.local/share/applications/` or, depending on your system, if
the other directory does not work, `/usr/local/share/applications` or
`/usr/share/applications`.

The game should then show up in your launcher.


### URL support

Now that Red Eclipse supports `redeclipse://` URLs, you can register your
desktop file as a handler for those.

Please edit `~/.local/share/applications/mimeapps.list` and add the following
line:

    x-scheme-handler/redeclipse=redeclipse.desktop

# Red Eclipse server systemd configuration


## About

This script can be used to properly manage a Red Eclipse server on any server
running systemd.


## Alternative projects

If you want an even easier way to manage your Red Eclipse servers, check out
my Red Eclipse docker container:

https://github.com/TheAssassin/redeclipse-docker


## How to use it

This script assumes that your system meets the following conditions:

  - A system user called `redeclipse` -- you can add such a user with a command
    like this: `sudo adduser --system --group --disabled-login
    --disabled-password --home /srv/redeclipse redeclipse`
  - A directory `/srv/redeclipse` for game data and server configuration
    (i.e. the server home directory, see Red Eclipse docs for more information
    on this)
  - A Red Eclipse installation in `/srv/redeclipse/base` -- see first step for
    a guide how to install it from git

First of all, you will have to install Red Eclipse. The script assumes that
the distribution is in `/srv/redeclipse/base`, the home directory of the
`redeclipse` user.

If you haven't created it yet, please create the `redeclipse` user:

    sudo adduser --system --group --disabled-login --disabled-passwd \
    --home /srv/redeclipse redeclipse

Now put a distribution of Red Eclipse in the new home directory.
The easiest way to get Red Eclipse is installing it from Git.

    # install Git and all the build dependencies
    # you should know how to use your system's package manager, this example
    # shows how to do it on Debian-based systems
    sudo apt install git build-essential libsdl2-dev \
        libsdl2-image-dev libsdl2-mixer-dev zlib1g-dev

    # get a shell for the redeclipse user
    sudo -sHu redeclipse

    # go to the home directory
    cd /srv/redeclipse

    # install Git and clone the repository
    git clone -b stable --recursive https://github.com/red-eclipse/base.git

    # build the game
    cd base
    make -C src -j8 server install-server

    # optional: leave the redeclipse user shell
    exit

To continue, create some server home directories (where the configuration goe
for example):

    # get a shell for the redeclipse user
    sudo -sHu redeclipse

    # create the base directory
    cd /srv/redeclipse/
    mkdir servers/
    cd servers/

    # create a few server homes
    mkdir main/
    #mkdir secondary
    #mkdir tertiary
    #mkdir ...

You can/should copy the `servinit.cfg` example from the GitHub repository to
those new home directories to configure the server.

Now copy both service scripts to the directory `/etc/systemd/system/` (use
the identifier you assigned to the directory).

The script is a so-called systemd template, that means you don't have to
configure every single server.

And that's it! Reload your systemd daemon and the service should work as any
other one on your server.

    sudo systemctl daemon-reload

    # starts all the services
    sudo systemctl redeclipse start

    # view the status of a single service identified by its home directory's
    # name
    sudo systemctl status redeclipse@main

The last command shows you if the service has successfully started and is
running.


## Notes

By default, the Red Eclipse service will shutdown itself once a day to
eventually apply updates. The script that triggers the update automatically
restarts the service in that case. These service scripts don't use the Red
Eclipse auto updater, which means the restart is pointless.

For your convenience, the service automatically restarts itself on such
shutdowns. Of course, if you use `systemctl` to stop them, it won't restart.

If you wish to disable those automatic shutdowns, please edit your
`servinit.cfg` and append the following snippet:

    maxruntime 0

By default, the services restart themselves on any crashes, as the server is
not perfect (what ever is perfect though). You can change the value `Restart=`
to `Restart=on-success` if you do not want the server to automatically restart
on every crash but only automatic shutdowns.

If you want to host different versions of your servers, you will have to copy
the service files, have to edit them and then have to create a separate
Red Eclipse distribution and another server home directory base.
As this is an advanced configuration, this is not covered here. Feel free to
add instructions.

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
    git clone --recursive https://github.com/red-eclipse/base.git

    # build the game
    cd base
    make -C src -j8 all install

    # optional: leave the redeclipse user shell
    exit

As you might guess from its name, `redeclipse-NAME.service` is a template.
This way, you can run multiple Red Eclipse servers in parallel.

`NAME` should be substituted with a descriptive identifier.

First, create some server home directories (where the configuration goes for
example):

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

Now copy the script to the directory `/etc/systemd/system/` and rename it (use
the identifier you assigned to the directory).

Next, edit the script, and replace `NAME` in the environment variable
assignment that specifies the server home.

And that's it! Reload your systemd daemon and the service should work as any
other one on your server.

    sudo systemctl daemon-reload
    sudo systemctl redeclipse-NAME start
    sudo systemctl redeclipse-NAME status

The last command shows you if the service works.

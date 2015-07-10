#!/bin/bash

cd redeclipse-git

git checkout master
git pull
git submodule update

REV=$(git rev-parse --short HEAD)
echo "gitver = "$REV > gitver.cfg

make -C src/ clean
rm bin/redeclipse_*
make -C src/ -j2 server
kill $(<"run.pid")
make -C src/ install-server

REDECLIPSE_BRANCH="inplace"
nohup ./redeclipse_server.sh >> log.txt 2>&1 & echo $! > run.pid
echo "Red Eclipse recompiled and restarted."

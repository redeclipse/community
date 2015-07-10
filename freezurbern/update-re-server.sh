#!/bin/bash
RED='\033[0;31m' # Red output
YELLOW='\033[1;33m' # Yellow output
GREEN='\033[0;32m' # Green output
NC='\033[0m' # No Color

cd /home/zachery/redeclipse-git

if [ "$1" == "start" ]; then
    echo -e "${RED}Starting server${NC}"
    nohup ./redeclipse_server.sh >> log.txt 2>&1 & echo $! > run.pid
	echo -e "${GREEN}Red Eclipse recompiled and restarted.${NC}"
    echo -e "${GREEN}==========================================${NC}"
    exit 0
fi

echo -e "${RED}Downloading updates${NC}"
git checkout master
git pull
git submodule update
echo -e "${YELLOW}Updates received${NC}"

echo -e "${RED}Writing version information to file${NC}"
  REV=$(git rev-parse --short HEAD)
echo -e "gitver = "$REV > gitver.cfg

echo -e "${RED}Compiling server${NC}"
  make -C src/ clean
  rm bin/redeclipse_*
  make -C src/ -j2 server

echo -e "${RED}Sending shutdown signal to server...${NC}"
  kill $(<"run.pid")
echo -e "${YELLOW}Signal sent. Waiting for server to shutdown...${NC}"
  while [ -e /proc/$(<"run.pid") ]; do sleep 1; done
echo -e "${YELLOW}... Server completed shutdown. Installing new binary.${NC}"
  make -C src/ install-server
echo -e "${YELLOW}Giving old server IRC bot time to disconnect. 10 seconds.${NC}"
  sleep 10

echo -e "${RED}Starting server...${NC}"
  REDECLIPSE_BRANCH="inplace"
  nohup ./redeclipse_server.sh >> log.txt 2>&1 & echo $! > run.pid
echo -e "${GREEN}Red Eclipse recompiled and restarted.${NC}"
echo -e "${GREEN}==========================================${NC}"
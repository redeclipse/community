#!/bin/sh

#install-rr.sh
#Written by Sam Klein

USER="$(whoami)"

ORANGE='\033[0;33m'
RED='\033[0;31m'
PURPLE='\033[1;35m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}Creating new path.${NC}"
echo -e "${CYAN}Installing v1.5.3 from IndieBD.${NC}"
wget http://www.indiedb.com/downloads/mirror/87522/112/28c01fd1cf31a26b68ea06acead13687 -O redeclipse.1.5.3.tar.bz2
bunzip2 -d redeclipse.1.5.3.tar.bz2
tar xvf redeclipse.1.5.3.tar
mv redeclipse-1.5.3/ /home/$USER/RedRecorder/
bash /home/$USER/RedRecorder/redeclipse-1.5.3/redeclipse.sh

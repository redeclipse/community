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

echo -e "${PURPLE}What's your in-game username?${NC}"
read NAME

	mkdir /home/$USER/RedRecorder/
	touch /home/$USER/RedRecorder/user
	NEW_NAME=/home/$USER/RedRecorder/user
	echo $NAME > $NEW_NAME
	echo -e "${CYAN}Creating folder RedRecorder in home directory.${NC}"
	mkdir /home/$USER/RedRecorder/.Logs
	mkdir /home/$USER/RedRecorder/.Scores
	touch /home/$USER/RedRecorder/.Scores/POSITIVE
	touch /home/$USER/RedRecorder/.Scores/NEGATIVE
	NEW_POSITIVE_TOTAL=/home/$USER/RedRecorder/.Scores/POSITIVE
	NEW_NEGATIVE_TOTAL=/home/$USER/RedRecorder/.Scores/NEGATIVE
	echo -e "${CYAN}Checking for installation path.${NC}"
	bash install-re.sh
	NUMBER="$(ls -l /home/$USER/RedRecorder/.Logs | grep -v ^l | wc -l)"
	cp ~/.redeclipse/log.txt /home/$USER/RedRecorder/.Logs
	mv /home/$USER/RedRecorder/.Logs/log.txt /home/$USER/RedRecorder/.Logs/$NUMBER
	POS_SCORE="$(grep "by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
	NEG_SCORE="$(grep "$NAME was" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
	echo -e "Your score for this session: ${GREEN}$POS_SCORE${NC} ${CYAN}/${NC} ${RED}$NEG_SCORE${NC}"
	echo $POS_SCORE > $NEW_POSITIVE_TOTAL
	echo $NEG_SCORE > $NEW_NEGATIVE_TOTAL

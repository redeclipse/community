#!/bin/sh

#RedRecorder.sh
#Written by Sam Klein

USER="$(whoami)"
NAME="$(cat /home/$USER/RedRecorder/user)"
		
		### Normal Frag ###
		POS_FRAG_SCORE="$(grep "by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
		### Assists ###
		POS_ASSIST_SCORE_ONE="$(grep "assisted by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
		POS_ASSIST_SCORE_TWO="$(grep "helped by $NAME" /home/$USER/RedRecorder/.Logs/$NUMBER | wc -l)"
		### Weapons ###
		

# trivial script to keep a copy of all chat logged
# works also on win if you are using Git Bash or MinGW
# note: the home dir location differs for the stable branch
egrep '<.*>' home/log.txt >> home/chatlog.txt 
sh redeclipse.sh 

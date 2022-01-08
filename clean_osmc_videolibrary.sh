#!/bin/bash
#nettoyage de la médiathèque osmc

if [ -f "/mnt/osmc/pegasus1/check_pegasus1.txt" ]
	then
		echo -e "Pegasus1 est monté.";
	else
		echo -e "\nATTENTION pegasus1 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi

if [ -f "/mnt/osmc/pegasus2/check_pegasus2.txt" ]
	then
		echo -e "Pegasus2 est monté.";
	else
		echo -e "\nATTENTION pegasus2 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi
				
if [ -f "/mnt/osmc/pegasus3/check_pegasus3.txt" ]
	then
		echo -e "Pegasus3 est monté.";
	else
		echo -e "\nATTENTION pegasus3 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi		
		
if [ -f "/mnt/osmc/pegasus4/check_pegasus4.txt" ]
	then
		echo -e "Pegasus4 est monté.";
	else
		echo -e "\nATTENTION pegasus4 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi


ssh osmc@192.168.1.21 'xbmc-send --action="CleanLibrary(video)"' && echo -e "\nNettoyage de la médiathèque effectué" && sleep 5


#fin du script

#!/bin/bash
#nettoyage de la médiathèque osmc

if [ -d "/mnt/osmc/pegasus1/films" ]
	then
		echo -e "Pegasus1 est monté.";
	else
		echo -e "\nATTENTION pegasus1 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi

if [ -d "/mnt/osmc/pegasus2/films" ]
	then
		echo -e "Pegasus2 est monté.";
	else
		echo -e "\nATTENTION pegasus2 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi
				
if [ -d "/mnt/osmc/pegasus3/films" ]
	then
		echo -e "Pegasus3 est monté.";
	else
		echo -e "\nATTENTION pegasus3 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi		
		
if [ -d "/mnt/osmc/pegasus4/films" ]
	then
		echo -e "Pegasus4 est monté.";
	else
		echo -e "\nATTENTION pegasus4 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi


ssh osmc@192.168.1.21 'xbmc-send --action="CleanLibrary(video)"' && echo -e "\nNettoyage de la médiathèque effectué" && sleep 5


#fin du script

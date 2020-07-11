#!/bin/bash
#nettoyage de la médiathèque osmc


ssh osmc@192.168.0.21 'xbmc-send --action="CleanLibrary(video)"' && echo -e "\nNettoyage de la médiathèque effectué" && sleep 5


#fin du script
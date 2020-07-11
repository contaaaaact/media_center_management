#!/bin/bash
#mise à jour de la médiathèque osmc


ssh osmc@192.168.0.21 'xbmc-send --action="UpdateLibrary(video)"' && echo -e "\nMise a jour médiathèque effectuée" && sleep 5

#fin du script
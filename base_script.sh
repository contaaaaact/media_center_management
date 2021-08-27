#!/bin/bash
#rsync des films 4k de demetrius vers pegasus4k

#verification de la presence de /media/pegasus4k/films_4k

if ssh osmc@192.168.1.21 [ -d "/media/pegasus4k/films_4k/" ];then
	echo "Le chemin vers les films 4k de Pegasus4k existe, bond PRL initialisé !";
else echo "Le chemin vers les films 4k de Pegasus4k n'existe pas, bond PRL annulé." && sleep 1d
fi && echo "RDV de l'autre côté !" && sleep 1


#rsync x2 entre demetrius et pegasus4k

rsync -rtv --progress -e ssh /media/pi/demetrius/download_center/films_4k/ osmc@192.168.1.21:/media/pegasus4k/films_4k/ && rsync -rtv --progress -e ssh /media/pi/demetrius/download_center/films_4k/ osmc@192.168.1.21:/media/pegasus4k/films_4k/ && echo "Bond PRL effectué avec succès !"


#demander suppression des fichiers sur demetrius
#echo "Voulez vous supprimer la source de demetrius ? (oui/non)"
#select i in oui non; do
#if [ "$i" = "oui" ];then
#	echo "Suppression initialisée" && sleep 5 && rm -rf /media/pi/demetrius/download_center/films_4k/* && echo "suppression effectuée" && sleep 5
#	break
#
#elif [ "$i" = "non" ];then
#	echo "Suppression annulée" && sleep 5
#	break

#else
#	echo "Mauvaise réponse"
#                
#fi

done

#fin du script

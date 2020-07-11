#!/bin/bash
#suppression de fichiers en ssh surles disques externes de osmc depuis un montage nfs


echo "Vous souhaitez supprimer le fichier :"
echo -e "\n$1"

NomFichier=`basename "$1"`

case "$1" in
	*/osmc/pegasus1/*)
			echo -e "\nLe fichier '$NomFichier' est sur le disque :"
			echo "pegasus1"
			echo -e "\nATTENTION !"
			echo " "
			ssh osmc@192.168.0.21 "find /mnt/osmc/pegasus1/ -type f -name '"$NomFichier"' -exec rm -riv '{}' \;" && \
			find /mnt/pi/galactica1/ -type f -name $NomFichier -exec rm -riv '{}' \;
			;;

	*/osmc/pegasus2/*)
			echo -e "\nLe fichier '$NomFichier' est sur le disque :"
			echo "pegasus2"
			echo -e "\nATTENTION !"
			echo " "
			ssh osmc@192.168.0.21 "find /mnt/osmc/pegasus2/ -type f -name '"$NomFichier"' -exec rm -riv '{}' \;" && \
			find /mnt/pi/galactica2/ -type f -name $NomFichier -exec rm -riv '{}' \;
			;;

	*/osmc/pegasus3/*)
			echo -e "\nLe fichier '$NomFichier' est sur le disque :"
			echo "pegasus3"
			echo -e "\nATTENTION !"
			echo " "
			ssh osmc@192.168.0.21 "find /mnt/osmc/pegasus3/ -type f -name '"$NomFichier"' -exec rm -riv '{}' \;" && \
			find /mnt/pi/galactica3/ -type f -name $NomFichier -exec rm -riv '{}' \;
			;;
	
	*/osmc/pegasus4/*)
			echo -e "\nLe fichier '$NomFichier' est sur le disque :"
			echo "pegasus4"
			echo -e "\nATTENTION !"
			echo " "
			ssh osmc@192.168.0.21 "find /mnt/osmc/pegasus4/ -type f -name '"$NomFichier"' -exec rm -riv '{}' \;" && \
			find /mnt/pi/galactica4/ -type f -name $NomFichier -exec rm -riv '{}' \;
			;;
	*/pi/galactica1/*)
			echo -e "\nLe fichier '$NomFichier' est sur le disque :"
			echo "galactica1"
			echo -e "\nATTENTION !"
			echo " "
			find /mnt/pi/galactica1/ -type f -name $NomFichier -exec rm -riv '{}' \; && \
			ssh osmc@192.168.0.21 "find /mnt/osmc/pegasus1/ -type f -name '"$NomFichier"' -exec rm -riv '{}' \;"
			;;

	*/pi/galactica2/*)
			echo -e "\nLe fichier '$NomFichier' est sur le disque :"
			echo "galactica2"
			echo -e "\nATTENTION !"
			echo " "
			find /mnt/pi/galactica2/ -type f -name $NomFichier -exec rm -riv '{}' \; && \
			ssh osmc@192.168.0.21 "find /mnt/osmc/pegasus2/ -type f -name '"$NomFichier"' -exec rm -riv '{}' \;"
			;;

	*/pi/galactica3/*)
			echo -e "\nLe fichier '$NomFichier' est sur le disque :"
			echo "galactica3"
			echo -e "\nATTENTION !"
			echo " "
			find /mnt/pi/galactica3/ -type f -name $NomFichier -exec rm -riv '{}' \; && \
			ssh osmc@192.168.0.21 "find /mnt/osmc/pegasus3/ -type f -name '"$NomFichier"' -exec rm -riv '{}' \;"
			;;
	
	*/pi/galactica4/*)
			echo -e "\nLe fichier '$NomFichier' est sur le disque :"
			echo "galactica4"
			echo -e "\nATTENTION !"
			echo " "
			find /mnt/pi/galactica4/ -type f -name $NomFichier -exec rm -riv '{}' \; && \
			ssh osmc@192.168.0.21 "find /mnt/osmc/pegasus4/ -type f -name '"$NomFichier"' -exec rm -riv '{}' \;"
			;;	
			
	*/pi/demetrius/*)
			echo -e "\nLe fichier '$NomFichier' est sur le disque :"
			echo "demetrius"
			echo -e "\nATTENTION !"
			echo " "
			find /mnt/pi/demetrius/ -type f -name $NomFichier -exec sudo rm -riv '{}' \;
			;;		
	*)
			echo -e "\nLe fichier '$NomFichier' n'est pas sur un disque OSMC."
			echo -e "Suppression annulée."
			;;
esac



sleep 5

exit 0


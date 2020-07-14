#!/bin/bash
#rsync des films de demetrius vers pegasus puis backup sur galactica


DFpegasus1=`df -h /mnt/osmc/pegasus1 | grep "/mnt/osmc" | awk ' { print $5 } ' | sed -e 's/%//g'`
DFpegasus2=`df -h /mnt/osmc/pegasus2 | grep "/mnt/osmc" | awk ' { print $5 } ' | sed -e 's/%//g'`
DFpegasus3=`df -h /mnt/osmc/pegasus3 | grep "/mnt/osmc" | awk ' { print $5 } ' | sed -e 's/%//g'`
DFpegasus4=`df -h /mnt/osmc/pegasus4 | grep "/mnt/osmc" | awk ' { print $5 } ' | sed -e 's/%//g'`

#DFtotal=$(($DFpegasus1+$DFpegasus2+$DFpegasus3+$DFpegasus4))
DFtotal=$(((($DFpegasus1+$DFpegasus2+$DFpegasus3+$DFpegasus4)*100)/400))
#DFtotal=$(((($DFpegasus1+$DFpegasus2+$DFpegasus3)*100)/300))

echo "Bond PRL en cours d'initialisation"
echo -e "\n----------Estimation de l'espace disponible-----------"
echo -e "\nLes volumes de streaming pegasus sont remplis à $DFtotal %: "
		
if [ -d "/mnt/osmc/pegasus1/films" ]
	then
		echo -e "\n * pegasus1 ........ $DFpegasus1 %";
	else
		echo -e "\nATTENTION pegasus1 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi

if [ -d "/mnt/osmc/pegasus2/films" ]
	then
		echo -e " * pegasus2 ........ $DFpegasus2 %";
	else
		echo -e "\nATTENTION pegasus2 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi
				
if [ -d "/mnt/osmc/pegasus3/films" ]
	then
		echo -e " * pegasus3 ........ $DFpegasus3 %";
	else
		echo -e "\nATTENTION pegasus3 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi		
		
if [ -d "/mnt/osmc/pegasus4/films" ]
	then
		echo -e " * pegasus4 ........ $DFpegasus4 %";
	else
		echo -e "\nATTENTION pegasus4 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi

		
if [ "$DFpegasus1" -le 80 ]
	then
		echo -e "\nLa copie aura lieu sur pegasus1" && \
		rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/osmc/pegasus1/films/ && \
		rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/osmc/pegasus1/films/ && \
		echo -e "\n\nBond PRL effectué avec succès !" && \
		ssh osmc@192.168.0.21 'xbmc-send --action="UpdateLibrary(video)"' && echo -e "\nMise a jour médiathèque OSMC effectuée" && sleep 1 &&\
			if [ -d "/mnt/pi/galactica1/films" ]
				then
					echo -e "\nBackup sur galactica1 initialisé" && \
					rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/pi/galactica1/films/ && \
					rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/pi/galactica1/films/ && \
					echo -e "\n\nBackup PRL effectué avec succès !" ;
				else
					echo -e "\nATTENTION galactica1 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
			fi	
	else
		if [ "$DFpegasus2" -le 80 ]
			then
				echo -e "\nLa copie aura lieu sur pegasus2" && \
				rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/osmc/pegasus2/films/ && \
				rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/osmc/pegasus2/films/ && \
				echo -e "\n\nBond PRL effectué avec succès !" && \
				ssh osmc@192.168.0.21 'xbmc-send --action="UpdateLibrary(video)"' && echo -e "\nMise a jour médiathèque OSMC effectuée" && sleep 1 &&\
				if [ -d "/mnt/pi/galactica2/films" ]
					then
						echo -e "\nBackup sur galactica2 initialisé" && \
						rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/pi/galactica2/films/ && \
						rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/pi/galactica2/films/ && \
						echo -e "\n\nBackup PRL effectué avec succès !" ;
					else
						echo -e "\nATTENTION galactica2 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
				fi
			else
				if [ "$DFpegasus3" -le 80 ]
					then
						echo -e "\nLa copie aura lieu sur pegasus3" && \
						rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/osmc/pegasus3/films/ && \
						rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/osmc/pegasus3/films/ && \
						echo -e "\n\nBond PRL effectué avec succès !" && \
						ssh osmc@192.168.0.21 'xbmc-send --action="UpdateLibrary(video)"' && echo -e "\nMise a jour médiathèque OSMC effectuée" && sleep 1 &&\
						if [ -d "/mnt/pi/galactica3/films" ]
							then
								echo -e "\nBackup sur galactica3 initialisé" && \
								rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/pi/galactica3/films/ && \
								rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/pi/galactica3/films/ && \
								echo -e "\n\nBackup PRL effectué avec succès !" ;
							else
								echo -e "\nATTENTION galactica3 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
						fi
					else
						if [ "$DFpegasus4" -le 80 ]
							then
								echo -e "\nLa copie aura lieu sur pegasus4" && \
								rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/osmc/pegasus4/films/ && \
								rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/osmc/pegasus4/films/ && \
								echo -e "\n\nBond PRL effectué avec succès !" && \
								ssh osmc@192.168.0.21 'xbmc-send --action="UpdateLibrary(video)"' && echo -e "\nMise a jour médiathèque OSMC effectuée" && sleep 1 &&\
								if [ -d "/mnt/pi/galactica4/films" ]
									then
										echo -e "\nBackup sur galactica4 initialisé" && \
										rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/pi/galactica4/films/ && \
										rsync -rtv --progress /mnt/pi/demetrius/download_center/films/ /mnt/pi/galactica4/films/ && \
										echo -e "\n\nBackup PRL effectué avec succès !" ;
									else
										echo -e "\nATTENTION galactica4 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
								fi
							else
								echo -e "\nIl n'y a plus de place disponible." && echo -e "\nCopie annulée." -&& sleep 1d && exit 0
						fi
				fi
		fi
fi

#demander la suppression des fichiers sur demetrius

echo -e "\n\nVoulez vous supprimer la source de Demetrius ?"
find /mnt/pi/demetrius/download_center/films/ -type f -exec rm -riv {} \; && \
echo -e "\nSans notification contraire, aucun fichier n'a été supprimé du dossier films." && sleep 1 && \
find /mnt/pi/demetrius/download_center/wip_dl/ -type f -exec rm -riv {} \; && \
echo -e "\nSans notification contraire, aucun fichier n'a été supprimé du dossier wip_dl." && sleep 5

exit 0
#fin du script

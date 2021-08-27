#!/bin/bash
# demonter des volumes

# liste de variable disponibles
LISTEHDDpegasus=("/mnt/osmc/pegasus1/films" "/mnt/osmc/pegasus2/films" "/mnt/osmc/pegasus3/films")
LISTEHDDgalactica=("/mnt/pi/galactica1/films" "/mnt/pi/galactica2/films" "/mnt/pi/galactica3/films")

if [ -d "${LISTEHDDgalactica}" ];then
	ls -a /mnt/pi/galactica1/
	ls -a /mnt/pi/galactica2/
	ls -a /mnt/pi/galactica3/
	ls -a /mnt/pi/galactica4/

	if ssh osmc@192.168.1.21 [ -d "${LISTEHDDpegasus}" ];then
			ls -a /mnt/osmc/pegasus1/
			ls -a /mnt/osmc/pegasus2/
			ls -a /mnt/osmc/pegasus3/
#			ls -a /mnt/osmc/pegasus4/

			echo -e "\n\nLes chemins vers les disques distants pegasus existent bien." && echo -e "Que souhaitez vous faire ?";

			# liste de choix disponibles
			LISTE=("[g] démonter les volumes de galactica" "[p] démonter les volumes de pegasus" "[m] monter tous les volumes locaux" "[q] quitter") 
	 
			select i in "${LISTE[@]}" ; do
				case $REPLY in

					1|g)
					echo -e "\nDémontage de galactica initialisé" && sleep 5 && \
					sudo umount /mnt/pi/galactica1 && echo -e "\nDémontage de galactica1 ok" && \
					sudo umount /mnt/pi/galactica2 && echo -e "\nDémontage de galactica2 ok" && \
					sudo umount /mnt/pi/galactica3 && echo -e "\nDémontage de galactica3 ok" && \
					sudo umount /mnt/pi/galactica4 && echo -e "\nDémontage de galactica1 ok" && \
					break
					;;

					2|p)
					echo -e "\nDémontage de pegasus initialisé" && sleep 5 && \
					sudo umount /mnt/osmc/pegasus1 && ssh osmc@192.168.1.21 umount /media/pegasus1 && echo -e "\nDémontage de pegasus1 ok" && \
					sudo umount /mnt/osmc/pegasus2 && ssh osmc@192.168.1.21 umount /media/pegasus2 && echo -e "\nDémontage de galactica2 ok" && \
					sudo umount /mnt/osmc/pegasus3 && ssh osmc@192.168.1.21 umount /media/pegasus3 && echo -e "\nDémontage de galactica3 ok" && \
					sudo umount /mnt/osmc/pegasus4 && ssh osmc@192.168.1.21 umount /media/pegasus4 && echo -e "\nDémontage de galactica1 ok" && \
					break
					;;

					3|m)
					sudo mount -av && sleep 10
					break
					;;
					
					4|q)
					echo -e "\nDémontages annulés" && sleep 5
					break
					;;
				esac
			
	else 	echo -e "\n\nLe chemin vers les disques pegasus n'existe pas.\nDémontage de pegasus annulé" && echo -e "Que souhaitez vous faire ?";
				# liste de choix disponibles
				LISTE=("[g] démonter les volumes de galactica" "[m] monter tous les volumes locaux" "[q] quitter") 
		 
				select i in "${LISTE[@]}" ; do
					case $REPLY in

						1|g)
						echo -e "\nDémontage de galactica initialisé" && sleep 5 && \
						sudo umount /mnt/pi/galactica1 && echo -e "\nDémontage de galactica1 ok" && \
						sudo umount /mnt/pi/galactica2 && echo -e "\nDémontage de galactica2 ok" && \
						sudo umount /mnt/pi/galactica3 && echo -e "\nDémontage de galactica3 ok" && \
						sudo umount /mnt/pi/galactica4 && echo -e "\nDémontage de galactica1 ok" && \
						break
						;;

						2|m)
						sudo mount -av && sleep 10
						break
						;;
						
						3|q)
						echo -e "\nDémontages annulés" && sleep 5
						break
						;;
					esac
						
	fi

	done

else 	echo -e "\n\nLe chemin vers les disques galactica n'existe pas.\nDémontage de galactica annulé" && "Que souhaitez vous faire ?";
		# liste de choix disponibles
			LISTE=("[p] démonter les volumes de pegasus" "[m] monter tous les volumes locaux" "[q] quitter") 
	 
			select i in "${LISTE[@]}" ; do
				case $REPLY in

					1|p)
					echo -e "\nDémontage de pegasus initialisé" && sleep 5 && \
					sudo umount /mnt/osmc/pegasus1 && ssh osmc@192.168.1.21 umount /media/pegasus1 && echo -e "\nDémontage de pegasus1 ok" && \
					sudo umount /mnt/osmc/pegasus2 && ssh osmc@192.168.1.21 umount /media/pegasus2 && echo -e "\nDémontage de galactica2 ok" && \
					sudo umount /mnt/osmc/pegasus3 && ssh osmc@192.168.1.21 umount /media/pegasus3 && echo -e "\nDémontage de galactica3 ok" && \
					sudo umount /mnt/osmc/pegasus4 && ssh osmc@192.168.1.21 umount /media/pegasus4 && echo -e "\nDémontage de galactica1 ok" && \
					break
					;;

					2|m)
					sudo mount -av && sleep 10
					break
					;;
					
					3|q)
					echo -e "\nDémontages annulés" && sleep 5
					break
					;;
				esac

fi

done




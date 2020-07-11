#!/bin/bash
#rsync des films de galactica vers pegasus

#estimations de l'espace disponible

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

#rsync

if [ -d "/mnt/osmc/pegasus1/films" ]
	then
		echo -e "Le chemin vers galactica1 existe, backup PRL initialisé !" && rsync -rtv --progress /mnt/pi/galactica1/ /mnt/osmc/pegasus1/ && rsync -rtv --progress /mnt/pi/galactica1/ /mnt/osmc/pegasus1/ && echo -e "\n\nBackup PRL vers galactica1 effectué avec succès !";
	else 
		echo -e "Le chemin vers galactica1 n'existe pas, backup PRL annulé.\nVérifiez que galactica2 est bien monté." && sleep 1d && exit 0
fi

if [ -d "/mnt/osmc/pegasus2/films" ]
	then
		echo -e "Le chemin vers galactica2 existe, backup PRL initialisé !" && rsync -rtv --progress /mnt/pi/galactica2/ /mnt/osmc/pegasus2/ && rsync -rtv --progress /mnt/pi/galactica2/ /mnt/osmc/pegasus2/ && echo -e "\n\nBackup PRL vers galactica2 effectué avec succès !";
	else 
		echo -e "Le chemin vers galactica2 n'existe pas, backup PRL annulé.\nVérifiez que galactica2 est bien monté." && sleep 1d && exit 0
fi

if [ -d "/mnt/osmc/pegasus3/films" ]
	then
		echo -e "Le chemin vers galactica3 existe, backup PRL initialisé !" && rsync -rtv --progress /mnt/pi/galactica3/ /mnt/osmc/pegasus3/ && rsync -rtv --progress /mnt/pi/galactica3/ /mnt/osmc/pegasus3/ && echo -e "\n\nBackup PRL vers galactica3 effectué avec succès !";
	else 
		echo -e "Le chemin vers galactica3 n'existe pas, backup PRL annulé.\nVérifiez que galactica3 est bien monté." && sleep 1d && exit 0
fi

if [ -d "/mnt/osmc/pegasus4/films" ]
	then
		echo -e "Le chemin vers galactica4 existe, backup PRL initialisé !" && rsync -rtv --progress /mnt/pi/galactica4/ /mnt/osmc/pegasus4/ && rsync -rtv --progress /mnt/pi/galactica4/ /mnt/osmc/pegasus4/ && echo -e "\n\nBackup PRL vers galactica4 effectué avec succès !";
	else 
		echo -e "Le chemin vers galactica4 n'existe pas, backup PRL annulé.\nVérifiez que galactica4 est bien monté." && sleep 1d && exit 0
fi


echo -e "\n\nBackup PRL vers galactica effectué avec succès !"


#estimations de l'espace disponible

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
	
sleep 10

#fin du script
exit 0



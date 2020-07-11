#!/bin/bash
#rsync des films de pegasus vers galactica

#estimations de l'espace disponible

DFgalactica1=`df -h /mnt/pi/galactica1 | grep "/mnt/pi" | awk ' { print $5 } ' | sed -e 's/%//g'`
DFgalactica2=`df -h /mnt/pi/galactica2 | grep "/mnt/pi" | awk ' { print $5 } ' | sed -e 's/%//g'`
DFgalactica3=`df -h /mnt/pi/galactica3 | grep "/mnt/pi" | awk ' { print $5 } ' | sed -e 's/%//g'`
DFgalactica4=`df -h /mnt/pi/galactica4 | grep "/mnt/pi" | awk ' { print $5 } ' | sed -e 's/%//g'`

#DFtotal=$(($DFgalactica1+$DFgalactica2+$DFgalactica3+$DFgalactica4))
DFtotal=$(((($DFgalactica1+$DFgalactica2+$DFgalactica3+$DFgalactica4)*100)/400))
#DFtotal=$(((($DFgalactica1+$DFgalactica2+$DFgalactica3)*100)/300))


echo -e "\n----------Estimation de l'espace disponible-----------"
echo -e "\nLes volumes de backup galactica sont remplis à $DFtotal %: "
		
if [ -d "/mnt/pi/galactica1/films" ]
	then
		echo -e "\n * galactica1 ........ $DFgalactica1 %";
	else
		echo -e "\nATTENTION galactica1 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi		
		
if [ -d "/mnt/pi/galactica2/films" ]
	then
		echo -e " * galactica2 ........ $DFgalactica2 %";
	else
		echo -e "\nATTENTION galactica2 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi
				
if [ -d "/mnt/pi/galactica3/films" ]
	then
		echo -e " * galactica3 ........ $DFgalactica3 %";
	else
		echo -e "\nATTENTION galactica3 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi
		
if [ -d "/mnt/pi/galactica4/films" ]
	then
		echo -e " * galactica4 ........ $DFgalactica4 %";
	else
		echo -e "\nATTENTION galactica4 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi

#rsync

if [ -d "/mnt/pi/demetrius/_technique/" ]
	then
		echo -e "Le chemin vers demetrius existe, backup PRL initialisé !" && \
		rsync -rtv --progress /home/pi/scripts/ /mnt/pi/demetrius/_technique/scripts/ && \
		sudo rm -riv /mnt/pi/demetrius/_technique/backup_settings_vero/backup_osmc/ && \
		rsync -rtv --progress /mnt/osmc/home/_technique/ /mnt/pi/demetrius/_technique/backup_settings_vero/ && \
		echo -e "\n\nBackup PRL vers demetrius effectué avec succès !";
	else 
		echo -e "Le chemin vers demetrius n'existe pas, backup PRL annulé.\nVérifiez que demetrius est bien monté." && sleep 1d && exit 0
fi

if [ -d "/mnt/pi/galactica1/films" ]
	then
		echo -e "Le chemin vers galactica1 existe, backup PRL initialisé !" && rsync -rtv --progress /mnt/osmc/pegasus1/ /mnt/pi/galactica1/ && rsync -rtv --progress /mnt/osmc/pegasus1/ /mnt/pi/galactica1/ && echo -e "\n\nBackup PRL vers galactica1 effectué avec succès !";
	else 
		echo -e "Le chemin vers galactica1 n'existe pas, backup PRL annulé.\nVérifiez que galactica2 est bien monté." && sleep 1d && exit 0
fi

if [ -d "/mnt/pi/galactica2/films" ]
	then
		echo -e "Le chemin vers galactica2 existe, backup PRL initialisé !" && rsync -rtv --progress /mnt/osmc/pegasus2/ /mnt/pi/galactica2/ && rsync -rtv --progress /mnt/osmc/pegasus2/ /mnt/pi/galactica2/ && echo -e "\n\nBackup PRL vers galactica2 effectué avec succès !";
	else 
		echo -e "Le chemin vers galactica2 n'existe pas, backup PRL annulé.\nVérifiez que galactica2 est bien monté." && sleep 1d && exit 0
fi

if [ -d "/mnt/pi/galactica3/films" ]
	then
		echo -e "Le chemin vers galactica3 existe, backup PRL initialisé !" && rsync -rtv --progress /mnt/osmc/pegasus3/ /mnt/pi/galactica3/ && rsync -rtv --progress /mnt/osmc/pegasus3/ /mnt/pi/galactica3/ && echo -e "\n\nBackup PRL vers galactica3 effectué avec succès !";
	else 
		echo -e "Le chemin vers galactica3 n'existe pas, backup PRL annulé.\nVérifiez que galactica3 est bien monté." && sleep 1d && exit 0
fi

if [ -d "/mnt/pi/galactica4/films" ]
	then
		echo -e "Le chemin vers galactica4 existe, backup PRL initialisé !" && rsync -rtv --progress /mnt/osmc/pegasus4/ /mnt/pi/galactica4/ && rsync -rtv --progress /mnt/osmc/pegasus4/ /mnt/pi/galactica4/ && echo -e "\n\nBackup PRL vers galactica4 effectué avec succès !";
	else 
		echo -e "Le chemin vers galactica4 n'existe pas, backup PRL annulé.\nVérifiez que galactica4 est bien monté." && sleep 1d && exit 0
fi


echo -e "\n\nBackup PRL vers galactica effectué avec succès !"


#estimations de l'espace disponible

DFgalactica1=`df -h /mnt/pi/galactica1 | grep "/mnt/pi" | awk ' { print $5 } ' | sed -e 's/%//g'`
DFgalactica2=`df -h /mnt/pi/galactica2 | grep "/mnt/pi" | awk ' { print $5 } ' | sed -e 's/%//g'`
DFgalactica3=`df -h /mnt/pi/galactica3 | grep "/mnt/pi" | awk ' { print $5 } ' | sed -e 's/%//g'`
DFgalactica4=`df -h /mnt/pi/galactica4 | grep "/mnt/pi" | awk ' { print $5 } ' | sed -e 's/%//g'`

#DFtotal=$(($DFgalactica1+$DFgalactica2+$DFgalactica3+$DFgalactica4))
DFtotal=$(((($DFgalactica1+$DFgalactica2+$DFgalactica3+$DFgalactica4)*100)/400))
#DFtotal=$(((($DFgalactica1+$DFgalactica2+$DFgalactica3)*100)/300))


echo -e "\n----------Estimation de l'espace disponible-----------"
echo -e "\nLes volumes de backup galactica sont remplis à $DFtotal %: "
		
if [ -d "/mnt/pi/galactica1/films" ]
	then
		echo -e "\n * galactica1 ........ $DFgalactica1 %";
	else
		echo -e "\nATTENTION galactica1 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi		
		
if [ -d "/mnt/pi/galactica2/films" ]
	then
		echo -e " * galactica2 ........ $DFgalactica2 %";
	else
		echo -e "\nATTENTION galactica2 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi
				
if [ -d "/mnt/pi/galactica3/films" ]
	then
		echo -e " * galactica3 ........ $DFgalactica3 %";
	else
		echo -e "\nATTENTION galactica3 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi
		
if [ -d "/mnt/pi/galactica4/films" ]
	then
		echo -e " * galactica4 ........ $DFgalactica4 %";
	else
		echo -e "\nATTENTION galactica4 n'est pas monté, le script va quitter" && sleep 1d && exit 0;
fi
	
sleep 10

#fin du script
exit 0



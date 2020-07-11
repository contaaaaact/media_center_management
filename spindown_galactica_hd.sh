#!/bin/bash
# spindown des disques branchés

echo -e "Quel disque souhaitez vous mettre en standby ?"

# liste de choix disponibles
LISTE_spindown=("[d] demetrius" "[g] tous les disques de galactica" "[q] quitter et annuler l'opération" "[a] galactica1" "[z] galactica2" "[e] galactica3" "[r] galactica4") 
 
select i in "${LISTE_spindown[@]}" ; do
	case $REPLY in

        	1|d)
		if [ -d "/mnt/pi/demetrius/download_center/" ];then
			echo -e "\n\nLe chemin vers demetrius existe bien." && sudo hdparm -y /dev/disk/by-uuid/0c44d84a-a919-42f5-b5a3-be03433befe7 && echo -e "\ndemetrius est maintenant en standby." && sleep 5
		else echo -e "\nLe chemin vers demetrius n'existe pas, vérifiez que ce disque est branché."
		fi		
		break
		;;

       		2|g)
		if [ -d "/mnt/pi/galactica1/films/" ];then
			echo -e "\n\nLe chemin vers galactica1 existe bien." && sudo hdparm -y /dev/disk/by-uuid/0a54a478-1483-403f-8410-913b4e5265e7 && echo -e "\ngalactica1 est maintenant en standby." && sleep 5
		else echo -e "\nLe chemin vers galactica1 n'existe pas, vérifiez que ce disque est branché."
		fi

		if [ -d "/mnt/pi/galactica2/films/" ];then
			echo -e "\n\nLe chemin vers galactica2 existe bien." && sudo hdparm -y /dev/disk/by-uuid/72ae6c8e-08c0-4637-930a-d85de90d4270 && echo -e "\ngalactica2 est maintenant en standby." && sleep 5
		else echo -e "\nLe chemin vers galactica2 n'existe pas, vérifiez que ce disque est branché."
		fi
		
		if [ -d "/mnt/pi/galactica3/films/" ];then
			echo -e "\n\nLe chemin vers galactica3 existe bien." && sudo hdparm -y /dev/disk/by-uuid/c410750d-8db6-410c-bef8-749e4c4c0ed5 && echo -e "\ngalactica3 est maintenant en standby." && sleep 5
		else echo -e "\nLe chemin vers galactica3 n'existe pas, vérifiez que ce disque est branché."
		fi
		
		if [ -d "/mnt/pi/galactica4/films/" ];then
			echo -e "\n\nLe chemin vers galactica4 existe bien." && sudo hdparm -y /dev/disk/by-uuid/3c7f4007-1fb5-4876-812e-252b3bdd5fa6 && echo -e "\ngalactica4 est maintenant en standby." && sleep 5
		else echo -e "\nLe chemin vers galactica4 n'existe pas, vérifiez que ce disque est branché."
		fi
		break
		;;
		
		3|a)
		if [ -d "/mnt/pi/galactica1/films/" ];then
			echo -e "\n\nLe chemin vers galactica1 existe bien." && sudo hdparm -y /dev/disk/by-uuid/0a54a478-1483-403f-8410-913b4e5265e7 && echo -e "\ngalactica1 est maintenant en standby." && sleep 5
		else echo -e "\nLe chemin vers galactica1 n'existe pas, vérifiez que ce disque est branché."
		fi
		break
		;;
		
		4|z)
		if [ -d "/mnt/pi/galactica2/films/" ];then
			echo -e "\n\nLe chemin vers galactica1 existe bien." && sudo hdparm -y /dev/disk/by-uuid/72ae6c8e-08c0-4637-930a-d85de90d4270 && echo -e "\ngalactica1 est maintenant en standby." && sleep 5
		else echo -e "\nLe chemin vers galactica1 n'existe pas, vérifiez que ce disque est branché."
		fi
		break
		;;
		
		5|e)
		if [ -d "/mnt/pi/galactica3/films/" ];then
			echo -e "\n\nLe chemin vers galactica1 existe bien." && sudo hdparm -y /dev/disk/by-uuid/c410750d-8db6-410c-bef8-749e4c4c0ed5 && echo -e "\ngalactica1 est maintenant en standby." && sleep 5
		else echo -e "\nLe chemin vers galactica1 n'existe pas, vérifiez que ce disque est branché."
		fi
		break
		;;
		
		6|r)
		if [ -d "/mnt/pi/galactica4/films/" ];then
			echo -e "\n\nLe chemin vers galactica1 existe bien." && sudo hdparm -y /dev/disk/by-uuid/3c7f4007-1fb5-4876-812e-252b3bdd5fa6 && echo -e "\ngalactica1 est maintenant en standby." && sleep 5
		else echo -e "\nLe chemin vers galactica1 n'existe pas, vérifiez que ce disque est branché."
		fi
		break
		;;
		
		7|q)
       		echo -e "\nSpindown annulé" && sleep 5
		break
       		;;
  	esac

done

# fin du script

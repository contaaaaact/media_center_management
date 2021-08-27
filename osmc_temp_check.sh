#!/bin/bash
# Purpose: Display the ARM CPU temperature of Vero 4k

cpu=$(</sys/class/thermal/thermal_zone0/temp)
tempcpu=`ssh osmc@192.168.1.21 "echo '$((cpu/1000))'"`

echo "La température CPU de la vero 4K est :"
echo $tempcpu °C


if [ $tempcpu -le 80 ]
	then
        echo "Jusqu'ici tout va bien..." && echo -e "\n Ctrl + C pour quitter" && sleep 600 && /home/pi/scripts/osmc_temp_check.sh && exit 0 ;
        
elif [ $tempcpu -ge 81 ] && [ $tempcpu -le 99 ]
    then
		echo "Oups, ça chauffe..." && echo -e "\n Ctrl + C pour quitter" && sleep 120 && /home/pi/scripts/osmc_temp_check.sh && exit 0 ;
		
elif [ $tempcpu -ge 100 ]
    then
        echo "ATTENTION !!! Il faut éteindre..." && echo -e "\n Ctrl + C pour quitter" && sleep 5 && /home/pi/scripts/osmc_temp_check.sh && exit 0 ;
fi



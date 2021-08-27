#!/bin/bash
#renommer puis deplacer des fichiers

{ # mv des dl de demetrius vers les bons dossiers

if [ -d '/mnt/pi/demetrius/download_center/wip_dl/' ]
	then
		cd /mnt/pi/demetrius/download_center/wip_dl/ChronoDownloads/
		mv * /mnt/pi/demetrius/download_center/wip_dl/
		cd /mnt/pi/demetrius/download_center/wip_dl/
		echo -e "\nVoici la liste des downloads récents :"
		ls -l /mnt/pi/demetrius/download_center/wip_dl/
		
		for filename in *; do
		  case "${filename,,*}" in
			*.torrent) echo -e "\n$filename sera supprimé plus tard" ;;
			*.*) 	echo -e "\nOù voulez vous déplacer ce fichier ? :"
				echo -e "* $filename ?"
				echo -e ""
				
				# liste de choix disponibles
				LISTE_Path=("[f] films" "[a] animation" "[d] animation/STUDIO_DISNEY" "[g] animation/STUDIO_GHIBLI" "[p] animation/STUDIO_PIXAR" "[s] series_tv" "[q] Quitter")  
				 
				select i in "${LISTE_Path[@]}" ; do
						case $REPLY in

								1|f)
								mv -vi "$filename" "/mnt/pi/demetrius/download_center/films"
								break
								;;
								
								2|a)
								mv -vi "$filename" "/mnt/pi/demetrius/download_center/films/animation"
								break
								;;
								
								2|d)
								mv -vi "$filename" "/mnt/pi/demetrius/download_center/films/animation/STUDIO_DISNEY"
								break
								;;
								
								2|g)
								mv -vi "$filename" "/mnt/pi/demetrius/download_center/films/animation/STUDIO_GHIBLI"
								break
								;;
								
								2|p)
								mv -vi "$filename" "/mnt/pi/demetrius/download_center/films/animation/STUDIO_PIXAR"
								break
								;;
								
								2|s)
								echo -e "\nVoici la liste des séries présentes sur le disque :"
								ls -l /mnt/pi/demetrius/download_center/series_tv/
								echo -e "\nA quelle série appartient $filename ?"
								read NomSerie
								if [ -d '/mnt/pi/demetrius/download_center/series_tv/'$NomSerie'/' ];then
									mv -vi "$filename" "/mnt/pi/demetrius/download_center/series_tv/$NomSerie"
								else	mkdir /mnt/pi/demetrius/download_center/series_tv/$NomSerie && mv -vi "$filename" "/mnt/pi/demetrius/download_center/series_tv/$NomSerie"
								fi	
								break
								;;
							
								3|q)
								echo -e "\n$filename restera dans wip_dl/"
								break
								;;
						esac
				done
		  esac
		done
	else
		echo -e "\nwip_dl n'existe pas" && sleep 1d && exit0
fi
}


{ # renommage ou rsync
	
echo -e "\nVoulez vous renommer des fichiers avant la copie vers OSMC ?"
# liste de choix disponibles
LISTE_Rsync=("[y] Yes" "[n] No, rsync films to osmc")
select i in "${LISTE_Rsync[@]}" ; do
					case $REPLY in

							1|y)
							# changer la casse des fichiers en minuscule
							cd /mnt/pi/demetrius/download_center/films/ && rename 'y/A-Z/a-z/' *.* \;
							cd /mnt/pi/demetrius/download_center/films/animation/ && rename 'y/A-Z/a-z/' *.* \;
							cd /mnt/pi/demetrius/download_center/films/animation/STUDIO_DISNEY/ && rename 'y/A-Z/a-z/' *.* \;
							cd /mnt/pi/demetrius/download_center/films/animation/STUDIO_PIXAR/ && rename 'y/A-Z/a-z/' *.* \;
							cd /mnt/pi/demetrius/download_center/films/animation/STUDIO_GHIBLI/ && rename 'y/A-Z/a-z/' *.* \;
							break
							;;

							2|n)
							/home/pi/scripts/rsync_jbod_films_to_osmc.sh && exit 0 
							break
							;;
					esac

done
}

{ # choisir le fichier à renommer
 
if [ -d '/mnt/pi/demetrius/download_center/films/' ];then
	cd /mnt/pi/demetrius/download_center/films/
	echo -e "\nVoici la liste des films récents :"
	find -type f -exec ls -l '{}' \;
	echo -e "\nQuel film voulez-vous renommer ? (choisissez une expression unique par fichier)" && read SelecFilm
			
else	echo -e "\nLes films 4k de Demetrius sont inexistants, veuillez vérifier que Demetrius est bien monté."  && sleep 1d && exit 0

fi
}

{ # vérifier l'existence de la selection SelecFilm	

nbfilms=$(find -name '*'$SelecFilm'*' | wc -l)

if [ "$nbfilms" != "0" ];then
	echo -e "\nIl y a '$nbfilms' fichiers contenant '$SelecFilm' dans le dossier films." && find -type f -name '*'$SelecFilm'*' -exec ls -l '{}' \;
else
	echo -e "\nCette selection n'existe pas, veuillez vérifier son orthographe et la saisir à nouveau :" && read SelecFilm
	nbfilms=$(find -name ''*$SelecFilm*'' | wc -l)
	if [ "$nbfilms" != "0" ];then
		echo -e "\nIl y a '$nbfilms' fichiers contenant '$SelecFilm' dans le dossier films." && find -type f -name '*'$SelecFilm'*' -exec ls -l '{}' \;
	else
		echo -e "\nCette selection n'existe pas, veuillez vérifier son orthographe et la saisir à nouveau :" && read SelecFilm
		nbfilms=$(find -name '*'$SelecFilm'*' | wc -l)
		if [ "$nbfilms" != "0" ];then
			echo -e "\nIl y a '$nbfilms' fichiers contenant '$SelecFilm' dans le dossier films." && find -type f -name '*'$SelecFilm'*' -exec ls -l '{}' \;
		else
			echo -e "\nCette selection n'existe pas, veuillez vérifier son orthographe, le script va redémarrer." && /home/pi/scripts/renamov_jbod_films.sh && exit 0
		fi
	fi
fi
}

{ # selectionner l'extension des fichiers à traiter

echo -e "\nQuelle est l'extension des fichiers à renommer ?"
read Extension

nbfiles=$(find -name '*.'$Extension -a -name '*'$SelecFilm'*' | wc -l)

if [ "$nbfiles" != "0" ];then
	echo -e "\nIl y a '$nbfiles' fichiers contenant cette extension dans le dossier films." && find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec ls -l '{}' \;
else
	echo -e "\nCette extension n'est pas présente, veuillez vérifier son orthographe et la saisir à nouveau :" && read Extension
	nbfiles=$(find -name '*.'$Extension -a -name '*'$SelecFilm'*' | wc -l)
	if [ "$nbfiles" != "0" ];then
		echo -e "\nIl y a '$nbfiles' fichiers contenant cette extension dans le dossier films." && find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec ls -l '{}' \;
	else
		echo -e "\nCette extension n'est pas présente, veuillez vérifier son orthographe et la saisir à nouveau :" && read Extension
		nbfiles=$(find -name '*.'$Extension -a -name '*'$SelecFilm'*' | wc -l)
		if [ "$nbfiles" != "0" ];then
			echo -e "\nIl y a '$nbfiles' fichiers contenant cette extension dans le dossier films." && find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec ls -l '{}' \;
		else
			echo -e "\nCette extension n'est pas présente, veuillez vérifier son orthographe, le script va redémarrer." && /home/pi/scripts/renamov_jbod_films.sh && exit 0
		fi
	fi
fi
}

{ # choisir le titre du film
echo -e "\nQuel est le titre exact du film ?"
read Titre
}

{ # choisir l'année de production du film
echo -e "\nQuelle est l'année de production du film ?"
read Annee
}

{ # choisir resolution $Res
echo -e "\nQuelle est la résolution du fichier ?"

# liste de choix disponibles
LISTE_Res=("[p] SD 480p" "[s] SD 576p" "[r] HD ready 720p" "[h] HD 1080p" "[u] UHD 2160p" "[c] Custom Resolution (précéder l'option d'un _)" "[q] Quitter") 
 
select i in "${LISTE_Res[@]}" ; do
		case $REPLY in

				1|p)
				Res=_480p
				break
				;;

				2|s)
				Res=_576p
				break
				;;
				
				3|r)
				Res=_720p
				break
				;;
				
				4|h)
				Res=_1080p
				break
				;;
				
				5|u)
				Res=_2160p
				break
				;;
				
				6|c)
				echo -e "\nQuelle résolution voulez vous spécifier ? (précéder l'option d'un _)" && read Res
				break
				;;
				
				7|q)
				echo -e "\nAjout de Resolution annulé"
				break
				;;
		esac

done
}

{ # choisir la source du fichier $Source
echo -e "\nQuelle est la source du fichier ?"

# liste de choix disponibles
LISTE_Source=("[d] DVD" "[b] Bluray" "[w] Web" "[c] Custom Source (précéder l'option d'un _)" "[q] Quitter") 
 
select i in "${LISTE_Source[@]}" ; do
		case $REPLY in

				1|d)
				Source=_dvd
				break
				;;

				2|b)
				Source=_bluray
				break
				;;
			
				3|w)
				Source=_web
				break
				;;
			
				4|c)
				echo -e "\nQuelle source voulez vous spécifier ? (précéder l'option d'un _)" && read Source
				break
				;;
			
				5|q)
				echo -e "\nAjout de Source annulé"
				break
				;;
		esac

done
}

{ # choisir la qualité du fichier $Quality
echo -e "\nQuelle est la qualité du fichier ?"

# liste de choix disponibles
LISTE_Quality=("[f] Full" "[l] Light" "[d] Web DL" "[r] Web Rip" "[c] Custom Quality (précéder l'option d'un _)" "[q] Quitter") 
 
select i in "${LISTE_Quality[@]}" ; do
		case $REPLY in

				1|f)
				Quality=_full
				break
				;;

				2|l)
				Quality=_light
				break
				;;
				
				3|d)
				Quality=_dl
				break
				;;
				
				4|r)
				Quality=_rip
				break
				;;
				
				5|c)
				echo -e "\nQuelle qualité voulez vous spécifier ? (précéder l'option d'un _)" && read Quality
				break
				;;
				
				6|q)
				echo -e "\nAjout de Qualité annulé"
				break
				;;
		esac

done
}

{ # choisir la plage dynamique du fichier $Dynrange
echo -e "\nQuelle est la plage dynamique du fichiers ?"

# liste de choix disponibles
LISTE_Dynrange=("[s] SDR" "[h] HDR" "[q] Quitter") 
 
select i in "${LISTE_Dynrange[@]}" ; do
		case $REPLY in

				1|s)
				Dynrange=_sdr
				break
				;;

				2|h)
				Dynrange=_hdr
				break
				;;
			
				3|q)
				echo -e "\nAjout de Plage Dynamique annulé"
				break
				;;

		esac

done
}

{ # choisir les options du fichier $Opt
echo -e "\nQuelles sont les options pour qualifier votre fichier ?"

# liste de choix disponibles
LISTE_Opt=("[a] son Dolby Atmos" "[d] son DTS-X" "[c] Custom (précéder l'option d'un _)" "[q] Quitter") 
 
select i in "${LISTE_Opt[@]}" ; do
		case $REPLY in

				1|a)
				Opt=_atmos
				break
				;;

				2|d)
				Opt=_dtsx
				break
				;;
			
				3|c)
				echo -e "\nQuelle option voulez vous spécifier ? (précéder l'option d'un _)" && read Opt
				break
				;;
			
				4|q)
				echo -e "\nAjout d'option annulé"
				break
				;;
		esac

done
}

{ # confirmer le renommage
echo -e "\nLe fichiers sera renommé suivant cette nomenclature :"
echo "'$Titre'_'$Annee''$Res''$Source''$Quality''$Dynrange''$Opt'.'$Extension'"
echo -e "\nVoulez vous lancer le renommage ?"
}

# liste de choix disponibles
LISTE_Rename=("[y] Yes" "[n] No") 
 
select i in "${LISTE_Rename[@]}" ; do
		case $REPLY in

				1|y)
				echo -e "\nRenommage et classement en cours..."
        	
				{  # renommage film depth 1
				find -maxdepth 1 -name "*$SelecFilm*" -a -name "*$Extension*" -exec mv '{}' ''$Titre'_'$Annee''$Res''$Source''$Quality''$Dynrange''$Opt'.'$Extension'' \;	
				}

				{  # renommage film animation
				cd animation/
				find -maxdepth 1 -name "*$SelecFilm*" -a -name "*$Extension*" -exec mv '{}' ''$Titre'_'$Annee''$Res''$Source''$Quality''$Dynrange''$Opt'.'$Extension'' \;
				cd /mnt/pi/demetrius/download_center/films/
				}

				{  # renommage film animation STUDIO_DISNEY
				cd animation/STUDIO_DISNEY/
				find -maxdepth 1 -name "*$SelecFilm*" -a -name "*$Extension*" -exec mv '{}' ''$Titre'_'$Annee''$Res''$Source''$Quality''$Dynrange''$Opt'.'$Extension'' \;
				cd /mnt/pi/demetrius/download_center/films/	
				}

				{  # renommage film animation STUDIO_PIXAR
				cd animation/STUDIO_PIXAR/	
				find -maxdepth 1 -name "*$SelecFilm*" -a -name "*$Extension*" -exec mv '{}' ''$Titre'_'$Annee''$Res''$Source''$Quality''$Dynrange''$Opt'.'$Extension'' \;
				cd /mnt/pi/demetrius/download_center/films/	
				}

				{  # renommage film animation STUDIO_GHIBLI
				cd animation/STUDIO_GHIBLI/
				find -maxdepth 1 -name "*$SelecFilm*" -a -name "*$Extension*" -exec mv '{}' ''$Titre'_'$Annee''$Res''$Source''$Quality''$Dynrange''$Opt'.'$Extension'' \;
				cd /mnt/pi/demetrius/download_center/films/	
				}
				
			
				echo -e "\nLe renommage est terminé."
				find -type f -exec ls -l '{}' \;
        		echo -e "\nY a t il d'autres fichiers à renommer ?"
        		LISTE_Rename=("[y] Yes" "[n] No" "[s] Sous-titres français" "[a] Autre extension" "[r] Relancer le script")
        		echo -e "1) [n] No      2) [s] Sous-titres français"
        		echo -e "3) [a] Autre extension      4) [r] Relancer le script"
				;;
				
				2|n)
				echo -e "\nRenommage et classement annulés"
				break
				;;
				
				3|s)
				Extension=srt
				{ # modifier la selection film

				nbfilms=$(find -name '*.'$Extension -a -name '*'$SelecFilm'*' | wc -l)

				if [ "$nbfilms" != "0" ];then
					echo -e "\nIl y a '$nbfilms' fichiers contenant '$SelecFilm' dans le dossier films." && find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec ls -l '{}' \;
				else
					echo -e "\nLa selection '$SelecFilm' n'existe pas, veuillez vérifier son orthographe et la saisir à nouveau :" && read SelecFilm
					nbfilms=$(find -name '*.'$Extension -a -name '*'$SelecFilm'*' | wc -l)
					if [ "$nbfilms" != "0" ];then
						echo -e "\nIl y a '$nbfilms' fichiers contenant '$SelecFilm' dans le dossier films." && find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec ls -l '{}' \;
					else
						echo -e "\nLa selection '$SelecFilm' n'existe pas, veuillez vérifier son orthographe et la saisir à nouveau :" && read SelecFilm
						nbfilms=$(find -name '*.'$Extension -a -name '*'$SelecFilm'*' | wc -l)
						if [ "$nbfilms" != "0" ];then
							echo -e "\nIl y a '$nbfilms' fichiers contenant '$SelecFilm' dans le dossier films." && find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec ls -l '{}' \;
						else
							echo -e "\nLa selection '$SelecFilm' n'existe pas, veuillez vérifier son orthographe, le script va redémarrer." && /home/pi/scripts/renamov_jbod_films.sh && exit 0
						fi
					fi
				fi
				}

				
				{ # Formatage nomenclature de base
				echo -e "\nL'extension des sous titres Français doit être .fr.srt"
				echo -e "Les fihiers à renommer sont ils conformes à cette nomenclature ?"

				# liste de choix disponibles
				LISTE_Nomenclature=("[y] Yes" "[n] No") 
						 
				select i in "${LISTE_Nomenclature[@]}" ; do
					case $REPLY in

							1|y)
							break
							;;

							2|n)
							echo -e "\nQuelle suite de caractères voulez vous renommer ?"
							read CaractSuite1
							echo -e "\nPar quelle suite de caractères voulez vous la remplacer ?"
							read CaractSuite2
							find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec  rename 's/'$CaractSuite1'/'$CaractSuite2'/' '{}' \;
							find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec ls -l '{}' \;
							echo -e "\nLa nomenclature est elle maintenant correcte ?" && echo "1) [y]      2) [n]"
							;;

					esac

				done
				}
							
				Extension=fr.srt
				echo -e "\nVoulez vous vraiment lancer le renommage des fichiers de sous-titres ?"
				echo -e "1) [y] Yes      2) [n] No"
				;;
				
				4|a)
				echo -e "\nQuelle est l'extension des fichiers à renommer ?"	
				read Extension			
				{ # modifier la selection film
				CheminFilms=/mnt/pi/demetrius/download_center/films/

				nbfilms=$(find -name '*.'$Extension -a -name '*'$SelecFilm'*' | wc -l)

				if [ "$nbfilms" != "0" ];then
					echo -e "\nIl y a '$nbfilms' fichiers contenant '$SelecFilm' dans le dossier films." && find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec ls -l '{}' \;
				else
					echo -e "\nLa selection '$SelecFilm' n'existe pas, veuillez vérifier son orthographe et la saisir à nouveau :" && read SelecFilm
					nbfilms=$(find -name '*.'$Extension -a -name '*'$SelecFilm'*' | wc -l)
					if [ "$nbfilms" != "0" ];then
						echo -e "\nIl y a '$nbfilms' fichiers contenant '$SelecFilm' dans le dossier films." && find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec ls -l '{}' \;
					else
						echo -e "\nLa selection '$SelecFilm' n'existe pas, veuillez vérifier son orthographe et la saisir à nouveau :" && read SelecFilm
						nbfilms=$(find -name '*.'$Extension -a -name '*'$SelecFilm'*' | wc -l)
						if [ "$nbfilms" != "0" ];then
							echo -e "\nIl y a '$nbfilms' fichiers contenant '$SelecFilm' dans le dossier films." && find -name '*.'$Extension -a -name '*'$SelecFilm'*' -exec ls -l '{}' \;
						else
							echo -e "\nLa selection '$SelecFilm' n'existe pas, veuillez vérifier son orthographe, le script va redémarrer." && /home/pi/scripts/renamov_jbod_films.sh && exit 0
						fi
					fi
				fi
				}
				
				echo -e "\nVoulez vous vraiment lancer le renommage des fichiers ?"
				echo -e "1) [y] Yes      2) [n] No"
				;;
				
				5|r)
				/home/pi/scripts/renamov_jbod_films.sh && exit 0
				;;
							
		esac

done

# redirection vers rsync series

echo -e "\nVoulez vous lancer le bond PRL vers OSMC ?"

# liste de choix disponibles
LISTE_Rsync2=("[y] Yes, rsync films to osmc" "[n] No")
select i in "${LISTE_Rsync2[@]}" ; do
					case $REPLY in

							1|y)
							/home/pi/scripts/rsync_jbod_films_to_osmc.sh && exit 0 
							break
							;;

							2|n)
							echo -e "\nBond PRL annulé." && sleep 5
							break
							;;

					esac

done

exit 0





#!/bin/bash
if [ $2 -gt 0 ] && [ $2 -lt 100 ]
then
	ls $1 > sousRepertoires.txt
	repertoire=$1
	seuil=$2

	#on va enregistrer les fichiers des sous-repertoires dans une liste
	for sousRepertoires in `cat sousRepertoires.txt`
	do
		for fichier in `ls $repertoire/$sousRepertoires`
		do
			echo $repertoire/$sousRepertoires/$fichier >> nomDesFichiers2.txt
		done
	done
	sort -u nomDesFichiers2.txt > nomDesFichiers.txt
	rm -f nomDesFichiers2.txt	

	lignes=0
	for fichier in `cat nomDesFichiers.txt`
	do
		tab[$lignes]=$fichier
		let "lignes++"
	done

	#on compare maintenant les element dans cette liste
	k=0
	let "longeur=${#tab[@]}-1"
	for ((i = 0; i < longeur; i++))
	do
		let "k=$i+1"
	  for ((j = k; j < ${#tab[@]}; j++))
	  do
	  	./lignesEgales.bash ${tab[i]} ${tab[j]} $seuil
	  	./variablesEgales.bash ${tab[i]} ${tab[j]} $seuil
	  	./fonctionsEgales.bash ${tab[i]} ${tab[j]} $seuil
	  done
	done

	#supprimer les fichiers inutils apres avoir utilisé
	rm -f sousRepertoires.txt
	rm -f nomDesFichiers.txt
else #si le seuil nest pas dans 0<seuil<100
	echo "Vérifiez les arguments SVP"
	echo "[./fichierBash]  [nomDossier] [0<seuil<100]"
fi
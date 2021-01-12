#!/bin/bash
##on enregistre les fichiers dans les brouillons##
cat $1 > file1.txt
cat $2 > file2.txt


for fichier in file1.txt file2.txt
do
	##remplace ; par \n 
	sed -i 's/[;]/\n/g' $fichier

	##supprime tous les lignes qui contient un seul } ou un seul {
	sed -i '/^\s*[{]\s*$/d' file1.txt
	sed -i '/^\s*[}]\s*$/d' file1.txt

	#supprime tous les lignes vides
	sed -i '/^[ ]*$/d' file1.txt

	#supprime tous les comments //
	sed -i '/^\/\/.*$/d' file1.txt

	#supprime tous les comment dans /*......*/
	sed -i '/^\/[*].*/,/^.*[*]\/$/d' file1.txt
done

awk -v file1=$1 -v file2=$2 -v seuil=$3 'BEGIN{nbLigneEgal=0; nbLigneFile1=0}
	{

		if(FNR==NR)
		{
			line[$0]++;
			nbLigneFile1 = FNR;
			next
		}
		if(($0 in line) && length($0)>0)
		{	
			nbLigneEgal++;
		}
	}END{
			if(((nbLigneEgal/nbLigneFile1)*100 + 3) >= seuil)
			{
				printf("%s est similare AVEC %s ==> Lignes égales: %d%%\n", file2, file1, (nbLigneEgal/nbLigneFile1)*100 + 3);
			}
			if(((nbLigneEgal/FNR)*100 + 3) >= seuil && FNR > nbLigneFile1)
			{
				printf("%s est similare AVEC %s ==> Lignes égales: %d%%\n", file1, file2, (nbLigneEgal/nbLigneFile1)*100 + 3);
				printf("#######\n");
			}
		}' file1.txt file2.txt

#supprimer les brouillons après avoir reçu le resultat
rm -f file1.txt
rm -f file2.txt
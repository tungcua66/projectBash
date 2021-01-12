#!/bin/bash
cat $1 > file1.txt
cat $2 > file2.txt

for fichier in file1.txt file2.txt
do
  #remplace ; par \n
  sed -i 's/[;]/\n/g' $fichier

  #recuperer des variables de 2 fichiers dans 2  variables_fichier.txt
  awk 'BEGIN{k=0}
  {
    if( $0 ~ /^[ ]*(int|char|float)[ ]+[a-zA-Z0-9$_]+[ ]*[=].*$/ || $0 ~ /^[ ]*(int|char|float)[ ]+[a-zA-Z0-9$_]+$/)
      {
        for(i=1;i<NF;i++)
        {
          if($i ~ /int/ || $i ~ /float/ || $i ~ /char/)
          {
            k=++i;
            printf("%s\n", $k);
          }
        }
      }
  }' $fichier > variables_$fichier

  #remplace tous les , par \n
  sed -i 's/[,]/\n/g' variables_$fichier

  #supprimmer tous les lignes vides
  sed -i '/^[ ]*$/d' variables_$fichier

  #traiter les variables_fichiers
  sort -u variables_$fichier > res.txt
  cat res.txt > variables_$fichier
  rm -r res.txt
done

#comparer les variables dans les 2 fichiers
awk -v file1=$1 -v file2=$2 -v seuil=$3 'BEGIN{nbLigneEgal=0; nbLigneFile1=0}
  {
    if(FNR==NR)
    {
      line[$0]++;
      nbLigneFile1=FNR;
      next
    }
    if($0 in line)
    {
      nbLigneEgal++;
    }
  }END{
        if(((nbLigneEgal/nbLigneFile1)*100) >= seuil)
        {
          printf("%s est similare AVEC %s ==> Variables égales: %d%%\n", file2, file1, (nbLigneEgal/nbLigneFile1)*100);
          printf("#######\n");
        }
        if(((nbLigneEgal/FNR)*100) >= seuil && FNR > nbLigneFile1)
        {
          printf("%s est similare AVEC %s ==> Variables égales: %d%%\n", file1, file2, (nbLigneEgal/nbLigneFile1)*100);
          printf("#######\n");
        }
      }' variables_file1.txt variables_file2.txt

#supprime tous les fichiers brouillon apres avoir reçu les resultat
rm -r file1.txt
rm -r file2.txt
rm -r variables_file1.txt
rm -r variables_file2.txt
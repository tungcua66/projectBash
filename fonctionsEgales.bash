#!/bin/bash
cat $1 > file1.txt
cat $2 > file2.txt

for fichier in file1.txt file2.txt
do
  #remplace ; par \n
  sed -i 's/[;]/\n/g' $fichier

  #recuperer des fonctions de 2 fichiers dans les fonction_fichier.txt
  awk 'BEGIN{k=0}
  {
    if( $0 ~ /^[ ]*(int|void)[ ]+[a-zA-Z0-9_]+[(]+.*[)]+[{]?$/ )
      {
        for(i=1;i<NF;i++)
        {
          if($i ~ /int/ || $i ~ /void/)
          {
            k=++i;
            indice = index($k, "(");
            printf("%s\n", substr($k, 1, indice - 1));
          }
        }
      }
  }' $fichier > fonctions_$fichier

  #supprimmer tous les lignes vides
  sed -i '/^[ ]*$/d' fonctions_$fichier

  #traiter les fonctions_fichiers
  sort -u fonctions_$fichier > res.txt
  cat res.txt > fonctions_$fichier
  rm -r res.txt
done

#comparer les fonctions dans les 2 fichiers
awk -v file1=$1 -v file2=$2  -v seuil=$3 'BEGIN{nbLigneEgal=0; nbLigneFile1=0; facteur=0}
  {
    if(FNR==NR)
    {
      line[$0]++;
      nbLigneFile1 = FNR;
      next
    }
    if($0 in line)
    {
      nbLigneEgal++;
    }
  }END{
        if(((nbLigneEgal/nbLigneFile1)*100) >= seuil)
        {
          printf("%s est similare AVEC %s ==> Fonctions égales: %d%%\n", file2, file1, (nbLigneEgal/nbLigneFile1)*100);
          printf("#######\n");
        }
        if(((nbLigneEgal/FNR)*100) >= seuil && FNR > nbLigneFile1)
        {
          printf("%s est similare AVEC %s ==> Fonctions égales: %d%%\n", file1, file2, (nbLigneEgal/nbLigneFile1)*100);
          printf("#######\n");
        }
      }' fonctions_file1.txt fonctions_file2.txt

#supprime tous les fichiers brouillon apres avoir reçu les resultat
rm -r file1.txt
rm -r file2.txt
rm -r fonctions_file1.txt
rm -r fonctions_file2.txt
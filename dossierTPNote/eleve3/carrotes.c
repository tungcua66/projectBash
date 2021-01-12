#include <stdlib.h>
#include <stdio.h>
#include <time.h>

/*Par rapport au fichier de base avec un seille de 60% :
lignes égales : non
fonctions égales : oui
variables égales : non
*/

void afficher(int tab[], int taille){
  printf("(");
  for(int c = 0; c < taille; c++){
    printf("%d, ",tab[c]);
  }
  printf(")\n");
}


int main(int argc, char** argv){
  if(argc != 2){
    printf("<usage : nombre de couleurs des carottes>");
    return 2;
  }

  int tabCarottes[8] = {0,0,0,0,0,0,0,0};
  int NombreCarottes = 8;
  srand(time(0));
  int nombreCouleur = atoi(argv[1]);
  int d;


  for(d = 0; d < NombreCarottes; d++){
    tabCarottes[i] = rand()%nombreCouleur;
  }

  printf("Les carottes sont de couleurs : \n");
  afficher(tabCarottes, NombreCarottes);

}

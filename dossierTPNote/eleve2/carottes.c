#include <stdlib.h>
#include <stdio.h>
#include <time.h>

/*Par rapport au fichier de base avec un seille de 60% :
lignes égales : oui
fonctions égales : oui
variables égales : oui
*/

void afficher(int T[], int n){
  printf("[");
  int i;
  for(i = 0; i < n-1; i++){
    printf("%d, ",T[i]);
  }
  printf("%d]\n",T[i]);
}


int main(int argc, char** argv){
  if(argc > 2 || argc < 2){
    printf("C'est pas bien il faut mettre le nombre de couleurs");
    return 1;
  }

  int carottes[8];
  int i = 0;
  for(i =  0; i < 8; i++)
    carottes[i] = 0;
  srand(time(0));
  int nbCoul = atoi(argv[1]);

  i = 0;
  while(i < 8){
    carottes[i] = (int)(rand() / (double)RAND_MAX * nbCoul);
    i++;
  }

  printf("Voilà les couleurs des carottes \n");
  afficher(carottes, 8);

}

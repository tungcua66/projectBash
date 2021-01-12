#include <stdlib.h>
#include <stdio.h>
#include <time.h>
//Fichier de base
void afficher(int T[], int n){
  printf("[");
  int i;
  for(i = 0; i < n-1; i++){
    printf("%d, ",T[i]);
  }
  printf("%d]\n",T[i]);
}


int main(int argc, char** argv){
  if(argc != 2){
    printf("<usage : nb de couleurs des carottes>");
    return 1;
  }

  int carottes[8] = {0,0,0,0,0,0,0,0};
  int nbCar = 8;
  srand(time(0));
  int nbCoul = atoi(argv[1]);
  int i;


  for(i = 0; i < nbCar; i++){
    carottes[i] = rand()%nbCoul;
  }

  printf("Les carottes sont de couleurs : \n");
  afficher(carottes, nbCar);

}

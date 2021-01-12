#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>
/*Par rapport au fichier de base avec un seille de 60% :
lignes égales : non
fonctions égales : non
variables égales : oui
*/


int main(int argc, char** argv){
  if(argc != 3){
    printf("<usage : nombre de trous (<5), profondeur>");
    return 1;
  }

  
  //Création des carottes glacière
  pid_t carottes[5];
  int nbCar = atoi(argv[1]);
  int prof = atoi(argv[2]);

  int i = 0;
  for(i = 0; i < nbCar; i++){
    carottes[i] = fork();
    if(carottes[i] != 0 && i == 0){
      printf("Création des carottes glacières\n");
    }
    if(carottes[i] == 0){
      srand(time(0)*getpid());
      printf("Carotte %d : profondeur %d\n", i, rand()%prof);
      return 0;
      }
    }

  for(i = 0; i < nbCar; i++){
    wait(NULL);
  }

  printf("Fin des forages.  \n");
}

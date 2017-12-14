#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <time.h>

#define VECTOR_GLOBAL
//#define VECTOR_DYNAMIC

#ifdef VECTOR_GLOBAL
#define MAX 100
  int v[MAX], matriz[MAX][MAX];
#endif

int main(int argc, char const *argv[])
{
    // comprobamos que los argumentos son correctos
    if (argc < 2) {
        printf("Falta el tamaño de la matriz\n");
        exit(-1);
    }

    int N = atoi(argv[1]);
    int i, j;

    #ifdef VECTOR_GLOBAL
    if (N>MAX) N=MAX;
    #endif

    #ifdef VECTOR_DYNAMIC
    int *v, **matriz;
    v = (int *) malloc(N*sizeof(double));// malloc necesita el tamaño en bytes
    matriz = (int **) malloc(N*sizeof(int *));
    for(i=0; i<N; i++)
      matriz[i] = (int *) malloc(N*sizeof(int));

    if ( (v==NULL) || (matriz==NULL) ){
      printf("Error en la reserva de espacio para los vectores\n");
      exit(-2);
    }
    #endif

    // inicializamos la matriz y el vector
    #pragma omp parallel for private(i,j)
      for (i = 0; i<N; i++) {
        for (j = 0; j<N; j++)
            matriz[i][j] = 5;
        v[i] = 3;
      }

    int vector_resultado[N], k = 0, suma=0;
    double inicio, fin, tiempo;
    inicio = omp_get_wtime();

    #pragma omp parallel for private(i,k,suma)
      for (i=0; i<N;i++) {
          for (k=0; k<N; k++)
              suma+=matriz[k][i];

          vector_resultado[i] = suma * v[i];
          suma = 0;
      }

    fin = omp_get_wtime();
    tiempo = fin -inicio;

    if (N < 11) {
        printf("Tiempo: %11.9f\n", tiempo);
        for (i=0; i<N; i++)
            printf("v[%d] = %d\n", i, vector_resultado[i]);
    }

    else
        printf("Tiempo: %11.9f \t v[0] = %d \t v[%d] = %d \n", tiempo, vector_resultado[0],
             N-1, vector_resultado[N-1]);

    #ifdef VECTOR_DYNAMIC
      free(v); // libera el espacio reservado para v
      free(matriz); // libera el espacio reservado para matriz
    #endif

    return 0;
}

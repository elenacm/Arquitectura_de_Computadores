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
    for (i = 0; i<N; i++) {
        for (j = 0; j<N; j++)
            matriz[i][j] = 5;
        v[i] = 3;
    }

    struct timespec cgt1,cgt2; double ncgt; //para tiempo de ejecución
    int vector_resultado[N], k = 0, suma=0;

    clock_gettime(CLOCK_REALTIME, &cgt1);

    // Calculamos el producto
    for (i=0; i<N;i++) {
        // calculamos la suma de la columna de la matriz:
        for (k=0; k<N; k++)
            suma+=matriz[k][i];

        // y ahora multiplicamos la suma por el vector:
        vector_resultado[i] = suma * v[i];
        suma = 0;
    }

    clock_gettime(CLOCK_REALTIME, &cgt2);

    ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec)+( double) ((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));

    if (N < 11) {
        printf("Tiempo: %11.9f\n", ncgt);
        for (i=0; i<N; i++)
            printf("v[%d] = %d\n", i, vector_resultado[i]);
    }

    else
        printf("Tiempo: %11.9f \t v[0] = %d \t v[%d] = %d \n", ncgt, vector_resultado[0],
             N-1, vector_resultado[N-1]);

    #ifdef VECTOR_DYNAMIC
      free(v); // libera el espacio reservado para v
      free(matriz); // libera el espacio reservado para matriz
    #endif

    return 0;
}

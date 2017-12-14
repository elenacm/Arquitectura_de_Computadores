#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
  #include <omp.h>
#else
  #define omp_get_thread_num() 0
#endif

int main(int argc, char const *argv[]){

  omp_sched_t kind;
  int modifier;
  omp_get_schedule(&kind,&modifier);
    // comprobamos que los argumentos son correctos
    if (argc < 2) {
        printf("Falta el tamaño de la matriz\n");
        exit(-1);
    }

    int N = atoi(argv[1]);
    int i, j;

    int *v, **matriz;
    v = (int *) malloc(N*sizeof(double));// malloc necesita el tamaño en bytes
    matriz = (int **) malloc(N*sizeof(int *));
    for(i=0; i<N; i++)
      matriz[i] = (int *) malloc(N*sizeof(int));

    if ( (v==NULL) || (matriz==NULL) ){
      printf("Error en la reserva de espacio para los vectores\n");
      exit(-2);
    }

    // inicializamos la matriz y el vector
    #pragma omp parallel for schedule(runtime) private(j)
      for (i = 0; i<N; i++) {
          for (j = 0; j<i+1; j++)
              matriz[i][j] = 1;
            for(int l=N; l>i; l--)
              matriz[i][l]=0;
      }

    printf("Matriz: \n");
    for(int l=0; l<N; l++){
      for(int m=0; m<N; m++)
        printf("%d ", matriz[l][m]);
        printf("\n");
    }

    #pragma omp parallel for schedule(runtime)
      for (i = 0; i<N; i++) {
          v[i] = i+1;
      }

    printf("vector: \n");
    for(int l=0; l<N; l++){
      printf("%d \n", v[l]);
    }

    double t1=omp_get_wtime();
    int vector_resultado[N], k = 0, suma=0;

    #pragma omp parallel for schedule(runtime) private(k)
      // Calculamos el producto
      for (i=0; i<N;i++) {
          vector_resultado[i]=0;
          for (k=0; k<N; k++)
              vector_resultado[i]+=matriz[i][k]*v[k];
      }

    double t2=omp_get_wtime();
    t2 = t2-t1;


    if (N < 11) {
        printf("Tiempo: %8.7f\n", t2);
        for (i=0; i<N; i++)
            printf("v[%d] = %d\n", i, vector_resultado[i]);
    }

    else
        printf("Tiempo: %8.7f \t v[0] = %d \t v[%d] = %d \n", t2, vector_resultado[0],
             N-1, vector_resultado[N-1]);

      free(v); // libera el espacio reservado para v
      free(matriz); // libera el espacio reservado para matriz

    return 0;
}

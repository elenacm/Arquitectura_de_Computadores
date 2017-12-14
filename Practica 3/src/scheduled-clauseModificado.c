#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
  #include <omp.h>
#else
  #define omp_get_thread_num() 0
#endif

int main(int argc, char **argv) {
  int i, n=200,chunk,a[n],suma=0;
  omp_sched_t kind;
  int modifier;

  if(argc < 3) {
    fprintf(stderr,"\nFalta iteraciones o chunk \n");
    exit(-1);
  }
  n = atoi(argv[1]); if (n>200) n=200; chunk = atoi(argv[2]);

  for (i=0; i<n; i++) a[i]=i;

  #pragma omp parallel for firstprivate(suma) lastprivate(suma) schedule(dynamic,chunk)
  for (i=0; i<n; i++)
  {
    suma = suma + a[i];
    printf(" thread %d suma a[%d]=%d suma=%d \n", omp_get_thread_num(),i,a[i],suma);
    if(i == n-1){
      printf("Thread %d \n", i);
      printf("Dentro del parallel -> dyn-var = %d \n", omp_get_dynamic());
      printf("Dentro del parallel -> nthreads-var = %d \n", omp_get_max_threads());
      printf("Dentro del parallel -> thread-limit-var = %d \n", omp_get_thread_limit());
      omp_get_schedule(&kind,&modifier);
      printf("Dentro del parallel -> run-sched-var(kind, modifier)= %d, %d \n", kind, modifier);
    }
  }

  printf("Fuera de 'parallel for' suma=%d\n",suma);
  printf("Fuera del parallel -> dyn-var = %d \n", omp_get_dynamic());
  printf("Fuera del parallel -> nthreads-var = %d \n", omp_get_max_threads());
  printf("Fuera del parallel -> thread-limit-var = %d \n", omp_get_thread_limit());
  omp_get_schedule(&kind,&modifier);
  printf("Fuera del parallel -> run-sched-var(kind, modifier)= %d, %d \n", kind, modifier);
}

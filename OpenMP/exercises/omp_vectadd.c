#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[])
{

  // Initialize arrays 
  int size=1000000;
  int *a = (int *)malloc(size*sizeof(int));
  int *b = (int *)malloc(size*sizeof(int));
  int *c = (int *)malloc(size*sizeof(int));

  // Time the parallel for-loop
  double start,end;
  start = omp_get_wtime();

  // Fill with a & b with random numbers between 0 and 100
  int i;
  for(i=0; i<size; i++)
  {
    a[i]=rand() % 100;
    b[i]=rand() % 100;
    c[i]=a[i]+b[i];
  }

  end = omp_get_wtime();

  free(a);
  free(b);
  free(c);

  printf("Summed vectors a and b in %g seconds\n", end-start);

}

#include <omp.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[])
{

  // Initialize variables
  int i;
  double pi = 0;
  int niter = 100000000;

  // Timing
  double start,end;
  start=omp_get_wtime();

  // Calculate part of Leibnitz sum.
  for(i = 0; i < niter; i++)
  {
    pi = pi + pow(-1, i) * (4 / (2*((double) i)+1));
  }

  // Stop timing
  end=omp_get_wtime();

  // Print result
  printf("pi estimate is %f, obtained in %f seconds\n", pi, end-start);

}

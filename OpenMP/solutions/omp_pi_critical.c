#include <omp.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[])
{

  //initialize variables
  int i;
  double pi = 0;
  int niter = 100000000;

  // Get timing
  double start,end;
  start=omp_get_wtime();

  // Calculate PI using Leibnitz sum
  /* Fork a team of threads */
#pragma omp parallel for
  for(i = 0; i < niter; i++)
  {
#pragma omp critical
{
    pi = pi + pow(-1, i) * (4 / (2*((double) i)+1));
}
  }

  // Stop timing
  end=omp_get_wtime();

  // Print result
  printf("Pi estimate: %.20f, obtained in %f seconds\n", pi, end-start);
}

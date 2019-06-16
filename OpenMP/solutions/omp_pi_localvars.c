#include <omp.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[])
{

  //initialize variables
  int i;
  double pi = 0;
  double pi_local = 0;
  int niter = 100000000;

  // Get timing
  double start,end;
  start=omp_get_wtime();

  // Calculate PI using Leibnitz sum
  /* Fork a team of threads */
#pragma omp parallel private(pi_local)
{
#pragma omp for
  for(i = 0; i < niter; i++)
  {
    pi_local = pi_local + pow(-1, i) * (4 / (2*((double) i)+1));
  }
#pragma omp atomic
  pi = pi + pi_local;
  
}

  // Stop timing
  end=omp_get_wtime();

  // Print result
  printf("Pi estimate: %.20f, obtained in %f seconds\n", pi, end-start);
}

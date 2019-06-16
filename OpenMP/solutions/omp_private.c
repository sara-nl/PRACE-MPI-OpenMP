#include <omp.h>
#include <stdio.h>

int main (int argc, char *argv[])
{

int tid, nthreads;

/* Fork a team of threads */
#pragma omp parallel private(tid)
  {
  tid = omp_get_thread_num();
  nthreads = omp_get_num_threads();
  printf("Hello World from thread = %d out of %d\n", tid, nthreads);
  }  /* All threads join master thread and disband */
}

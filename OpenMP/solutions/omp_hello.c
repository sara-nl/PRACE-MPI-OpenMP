#include <omp.h>
#include <stdio.h>

int main (int argc, char *argv[])
{
/* Fork a team of threads */
#pragma omp parallel
  {
  printf("Hello World from thread = %d\n", omp_get_thread_num());
  }  /* All threads join master thread and disband */
}

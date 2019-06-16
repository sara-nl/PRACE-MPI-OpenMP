#include <omp.h>
#include <stdio.h>

int main (int argc, char *argv[])
{
  int var = 5;
#pragma omp parallel private(var)
{
  var = var + omp_get_thread_num();
  printf("Hello World from thread = %d: var is %d\n", omp_get_thread_num(), var);
}
}

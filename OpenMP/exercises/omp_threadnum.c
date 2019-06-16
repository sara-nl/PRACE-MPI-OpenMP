#include <omp.h>
#include <stdio.h>

int main (int argc, char *argv[])
{
  printf("Hello World from thread = %d\n", omp_get_thread_num());
}

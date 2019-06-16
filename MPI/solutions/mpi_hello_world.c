#include <mpi.h>
#include <stdio.h>

void main(int argc, char* argv[])
{
  int id = 0;
  int size = 0;
  MPI_Init(&argc, &argv);
  MPI_Comm_rank(MPI_COMM_WORLD, &id);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  printf("Hello world from process %d of %d\n", id, size);
  MPI_Finalize();
}

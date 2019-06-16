#include <mpi.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[])
{
  MPI_Init(&argc, &argv);

  // Get rank and total size of the world
  int myRank, worldsize;
  MPI_Comm_rank(MPI_COMM_WORLD, &myRank);
  MPI_Comm_size(MPI_COMM_WORLD, &worldsize);

  // Initialize variables
  int i;
  double pi = 0;
  int niter = 100000000;

  // Timing
  double start,end;
  start=MPI_Wtime();

  // Calculate part of Leibnitz sum.
  // Work may be distributed as follows:
  // Rank 0 sums element 0, worldsize, 2*worldsize...
  // Rank 1 sums element 1, 1+worldsize, 1+2*worldsize... etc.
  for(i = 0; i < niter; i++)
  {
    pi = pi + pow(-1, i) * (4 / (2*((double) i)+1));
  }

  // So far, a partial result has been computed for the local thread
  // This should be communicated to the master process (e.g. rank 0)
  // This rank can merge all partial results and print the final one

  // Stop timing
  end=MPI_Wtime();

  // Print result
  printf("Rank %d: pi estimate is %f, obtained in %f seconds\n", myRank, pi, end-start);
  // ... but only process 0 should print the final result!

  MPI_Finalize();
}

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
  // Work is distributed as follows:
  // Rank 0 sums element 0, worldsize, 2*worldsize...
  // Rank 1 sums element 1, 1+worldsize, 1+2*worldsize... etc.
  for(i = myRank; i < niter; i=i+worldsize)
  {
    pi = pi + pow(-1, i) * (4 / (2*((double) i)+1));
  }

  // Need to aggregate results!
  double pi_total=0;
  MPI_Reduce(&pi, &pi_total, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

  // Stop timing
  end=MPI_Wtime();

  // Print result for local rank
  printf("Rank %d: pi estimate is %f, obtained in %f seconds\n", myRank, pi, end-start);

  // Print aggregated result
  if(myRank==0)
  {
    printf("Pi estimate after reduce: %.20f\n", pi_total);
  }

  MPI_Finalize();
}

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

  //initialize variables
  int i;
  double pi = 0;
  int niter = 100000000;

  // Divide iterations
  int niter_perrank = niter / worldsize;
  int imin_loop = myRank*niter_perrank;
  int imax_loop = (myRank+1)*niter_perrank;
  printf("Rank %d: calculates elements %d through %d\n", myRank, imin_loop, imax_loop); 
  // Get timing
  double start,end;
  start=MPI_Wtime();

// Calculate PI using Leibnitz sum
  for(i = imin_loop; i < imax_loop; i++)
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
    printf("Pi estimate after reduce: %f\n", pi_total);
  }

  MPI_Finalize();
}

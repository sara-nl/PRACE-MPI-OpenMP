#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{

	// Get the rank and size in the original communicator
	int myRank, worldsize;
	int nprocs_per_dim;
	int dims[3], periods[3], coords[3];
	MPI_Comm torus;

	MPI_Init(&argc, &argv);

	MPI_Comm_rank(MPI_COMM_WORLD, &myRank);
	MPI_Comm_size(MPI_COMM_WORLD, &worldsize);

	// Define nprocs_per_dim
	nprocs_per_dim = 2;

	// Create a Cartesian topology
	// MPI_Cart_create(...);

	printf("Rank %d of %d: coordinates: (%d,%d,%d)\n",
		myRank, worldsize, coords[0], coords[1], coords[2]);

	MPI_Finalize();

}

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
	MPI_Comm dimX, dimY, dimZ;

	MPI_Init(&argc, &argv);

	MPI_Comm_rank(MPI_COMM_WORLD, &myRank);
	MPI_Comm_size(MPI_COMM_WORLD, &worldsize);

	// Define nprocs_per_dim
	nprocs_per_dim = 2;

	// Create a Cartesian topology
	dims[0] = nprocs_per_dim;
	dims[1] = nprocs_per_dim;
	dims[2] = nprocs_per_dim;
	periods[0] = 1;
	periods[1] = 1;
	periods[2] = 1;

	MPI_Cart_create(MPI_COMM_WORLD, 3, dims, periods, 0, &torus);
	MPI_Cart_coords(torus, myRank, 3, coords);

	printf("Rank %d of %d: coordinates (%d,%d,%d)\n",
		myRank, worldsize, coords[0], coords[1], coords[2]);

	// Split the communicator on the basis of the coordinates
	MPI_Comm_split(torus, coords[0], myRank, &dimX);
	MPI_Comm_split(torus, coords[1], myRank, &dimY);
	MPI_Comm_split(torus, coords[2], myRank, &dimZ);

	int X_rank, X_size;
	MPI_Comm_rank(dimX, &X_rank);
	MPI_Comm_size(dimX, &X_size);

	printf("Rank %d of %d: coordinates (%d,%d,%d): rank %d of %d in X \n",
		myRank, worldsize, coords[0], coords[1], coords[2], X_rank, X_size);

	MPI_Comm_free(&dimX);
	MPI_Comm_free(&dimY);
	MPI_Comm_free(&dimZ);

	MPI_Finalize();

}

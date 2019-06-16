#include <mpi.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
	MPI_Init(&argc,&argv);

	// Get local rank
	int myRank;
	MPI_Comm_rank(MPI_COMM_WORLD, &myRank);

	if(myRank == 0) // Work for process with rank 0
	{
		int val_send = 10;
		MPI_Send(&val_send, 1, MPI_INT, 1, 17, MPI_COMM_WORLD);
	}
	else if(myRank == 1) // Work for process with rank 1
	{
		int val_recv;
		MPI_Status status;
		MPI_Recv(&val_recv, 1, MPI_INT, 0, 17, MPI_COMM_WORLD, &status);
		printf("Rank %d received value %d\n", myRank, val_recv);
	}
	else // Other ranks do nothing
	{
	}

	MPI_Finalize();
}

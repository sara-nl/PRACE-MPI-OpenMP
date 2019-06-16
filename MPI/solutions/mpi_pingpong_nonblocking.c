#include <mpi.h>
#include <stdio.h>

int main(int argc, char* argv[])
{
        MPI_Init(&argc,&argv);

        // Get local rank
        int myRank;
        MPI_Comm_rank(MPI_COMM_WORLD, &myRank);

        // Timing
        double timeStart;
        double timeEnd;
        timeStart = MPI_Wtime();

        // Repeated send/receive several times for accurate timing
        int i;
        int niter=1000;
        for(i = 0; i < niter; i++)
        {
                if(myRank == 0) // Work for process with rank 0
                {
                        MPI_Status status;
                        MPI_Request request;
                        char ping[5] = "ping";
                        char pongReceive[5];
                        MPI_Isend(ping, 5, MPI_CHAR, 1, 17, MPI_COMM_WORLD, &request);
                        MPI_Recv(pongReceive, 5, MPI_CHAR, 1, 23, MPI_COMM_WORLD, &status);
                        MPI_Wait(&request, &status);
                }
                else if(myRank == 1) // Work for process with rank 1
                {
                        MPI_Status status;
                        MPI_Request request;
                        char pong[5] = "pong";
                        char pingReceive[5];
                        MPI_Isend(pong, 5, MPI_CHAR, 0, 23, MPI_COMM_WORLD, &request);
                        MPI_Recv(pingReceive, 5, MPI_CHAR, 0, 17, MPI_COMM_WORLD, &status);
                        MPI_Wait(&request, &status);
                }
                else
                {
                }
        }

        // Timing
        timeEnd = MPI_Wtime();
        printf("Communication time was %10.7f microseconds\n", ((timeEnd-timeStart)/(niter*2))*1000000);

        MPI_Finalize();
}

      program mpi_pi

        use mpi
        implicit none

c       Initialize variables
        integer :: ierr, myRank, worldsize
        integer :: i, niter = 100000000
        double precision :: pi_val, pi_total 
        double precision :: start, end, total

        call MPI_INIT(ierr)
c       Get rank and total size of the world
        call MPI_COMM_RANK(MPI_COMM_WORLD, myRank, ierr)
        call MPI_COMM_SIZE(MPI_COMM_WORLD, worldsize, ierr)

c       Timing
        start = MPI_WTIME()

c       Calculate part of Leibnitz sum
c       Work is distributed as follows:
c       Rank 0 sums element 0, worldsize, 2*worldsize...
c       Rank 1 summ element 1, 1+worldsize, 1+2*worldsize... etc.
        do i = myRank,niter-1,worldsize
          pi_val = pi_val + (-1)**i * (4 / (2*dble(i)+1))
        enddo

c       Need to aggregate results
        pi_total = 0.d0
        call MPI_REDUCE(pi_val, pi_total, 1, MPI_DOUBLE, 
     &                  MPI_SUM, 0, MPI_COMM_WORLD, ierr);

c       Stop timing
        end = MPI_Wtime()
        total = end - start

c       Print result for local rank
        print *,"Rank ",myRank," : pi estimate is ",pi_val,
     &          ", obtained in ",total," seconds"

c       Print aggregated result
        if (myRank == 0) then
          print *,"Pi estimate after reduce: ",pi_total
        endif

        call MPI_Finalize(ierr)

      end program

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
c       Work may be distributed as follows:
c       Rank 0 sums element 0, worldsize, 2*worldsize...
c       Rank 1 summ element 1, 1+worldsize, 1+2*worldsize... etc.
        do i = 0,niter-1
          pi_val = pi_val + (-1)**i * (4 / (2*dble(i)+1))
        enddo

c       So far, a partial result has been computed for the local thread
c       This should be communicated to the master process (e.g. rank 0)
c       This rank can merge all partial results and print the final one

c       Stop timing
        end = MPI_Wtime()
        total = end - start

c       Print result
        print *,"Rank ",myRank," : pi estimate is ",pi_val,
     &          ", obtained in ",total," seconds"
c       ... but only process 0 should print the final result!

        call MPI_Finalize(ierr)

      end program

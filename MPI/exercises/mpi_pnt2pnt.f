      program pnt2pnt

        use mpi
        implicit none

        integer :: ierr, myRank, status(MPI_STATUS_SIZE)
        integer :: val_send, val_recv

        call MPI_INIT(ierr)

c       Get local rank
        call MPI_COMM_RANK(MPI_COMM_WORLD, myRank, ierr)

        if (myRank == 0) then
          val_send = 10
          call MPI_SEND(val_send, 1, MPI_INTEGER, XX, AA,
     &                  MPI_COMM_WORLD, ierr)
        else if (myRank == 1) then
          call MPI_RECV(val_recv, 1, MPI_INTEGER, YY, BB, 
     &                  MPI_COMM_WORLD, status, ierr)
          print *,"Rank ",myRank," received value ",val_recv
        endif
        
        call MPI_Finalize(ierr)

      end program

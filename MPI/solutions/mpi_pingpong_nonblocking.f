      program pingpong

c       IMPORTANT NOTE: the optimal module would be mpi_f08
c        use mpi_f08
        use mpi
        implicit none

        integer :: ierr, myRank
        double precision :: timeStart, timeEnd, timeTotal
        integer :: i, j, niter = 1000
        integer :: status(MPI_STATUS_SIZE), request
        character(5) :: string
c       IMPORTANT NOTE: the send buffers should be asynchronous
c        character, asynchronous :: ping(5), pong(5)
        character :: ping(5), pong(5)
        character :: pingReceive(5), pongReceive(5)

c       Get local rank
        call MPI_INIT(ierr)
        call MPI_COMM_RANK(MPI_COMM_WORLD, myRank, ierr)

c       Timing
        timeStart = MPI_WTIME();

c       Repeated send/receive several times for accurate timing
        do i = 1,niter
c         Work for process with rank 0
          if (myRank == 0) then
            string = "ping"
            do j = 1,len(string)
              ping(j) = string(j:j)
            enddo
            call MPI_ISEND(ping, 5, MPI_CHARACTER, 1, 17,
     &                    MPI_COMM_WORLD, request, ierr)
            call MPI_RECV(pongReceive, 5, MPI_CHARACTER, 1, 23,
     &                    MPI_COMM_WORLD, status, ierr)
            call MPI_WAIT(request, status, ierr)
c           IMPORTANT NOTE: buffer protection should be enabled!
c            if (.not. MPI_ASYNC_PROTECTS_NONBLOCKING)
c     &        call MPI_F_SYNC_REG(ping)
c         Work for process with rank 1
          else if (myRank == 1) then
            string = "pong"
            do j = 1,len(string)
              pong(j) = string(j:j)
            enddo
            call MPI_ISEND(pong, 5, MPI_CHARACTER, 0, 23, 
     &                    MPI_COMM_WORLD, request, ierr)
            call MPI_RECV(pingReceive, 5, MPI_CHARACTER, 0, 17, 
     &                    MPI_COMM_WORLD, status, ierr)
            call MPI_WAIT(request, status, ierr)
c           IMPORTANT NOTE: buffer protection should be enabled!
c            if (.not. MPI_ASYNC_PROTECTS_NONBLOCKING)
c     &        call MPI_F_SYNC_REG(pong)
          endif
        enddo

c       Timing
        timeEnd = MPI_WTIME()

        timeTotal = ((timeEnd-timeStart)/(niter*2))*1000000

        print *,"Communication time was ",timeTotal," microseconds"

        call MPI_FINALIZE(ierr)

      end program

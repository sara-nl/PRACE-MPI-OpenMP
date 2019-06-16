      program hello

        use mpi
        implicit none

        integer :: id = 0
        integer :: size = 0
        integer :: ierr

        call MPI_INIT(ierr)
        call MPI_COMM_RANK(MPI_COMM_WORLD, id, ierr)
        call MPI_COMM_SIZE(MPI_COMM_WORLD, size, ierr)

        print *,"Hello world from process",id," of ",size

        call MPI_FINALIZE(ierr)

      end program

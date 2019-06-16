      program torus

        use mpi
        implicit none

        integer :: myRank, worldsize
        integer :: nprocs_per_dim
        integer :: dims(3)
        logical :: periods(3)
        integer :: coords(3)
        integer :: torus_cart
        integer :: ierr

        call MPI_INIT(ierr)

c       Get the rank and size in the original communicator
        call MPI_COMM_RANK(MPI_COMM_WORLD, myRank, ierr)
        call MPI_COMM_SIZE(MPI_COMM_WORLD, worldsize, ierr)

c       Define nprocs_per_dim
        nprocs_per_dim = 2

c       Create a Cartesian topology
c        call MPI_CART_CREATE(...)

        print *,"Rank ",myRank," of ",worldsize,": coordinates: (",
     &          coords(1),",",coords(2),",",coords(3),")"

        call MPI_FINALIZE(ierr);

      end program

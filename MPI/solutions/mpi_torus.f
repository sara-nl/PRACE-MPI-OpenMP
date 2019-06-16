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
        dims(1) = nprocs_per_dim
        dims(2) = nprocs_per_dim
        dims(3) = nprocs_per_dim
        periods(1) = .TRUE.
        periods(2) = .TRUE.
        periods(3) = .TRUE.

        call MPI_CART_CREATE(MPI_COMM_WORLD, 3, dims,
     &                       periods, .TRUE., torus_cart, ierr)
        call MPI_CART_COORDS(torus_cart, myRank, 3, coords, ierr)

        print *,"Rank ",myRank," of ",worldsize,": coordinates: (",
     &          coords(1),",",coords(2),",",coords(3),")"

        call MPI_FINALIZE(ierr);

      end program

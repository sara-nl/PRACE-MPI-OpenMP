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
        integer :: dimX, dimY, dimZ
        integer :: X_rank, X_size

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

c       Split the communicator on the basis of the coordinates
        call MPI_COMM_SPLIT(torus_cart, coords(1), myRank, dimX, ierr)
        call MPI_COMM_SPLIT(torus_cart, coords(2), myRank, dimY, ierr)
        call MPI_COMM_SPLIT(torus_cart, coords(3), myRank, dimZ, ierr)

        call MPI_Comm_rank(dimX, X_rank, ierr);
        call MPI_Comm_size(dimX, X_size, ierr);

        print *,"Rank ",myRank," of ",worldsize,": coordinates: (",
     &          coords(1),",",coords(2),",",coords(3),"): rank ",
     &          X_rank," of ",X_size," in X"

        call MPI_Comm_free(dimX, ierr);
        call MPI_Comm_free(dimY, ierr);
        call MPI_Comm_free(dimZ, ierr);

        call MPI_FINALIZE(ierr);

      end program

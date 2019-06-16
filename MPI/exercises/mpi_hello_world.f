      program hello

!       load the MPI module
        implicit none

        integer :: id = 0
!       define at least one VERY IMPORTANT variable...

!       initialize the MPI environment
!       obtain the process ID
!       optional: obtain the total number of processes

        print *,"Hello world from ",id

!       finalize the MPI environment

      end program

      program vectoradd
             
        use omp_lib
        implicit none

c       Initialize variables
        integer :: size = 1000000
        integer, allocatable :: a(:)
        integer, allocatable :: b(:)
        integer, allocatable :: c(:)
        double precision :: start, end
        integer :: i
        double precision :: val

        allocate(a(size))
        allocate(b(size))
        allocate(c(size))

c       Time the parallel loop

        start = omp_get_wtime()

c       Fill a & b with random numbers beween 0 and 100
c       IMPORTANT NOTES:
c        * rand() is only valid for GNU Fortran compilers
c        * random_number is only valid for Fortran 95 or later
!$OMP PARALLEL DO
        do i=1,size
          call random_number(val)
          a(i) = nint(val*100)
          call random_number(val)
          b(i) = nint(val*100)
          c(i) = a(i) + b(i)
        enddo
!$OMP END PARALLEL DO

        end = omp_get_wtime() - start;

        deallocate(a)
        deallocate(b)
        deallocate(c)

        print *,"Summed vectors a and b in ",end," seconds"


      end program

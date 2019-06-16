      program pi

        use omp_lib
        implicit none

c       initialize variables
        integer :: i
        double precision :: pi_val = 0.d0
        integer :: niter = 100000000

c       Get timing
        double precision :: start,end
        start=omp_get_wtime()

c       Calculate PI using Leibnitz sum
!$OMP PARALLEL DO
        do i=0,niter-1
!$OMP CRITICAL
          pi_val = pi_val + (-1)**i * (4 / (2*dble(i)+1))
!$OMP END CRITICAL
        enddo
!$OMP END PARALLEL DO

c       Stop timing
        end=omp_get_wtime()-start;

c       Print result
        print *,"Pi estimate: ",pi_val," obtained in ",end," seconds"

      end program

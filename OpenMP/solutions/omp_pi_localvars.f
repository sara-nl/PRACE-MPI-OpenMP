      program pi

        use omp_lib
        implicit none

c       initialize variables
        integer :: i
        double precision :: pi_val = 0.d0
        double precision :: pi_val_local = 0.d0
        integer :: niter = 100000000

c       Get timing
        double precision :: start,end
        start=omp_get_wtime()

c       Calculate PI using Leibnitz sum
!$OMP PARALLEL PRIVATE(pi_val_local)
!$OMP DO
        do i=0,niter-1
          pi_val_local = pi_val_local + (-1)**i * (4 / (2*dble(i)+1))
        enddo
!$OMP ATOMIC
        pi_val = pi_val + pi_val_local
!$OMP END PARALLEL

c       Stop timing
        end=omp_get_wtime()-start;

c       Print result
        print *,"Pi estimate: ",pi_val," obtained in ",end," seconds"

      end program

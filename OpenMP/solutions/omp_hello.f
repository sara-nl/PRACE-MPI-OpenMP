      program hello

        use omp_lib
        implicit none

!$OMP PARALLEL
        print*,"Hello World from thread = ",omp_get_thread_num()
!$OMP END PARALLEL

      end program

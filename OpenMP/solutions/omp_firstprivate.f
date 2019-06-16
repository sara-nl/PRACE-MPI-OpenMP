      program threadnum
              
        use omp_lib
        implicit none

        integer :: var = 5
!$OMP PARALLEL FIRSTPRIVATE(var)
        var = var + omp_get_thread_num(); 
        print *,"Hello World from thread = ",omp_get_thread_num(),
     &          ": var is ",var
!$OMP END PARALLEL
        
      end program

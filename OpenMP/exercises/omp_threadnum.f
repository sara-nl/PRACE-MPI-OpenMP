      program threadnum
              
        use omp_lib
        implicit none
        
        print *,"Hello World from thread = ",omp_get_thread_num()
        
      end program

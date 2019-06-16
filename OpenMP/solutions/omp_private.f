      program private

        use omp_lib
        implicit none

        integer :: tid, nthreads

c       Fork a team of threads

!$OMP PARALLEL PRIVATE(tid)

        tid = omp_get_thread_num();
        nthreads = omp_get_num_threads();
        print *,"Hello World from thread = ",tid," out of ",nthreads

!$OMP END PARALLEL

      end program

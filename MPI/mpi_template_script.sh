#!/bin/bash
#
# One node is set for execution
#SBATCH -N 1 
# Select the number of tasks per node
# #SBATCH --ntasks-per-node=XXX
# Select the correct reservation ID
# #SBATCH --reservation=ptc_course_X
#
# Five minutes are set for execution
#SBATCH -t 00:05:00
#
# running MPI job with 2 cores
srun -n 2 ./a.out

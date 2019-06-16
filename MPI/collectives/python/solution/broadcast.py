from __future__ import print_function
from mpi4py import MPI
import numpy
from sys import stdout

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

assert size == 4, 'Number of MPI tasks has to be 4.'

data = numpy.arange(8) + rank*8

if rank == 0:
    print('Broadcast:')

# Simple broadcast
comm.Bcast(data, root=0)
print('  Task {0}: {1}'.format(rank, data))


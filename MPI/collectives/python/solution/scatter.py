from __future__ import print_function
from mpi4py import MPI
import numpy
from sys import stdout

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

assert size == 4, 'Number of MPI tasks has to be 4.'

data = numpy.arange(8) + rank*8
buff = numpy.zeros(8, int)
buff[:] = -1

# ... wait for every rank to finish ...
stdout.flush()
comm.barrier()
if rank == 0:
    print('')
    print('-' * 32)
    print('')
    print('Data vectors:')
print('  Task {0}: {1}'.format(rank, data))
stdout.flush()
comm.barrier()
if rank == 0:
    print('')
    print('Scatter:')

# Scatter one vector
comm.Scatter(data, buff[:2], root=0)
print('  Task {0}: {1}'.format(rank, buff))


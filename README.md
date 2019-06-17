# PRACE course: Parallel Programming with MPI and OpenMP (3 days)

In this course we will be using the [Cartesius supercomputer](https://userinfo.surfsara.nl/systems/cartesius) hosted at SURFsara. You will need to connect to it through the ssh protocol (natively installed on Linux and Mac).

For Windows users, we recommend to connect via ssh using [MobaXterm](https://mobaxterm.mobatek.net/) or, on Windows 10, using the [native bash environment](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide)

## Before you connect to Cartesius

Please check your email inbox for a message with your access credentials and follow the instructions to connect to the user portal, so that you can accept the usage agreement and change your password.

## Connect to Cartesius

To connect to Cartesius, please open a terminal and use the following command:

    ssh ptcXXX@cartesius.surfsara.nl

Here "ptcXXX" is the login name that you received via email. Type in the password you received together with your login name and press Enter (note that the cursor may not move while introducing the password, but the typing will succeed).

This access to Cartesius is made available for duration of the course and at most one week after its finalization.

## Preparation for the hands-on sessions

Login to Cartesius and clone the git repository:

    ssh ptcXXX@cartesius.surfsara.nl
    git clone https://github.com/sara-nl/PRACE-MPI-OpenMP.git
    
There is a reservation set for the whole duration of the course. In order to access a compute node interactively, type the following command:

    srun --reservation=ptc_course_X -t 08:00:00 -N 1 --pty bash -il
    
The "X" in the reservation name "ptc_course_X" corresponds to the day of the course. That is: for the first day the reservation is "ptc_course_1", for the second day is "ptc_course_2", etc.

## OpenMP hands-on exercises
    
In order to execute the OpenMP tests, please load the following GCCcore module.

    module load GCCcore/6.4.0
    
You may compile OpenMP codes like this:

    gcc -fopenmp openmp_code.c          ### C compilation
    gfortran -fopenmp openmp_code.f     ### Fortran compilation

As a result of the use of a reservation, all OpenMP codes may be executed interactively in the terminal where the interactive session is opened. The execution can be done directly as follows (e.g. if the executable is called "a.out"):

    ./a.out
    
If you wish to indicate the number of threads for the execution using the environment variable OMP_NUM_THREADS, you may run the tests including this variable before the executable.

    OMP_NUM_THREADS=4 ./a.out


## OpenMP special hands-on with Parallelware Trainer

In order to try the [Parallelware Trainer](https://www.appentra.com/products/parallelware-trainer/) developed by [Appentra](https://www.appentra.com), first connect to Cartesius with the -Y flag, in order to be able to use the interactive tool:

    ssh -Y ptcXXX@cartesius.surfsara.nl
    
Once you are in your home folder, please copy the folder that contains the software and the temporary license (valid until the 14th of July 2019). In order to execute the software, you'll need to load the required GCC module.
    
    cp -r /home/ptc001/pwtrainer-1.2.0_linux-x64/ .
    cd pwtrainer-1.2.0_linux-x64
    module load GCCcore/6.4.0
    
In order to execute the Parallelware Trainer, type the following command.
    
    ./pwtrainer &
    
After that, click in the link to activate the license. You will find the license file (pwtrainer-Jul19-SURFsara.lic) in the directory pwtrainer-1.2.0_linux-x64, where the software is installed.

The examples that will be used during this special hands-on exercise can be found in the folder docs/examples, and you may save different versions of each code in the corresponding folder.

If you wish to run the codes, please use the interactive session outside the graphical interface.

## MPI hands-on exercises

For the use of MPI, please purge the default environment and load the Intel compiler module as follows:

    module purge
    module load mpi/impi
    
You may compile MPI codes like this:

    mpicc mpi_code.c        ### C compilation
    mpif90 mpi_code.f       ### Fortran compilation
    
As a result of the use of a reservation, all MPI codes may be executed interactively on a single node in the terminal where the interactive session is opened. The correct way to execute MPI codes is as follows (e.g. for the use of 4 processes using an executable with name "a.out").

    srun -n 4 ./a.out


## Multinode MPI tests

The execution of multinode tests with MPI should be done using a batch script. Please use the script template mpi_script_template.sh in the directory MPI of this repository in order to run your MPI tasks (remember to change the reservation name):

Modify this template conveniently and save it in a file in your home directory of Cartesius (e.g. script.sh)

In order to run your code, you should submit your script in the terminal like this:

    sbatch script.sh
    
Use this command to check that your job is running:

    squeue –u $(whoami)
   
After executing squeue you will see the JobID of the script ("NNNNNNN"), and if you do:

    ls slurm*

you may also see a new file called "slurm-NNNNNNN.out". This file contains the output of your code, so that you can check if the execution was successful.

# Parallel Programming with MPI and OpenMP

In this course we will be using the [Cartesius supercomputer](https://userinfo.surfsara.nl/systems/cartesius) hosted at SURFsara. You will need to connect to them through the ssh protocol (natively installed on Linux and Mac).

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

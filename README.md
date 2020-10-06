# .me
===

This repository is a collection of configurations that can be used to 
automatically setup your MacOSX developer environment and to standardize
that setup across machines. 

## /env
This directory contains environment variables that should be set on each 
launch of a new shell, regardless if it's a login shell or not. 

## /git
This directory contains common global `git` configuration that should be 
applied across all your `git` projects. 

## /includes
This directory contains a collection of functions that 
assist with common CLI tasks. 

## /programs
This directory contains a collection of installation and configuration 
scripts for a number of common CLI developer tools

## How to install? 

Use the `init.sh` script found at the root of this repository to initiate 
the installation and configuration of the environment. This script will 
configure your shell, your git configs, and install default programs.  
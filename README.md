# pflotran-docker

## Overview

Containerized version of [E4D](https://www.pnnl.gov/projects/e4d)

## Quick Start

If you have a dedicated directory for a model to hold the input and output
files, first go to that directory in your shell. For example,
if you have a directory called `model_files` in your home directory, then
issue:

```
$ cd ~/model_files
```

Suppose you have a model input file in that directory called `e4d.inp`

You can invoke E4D with:

```
$ docker run -v $(pwd):/data subsurfaceinsights/e4d e4d
```

It then run and produce output files in the directory

## Parallel Runs

The container has mpi built in, so you can invoke e4d in parellel

```
$ docker run -v $(pwd):/data subsurfaceinsights/e4d mpirun -np 6 e4d
```

## Other Tools

The container also has `tetgen`, `triangle`, and `px` tools built in, which can
be invoked like so:

```
$ docker run -v $(pwd):/data subsurfaceinsights/e4d triangle
```

```
$ docker run -v $(pwd):/data subsurfaceinsights/e4d tetgen
```

```
$ docker run -v $(pwd):/data subsurfaceinsights/e4d px
```

These can be referenced from the e4d input file also.

## Advanced Usage Information

The container's working directory is `/data` so mapping any directory to that
data will provide access to model files.

The container's E4D process will run as whatever user owns the `/data`
directory to maintain ownership consistency.




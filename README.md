# k8s Upstream Dependency Generator

This repository contains a utility that generates a git repository with all of the files necessary to build a Rancher k8s upstream dependency.

## Build

```sh
make
```

## Install

```sh
make install
```

## Run

```sh
./dep_gen rancher/fips-image-build-flannel
```

```sh
docker run --rm -v $PWD:$PWD -w $PWD briandowns/dep_gen:v0.1.0 dep_gen rancher/fips-image-build-flannel
```

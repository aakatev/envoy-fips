# envoy-fips

Envoy Docker image in FIPS compliant mode.
Note: This is an optimized version that creates a Docker image significantly smaller than the original.

### Building

To build image use docker cli, for example:
```sh
[root@portal envoy-fips]# docker build -t v1.27.1opt -f Dockerfile .
```
**Note:** You need to have both **Dockerfile** and **docker-entrypoint.sh** in the current directory!

When done, find the image ID using the **docker images -a** command and save the Docker file to a tar.gz file using the **docker save** command:

```sh
[root@portal ctera]# docker images -a | grep v1.27.1opt
v1.27.1opt     latest     7b31c2c78b73   5 hours ago     168MB
[root@portal ctera]# docker save 7b31c2c78b73 -o $datadir/envoy-contrib-fips.v1.27.1.opt.tar.gz
[root@portal ctera]# ll
total 164956
...
-rw-------.  1 root     root     168908288 Feb 15 13:12 envoy-contrib-fips.v1.27.1.opt.tar.gz
...
```

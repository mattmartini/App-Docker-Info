# App::Docker::Info

Script to display information about current docker components

## Docker List and Inspect

This script gathers information about docker images, containers, volumes, and system via docker list and inspect commands rendered as JSON.  

```
docker image inspect --format '{{json .}}' 6feeb73a8469 | jq
```


## INSTALLATION
To install this module, run the following commands:  

perl Makefile.PL  
make  
make test  
make install  

Note: This will install the command docker-info into your path

## Inspiration
This script was inspired by [docker-image-list.sh](https://github.com/rimelek/scripts-for-docker.git) created by: Ákos Takács (rimelek).

## COPYRIGHT AND LICENSE

Copyright (C) 2025, Matt Martini  

See _LICENSE_ file for Software License.


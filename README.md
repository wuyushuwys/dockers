# My Dockers for jetson and 86x workstation

### ubuntu18-env 
  - You could build yourself or download the image
    - Pull image: `docker pull wuyushu/ubuntu18-env:v2`
    - Build image: run `./build.sh` in your workstation
  - contains serveral bash files to create/close/attach/stop containers
    - functionalities are straight-forward
    - for more information about docker, see [official documents](https://docs.docker.com/)
  - **setup_nvidia.sh:** setup gpu access for workstation. 
  
  ***these commands require root premissions on /dev/\*! Be careful when managing /dev/\* in container***

### jetson-env (developing)
  - You could build yourself or download the image
    - Pull image: `docker pull wuyushu/jetson-env:v0.1`
    - Build image: run `./build.sh` in your workstation
  - to do list
    - [ ] simple functionalities fork from ubuntu18-env
    - [ ] tested in jetson device

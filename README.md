# DOcker containers for jetson and 86x workstation

- these are just simple samples of docker containers for ubuntu 18.04 and jetson.

## Instruction
- `git clone https://github.com/SICA-Lab/dockers.git`
- `cd dockers/<env you need>`
- build or pull container you need with command below
  - `docker pull <container-name>`
- configure nvidia for container: `./setup_nvidia.sh`
- execute bash help file to enter container

### ubuntu18-env
  - **setup_nvidia.sh:** setup gpu access for workstation. 
  - Installed:
    - pytorch
    - jupyterlab
    - python3
    - opencv3.4
    - ros-melodic
    - Realsense2 SDK
  - You could build yourself or download the image
    - Pull image: `docker pull wuyushu/ubuntu18-env:v2`
    - Build image: run `./build.sh` in your workstation
  - contains serveral bash files to create/close/attach/stop containers
    - functionalities are straight-forward
    - for more information about docker, see [official documents](https://docs.docker.com/)
  
  
  ***these commands require root premissions on /dev/\*! Be careful when managing /dev/\* in container***

### jetson-env
  -  **setup_nvidia.sh:** setup gpu access for jetson. 
  - You could build yourself or download the image
    - Pull image: `docker pull wuyushu/jetson-env:v1.0`
    - Build image: run `./build.sh` in your workstation
  - to do list
    - [X] simple functionalities fork from ubuntu18-env
    - [X] tested in jetson device
    - [X] realsense camera test complete
  - Installed:
    - pytorch
    - python3
    - opencv3.4
    - ros-melodic
    - Realsense2 SDK

# My Dockers for jetson and 86x workstation

### ubuntu18-env 
  - contains serveral bash files to create/close/attach/stop containers
    - functionalities are straight-forward
    - for more information about docker, see [official documents](https://docs.docker.com/)
  - **setup_nvidia.sh:** setup gpu access for workstation
*** the command require superuser premissions on /dev/\*! Be careful when managing /dev/\* in container ***

### jetson-env (developing)
  - to do list
    - []simple functionalities fork from ubuntu18-env
    - []tested in jetson device
FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
LABEL maintainer="Yushu Wu <wu.yushu@northeastern.edu>"

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDA_DRIVER_CAPABILITIES=compute,utility

RUN apt-get clean && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		git \
		build-essential \
		cmake \
		vim \
		wget \
		pkg-config \
        python-pip \
        python3-pip \
        python3-dev \
        python-numpy \
        libjpeg8-dev \
        libtiff5-dev \
        libgtk2.0-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libatlas-base-dev \
        gfortran \
        libc6-dev-i386 \
        libavresample-dev \
        libgphoto2-dev \
        libx32gcc-4.8-dev \
        libgstreamer-plugins-base1.0-dev \
        libdc1394-22-dev



# Install python3 package
RUN pip3 install setuptools matplotlib pandas scipy scikit-learn wheel

# Install Pytorch
RUN pip3 install torch torchvision

# Install OpenCV 3.4
WORKDIR /opt
RUN wget https://github.com/opencv/opencv_contrib/archive/3.4.0.tar.gz --no-check-certificate && tar -xf 3.4.0.tar.gz && rm 3.4.0.tar.gz
RUN wget https://github.com/opencv/opencv/archive/3.4.0.tar.gz --no-check-certificate && tar -xf 3.4.0.tar.gz && rm 3.4.0.tar.gz

WORKDIR /opt/opencv-3.4.0
RUN mkdir build && cd build && \
        cmake   -D CMAKE_BUILD_TYPE=RELEASE \
                -D BUILD_NEW_PYTHON_SUPPORT=ON \
                -D CMAKE_INSTALL_PREFIX=/usr/local \
                -D INSTALL_C_EXAMPLES=OFF \
                -D INSTALL_PYTHON_EXAMPLES=OFF \
				-D WITH_TBB=ON \
				-D WITH_V4L=ON \
				-D WITH_LIBV4L=ON \
				-D WITH_OPENGL=ON \
                -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-3.4.0/modules \
                -D BUILD_EXAMPLES=OFF /opt/opencv-3.4.0 && \
        make -j$(nproc) && \
        make install && \
        ldconfig && \
        rm -rf /opt/opencv*

WORKDIR /root/

RUN /bin/bash -c 'echo "export PATH=/usr/local/cuda-10.2/bin:/usr/local/cuda-10.2/NsightCompute-2019.1${PATH:+:${PATH}}" >> /root/.bashrc'
RUN /bin/bash -c 'echo "export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> /root/.bashrc'

# Install Jupyterlab

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libcanberra-gtk-module libcanberra-gtk3-module
RUN pip3 install jupyterlab
# Configure Jupter
RUN jupyter lab --generate-config && echo "c.NotebookApp.allow_root = True" >> ~/.jupyter/jupyter_notebook_config.py && mkdir /root/lab
RUN /bin/bash -c 'echo "alias open_jupyter_lab=\"jupyter-lab --no-browser --ip 0.0.0.0 --port 8888 /root/lab\"" >> ~/.bashrc'



RUN mkdir /root/mount

# ROS and Gazebo Installation

RUN apt-get update && \
	apt-get install -y vim \
	tmux \
	git \
	wget \
	lsb-release \
	lsb-core 
# Setup your sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
		apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
# Installation
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y ros-melodic-desktop-full
# Environment setup
RUN /bin/bash -c 'echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc'
# Dependencies for building packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python-rosdep \
		python-rosinstall \
		python-rosinstall-generator \
		python-wstool \
		build-essential \
# Initialize rosdep
		python-rosdep
RUN rosdep init && rosdep update

# Install catkin_tools (to use catkin build)
RUN /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
RUN wget http://packages.ros.org/ros.key -O - | apt-key add -

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python-catkin-tools apt-utils


# Setup ROS
RUN mkdir -p ~/catkin_ws/src 
RUN cd ~/catkin_ws 
RUN /bin/bash -c 'echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc' && \
    /bin/bash -c "source ~/.bashrc"

RUN /bin/bash -c 'echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc'

# Force "python" command to execute "python3"
RUN /bin/bash -c 'echo "alias python=python3" >> ~/.bashrc'

# Fixed the issue: "Cannot run ros with python3 and cannot import cv2 from python3"
# This issue is caused by ROS that creates it's own cv2.so file for python 2, and then routes every import request to that file
RUN cd /usr/local/lib/python3.6/dist-packages 
RUN ln -s /usr/local/lib/python2.7/dist-packages/cv2.so cv2.so
RUN cd /opt/ros/melodic/lib/python2.7/dist-packages
RUN mkdir bak && mv cv2.so ~/bak/cv2.so.bak 


# Instsall Realsense2 library
RUN apt-key adv --keyserver keys.gnupg.net \
				--recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || \
				apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
									--recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE && \
				add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u && \
				DEBIAN_FRONTEND=noninteractive apt-get install -y \
							librealsense2-dev \
							librealsense2-utils \
							librealsense2-dkms

RUN DEBIAN_FRONTEND=noninteractive apt-get install -f && DEBIAN_FRONTEND=noninteractive apt-get install -y \
		libglew-dev \
		sudo \
		dkms \
		cmake-qt-gui \
		mesa-utils


RUN rm -rf /var/lib/apt/lists/*

ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
RUN cd /root/

CMD ["/bin/bash"]

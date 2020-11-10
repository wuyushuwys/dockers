ARG JETSON_VERSION=r32.4.4-pth1.6-py3
FROM --platform=linux/arrch64 nvcr.io/nvidia/l4t-pytorch:${JETSON_VERSION}
LABEL maintainer="Yushu Wu <wu.yushu@northeastern.edu>"

ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDA_DRIVER_CAPABILITIES=compute,utility,graphics

# #
# # install prerequisites (many of these are for numpy)
# #
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#             python3-pip \
# 		  python3-dev \
# 		  libopenblas-dev \
# 		  libopenmpi2 \
#             openmpi-bin \
#             openmpi-common \
# 		  gfortran \
#           libopenblas-base \
#           libopenmpi-dev 


# # Install python3 package
# RUN pip3 install setuptools Cython wheel
# RUN pip3 install numpy --verbose

# # Install pytorch 1.7
# ARG PYTORCH_URL=https://nvidia.box.com/shared/static/wa34qwrwtk9njtyarwt5nvo6imenfy26.whl
# ARG PYTORCH_WHL=torch-1.7.0-cp36-cp36m-linux_aarch64.whl

# RUN wget --quiet --show-progress --progress=bar:force:noscroll --no-check-certificate ${PYTORCH_URL} -O ${PYTORCH_WHL} && \
#     pip3 install ${PYTORCH_WHL} --verbose && \
#     rm ${PYTORCH_WHL}

# # Install torchvision v0.8.1
# ARG TORCHVISION_VERSION=v0.8.1
# RUN apt-get install -y --no-install-recommends \
#         libjpeg-dev \
#         zlib1g-dev \
#         libpython3-dev \
#         libavcodec-dev \
#         git \
#         vim \
#         cmake \
#         build-essential \
#         wget \
#         pkg-config \
#         libv4l-dev

# RUN git clone --branch ${TORCHVISION_VERSION}  https://github.com/pytorch/vision torchvision && \
#     cd torchvision && \
#     export BUILD_VERSION=0.8.1 && \
#     python3 setup.py install && \
#     pip3 install pillow && \
#     cd ../ && rm -rf torchvision

# # Install torchaudio v0.7.0
# ARG TORCHAUDIO_VERSION=v0.7.0
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#         sox \
#         libsox-dev \
#         libsox-fmt-all

# RUN git clone -b ${TORCHAUDIO_VERSION} https://github.com/pytorch/audio torchaudio && \
#     cd torchaudio && \
#     python3 setup.py install && \
#     cd ../ && \
#     rm -rf torchaudio

# # 
# # PyCUDA
# #
# ENV PATH="/usr/local/cuda/bin:${PATH}"
# ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"
# RUN echo "$PATH" && echo "$LD_LIBRARY_PATH"

# RUN pip3 install pycuda --verbose


# Install ROS melodic

ARG ROS_PKG=ros_base
ENV ROS_DISTRO=melodic
ENV ROS_ROOT=/opt/ros/${ROS_DISTRO}
WORKDIR /workspace

# add the ROS deb repo to the apt sources list
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
          git \
		cmake \
		build-essential \
		curl \
		wget \ 
		gnupg2 \
		lsb-release \
    && rm -rf /var/lib/apt/lists/*
    
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# install ROS packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
		ros-melodic-ros-base \
		ros-melodic-image-transport \
		ros-melodic-vision-msgs \
          python-rosdep \
          python-rosinstall \
          python-rosinstall-generator \
          python-wstool \
    && rm -rf /var/lib/apt/lists/*
  
# init/update rosdep
RUN apt-get update && \
    cd ${ROS_ROOT} && \
    rosdep init && \
    rosdep update
    
RUN echo 'source ${ROS_ROOT}/setup.bash' >> /root/.bashrc 

# # Install OpenCV 3.4

# RUN apt-get update && apt-get install -y \
#     libavcodec-dev \
#     libavformat-dev \
#     libavutil-dev \
#     libeigen3-dev \
#     libglew-dev \
#     libtiff5-dev \
#     libjpeg-dev \
#     libpng-dev \
#     libpostproc-dev \
#     libswscale-dev \
#     libtbb-dev \
#     libgtk2.0-dev \
#     libxvidcore-dev \
#     libx264-dev \
#     pkg-config \
#     zlib1g-dev \
#     && \
#     apt-get clean
# RUN apt-get update && apt-get install -y \
#     libgstreamer1.0-dev \
#     libgstreamer-plugins-base1.0-dev \
#     && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# ARG OPENCV_GIT_VERSION=3.4.12
# WORKDIR /root
# RUN git clone -b ${OPENCV_GIT_VERSION} https://github.com/opencv/opencv.git && \
#     git clone -b ${OPENCV_GIT_VERSION} https://github.com/opencv/opencv_extra.git && \
#     git clone -b ${OPENCV_GIT_VERSION} https://github.com/opencv/opencv_contrib.git
# RUN mkdir opencv/build
# WORKDIR /root/opencv/build

# RUN mkdir build && cd build && \
#         cmake   -D CMAKE_BUILD_TYPE=RELEASE \
#                 -D BUILD_NEW_PYTHON_SUPPORT=ON \
#                 -DCMAKE_INSTALL_PREFIX=/usr/local \
#                 -DBUILD_PNG=ON \
#                 -DBUILD_TIFF=OFF \
#                 -DBUILD_TBB=ON \
#                 -DBUILD_JPEG=ON \
#                 -DBUILD_JASPER=OFF \
#                 -DBUILD_ZLIB=OFF \
#                 -DBUILD_EXAMPLES=OFF \
#                 -DBUILD_opencv_java=OFF \
#                 -DBUILD_opencv_python2=ON \
#                 -DBUILD_opencv_python3=ON \
#                 -D INSTALL_C_EXAMPLES=OFF \
#                 -D INSTALL_PYTHON_EXAMPLES=OFF \
# 				-D WITH_TBB=ON \
# 				-D WITH_V4L=ON \
# 				-D WITH_LIBV4L=ON \
# 				-D WITH_OPENGL=ON \
#                 -DENABLE_NEON=OFF \
#                 -DENABLE_PRECOMPILED_HEADERS=OFF \
#                 -DWITH_OPENCL=OFF \
#                 -DWITH_OPENMP=OFF \
#                 -DWITH_FFMPEG=ON \
#                 -DWITH_GSTREAMER=ON \
#                 -DWITH_GSTREAMER_0_10=OFF \
#                 -DWITH_CUDA=ON \
#                 -DWITH_GTK=ON \
#                 -DWITH_VTK=OFF \
#                 -DWITH_1394=OFF \
#                 -DWITH_OPENEXR=OFF \
#                 -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
#                 -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-3.4.0/modules \
#                 -D BUILD_EXAMPLES=OFF /opt/opencv-3.4.0 ..
# RUN make package -j$(($(nproc) - 1)) && rm -rf /root/opencv*

# WORKDIR /root/

# # Fixed the issue: "Cannot run ros with python3 and cannot import cv2 from python3"
# # This issue is caused by ROS that creates it's own cv2.so file for python 2, and then routes every import request to that file
# RUN cd /usr/local/lib/python3.6/dist-packages 
# RUN ln -s /usr/local/lib/python2.7/dist-packages/cv2.so cv2.so
# RUN cd /opt/ros/melodic/lib/python2.7/dist-packages
# RUN mkdir bak && mv cv2.so ~/bak/cv2.so.bak 


# Instsall Realsense2 library
RUN apt-get install -y software-properties-common apt-utils && apt-get update
RUN apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key && \
				add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo bionic main" -u && \
				apt-get update && \
                apt-get install -y \
							librealsense2-dev \
							librealsense2-utils

RUN apt-get install -f && apt-get install -y \
		libglew-dev \
		sudo \
		dkms \
		cmake-qt-gui \
		mesa-utils \
        libgl1-mesa-glx \
        vim


RUN rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

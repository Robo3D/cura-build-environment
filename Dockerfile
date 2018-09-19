FROM centos:centos7

# Environment vars for easy configuration
ENV CURA_BENV_BUILD_TYPE=Release
ENV CURA_BENV_GIT_DIR=/root/cura-build-environment

# Install package repositories
RUN yum -y update && yum install -y epel-release
RUN yum update -y && yum install -y centos-release-scl-rh
RUN yum update -y && yum install -y centos-release-scl

# Install dependencies
RUN yum update -y && yum install -y \
    devtoolset-3-gcc \
    devtoolset-3-gcc-c++ \
    devtoolset-3-gcc-gfortran \
    cmake3 \
    curl \
    git \
    make \
    mesa-libGL \
    mesa-libGL-devel \
    openssl-devel \
    tar \
    which \
    x11vnc \
    xorg-x11-server-Xvfb \
    tigervnc-server \
    xterm \
    xdotool \
    libX11-devel \
    xz \
    zlib-devel \
    fuse \
    fuse-devel \
    glib-devel \
    glib2-devel \
    google-noto-fonts-common*


# Enable devtools-3
ENV PATH=${PATH}:/opt/rh/devtoolset-3/root/usr/bin

# Init xstartup
ADD ./xstartup /
RUN mkdir /.vnc
RUN x11vnc -storepasswd 123456 /.vnc/passwd
RUN cp -f ./xstartup /.vnc/.
RUN chmod -v +x /.vnc/xstartup

# Note: make sure to run the following lines before your UI application:
#   Xvfb :1 -screen 0 1600x1200x16 & export DISPLAY=:1.0

# Set up the build environment
RUN mkdir $CURA_BENV_GIT_DIR
WORKDIR $CURA_BENV_GIT_DIR
COPY . ./
#RUN git clone https://github.com/Robo3D/cura-build-environment 
#&& rm $CURA_BENV_GIT_DIR/cura-build-environment/projects/appimagekit.cmake

# Build the build environment
RUN mkdir $CURA_BENV_GIT_DIR/build
WORKDIR $CURA_BENV_GIT_DIR/build
RUN cmake3 .. -DCMAKE_BUILD_TYPE=$CURA_BENV_BUILD_TYPE
RUN make -j4

WORKDIR /
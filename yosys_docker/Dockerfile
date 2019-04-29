FROM ubuntu:18.04
MAINTAINER frank@kapernikov.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install build-essential clang bison flex libreadline-dev \
                     gawk tcl-dev libffi-dev git mercurial graphviz   \
                     xdot pkg-config python python3 libftdi-dev \
                     qt5-default python3-dev libboost-all-dev cmake libeigen3-dev python3-pip \
                     verilator iverilog
 
RUN git clone https://github.com/cliffordwolf/icestorm.git icestorm \ 
	&& cd icestorm \
	&& make -j$(nproc) \
	&& make install

RUN git clone https://github.com/cseed/arachne-pnr.git arachne-pnr \
	&& cd arachne-pnr \
	&& make -j$(nproc) \
	&& make install

RUN git clone https://github.com/YosysHQ/nextpnr nextpnr \
	&& cd nextpnr \
	&& cmake -DARCH=ice40 -DCMAKE_INSTALL_PREFIX=/usr/local . \
	&& make -j$(nproc) \
	&& make install

RUN git clone https://github.com/cliffordwolf/yosys.git yosys \
	&& cd yosys \
	&& make -j$(nproc) \
	&& make install

RUN git clone https://github.com/cliffordwolf/icotools

RUN pip3 install fusesoc && /bin/bash -c "echo -e '\n\n' | fusesoc init"



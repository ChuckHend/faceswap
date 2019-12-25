FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:git-core/ppa && \
    apt-get update && \
    apt-get install -y git build-essential cmake && \
    git --version

RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    vim \
    mercurial \
    subversion \
    cmake \
    libboost-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    gcc \
    g++ \
    python3-pip

RUN wget https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh && \
    /bin/bash Anaconda3-5.2.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm Anaconda3-5.2.0-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH

COPY ./requirements.txt .
RUN pip install msgpack \
    && pip install --upgrade pip \
    && pip install -r ./requirements.txt \
    && rm requirements.txt

CMD python -c "import time; time.sleep(2000)"
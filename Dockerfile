FROM nvidia/cuda:8.0-devel-centos7 as build

RUN yum install -y \
        gcc-c++ \
        ca-certificates \
        wget \
        cuda-cudart-dev-8-0 \
        cuda-misc-headers-8-0 \
        cuda-nvml-dev-8-0 && \
    rm -rf /var/cache/yum/*

ENV GOLANG_VERSION 1.10.3
RUN wget -nv -O - https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz \
    | tar -C /usr/local -xz
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

ENV CGO_CFLAGS "-I /usr/local/cuda-8.0/include"
ENV CGO_LDFLAGS "-L /usr/local/cuda-8.0/lib64"
ENV PATH=$PATH:/usr/local/nvidia/bin:/usr/local/cuda/bin

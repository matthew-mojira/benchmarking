FROM gcc:16-trixie AS base

RUN apt-get update \
 && apt-get install -y --no-install-recommends python3-venv
RUN python3 -m venv /opt/pyperformance \
 && /opt/pyperformance/bin/pip install pyperformance==1.14.0

WORKDIR /build

COPY build/cpython.sh build/
COPY versions/cpython.tsv versions/

# cpython

FROM base AS cpython-3.10.22-default
RUN bash build/cpython.sh 3.10.22 default

FROM base AS cpython-3.10.22-opt
RUN bash build/cpython.sh 3.10.22 opt

FROM base AS cpython-3.11.18-default
RUN bash build/cpython.sh 3.11.18 default

FROM base AS cpython-3.11.18-opt
RUN bash build/cpython.sh 3.11.18 opt

FROM base AS cpython-3.12.16-default
RUN bash build/cpython.sh 3.12.16 default

FROM base AS cpython-3.12.16-opt
RUN bash build/cpython.sh 3.12.16 opt

FROM base AS cpython-3.13.18-default
RUN bash build/cpython.sh 3.13.18 default

FROM base AS cpython-3.13.18-opt
RUN bash build/cpython.sh 3.13.18 opt

FROM base AS cpython-3.13.18-jit
# Install LLVM
RUN apt-get install -y --no-install-recommends clang-18 llvm-18
RUN bash build/cpython.sh 3.13.18 jit

FROM base AS cpython-3.14.10-default
RUN bash build/cpython.sh 3.14.10 default

FROM base AS cpython-3.14.10-opt
RUN bash build/cpython.sh 3.14.10 opt

FROM base AS cpython-3.14.10-jit
# Install LLVM
RUN apt-get install -y --no-install-recommends clang-19 llvm-19
RUN bash build/cpython.sh 3.14.10 jit

FROM base AS cpython-3.15.2-default
RUN bash build/cpython.sh 3.15.2 default

FROM base AS cpython-3.15.2-opt
RUN bash build/cpython.sh 3.15.2 opt

FROM base AS cpython-3.15.2-jit
# LLVM 21 manually
RUN mkdir -p /etc/apt/keyrings \
 && curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key -o /etc/apt/keyrings/llvm.asc \
 && echo "deb [signed-by=/etc/apt/keyrings/llvm.asc] https://apt.llvm.org/trixie/ llvm-toolchain-trixie-21 main" > /etc/apt/sources.list.d/llvm.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends clang-21 llvm-21
RUN bash build/cpython.sh 3.15.2 jit
